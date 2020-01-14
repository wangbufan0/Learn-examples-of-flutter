

本周学习到了第四周，学习了三个方面的东西。

1. Flutter与Android交互的方法。
2. Flutter中的异步：timer，Stream，以及扩展包RxDarat和BloC包。
3. Flutter中如何调用原生的View。




# 1. Flutter与Android的交互

FLutter与原生通信通过PatformChannel实现，他有三个实现方式，适用于不同的场景。三种channel都用到了三个属性。

- `name`：String类型，表示channel的名字，全局唯一的确定一个channel。
- `codec`：MessageChannel类型，消息的编码解码器，即通过什么数据类型发送数据。
- `binaryMessageer`：BinaryMessager类型，用于发送数据。

## 1.1. BasicMessageChannel

用于传递数据。

### 1.1.1. Flutter向Android发送消息

flutter代码

```dart
static const messageChannel = const BasicMessageChannel('basic_message_channel_sample', StandardMessageCodec());

Future<String> sendMessage() async {
    String reply = await messageChannel.send('发送给Native端的数据');
    print('reply: $reply');
    return reply;
}


@override
void initState() {
    super.initState();
    sendMessage();
}
```

Android代码

```java
BasicMessageChannel<Object> messageChannel = new BasicMessageChannel<Object>(getFlutterView(), "basic_message_channel_sample", StandardMessageCodec.INSTANCE);

// 接收消息监听
messageChannel.setMessageHandler(new BasicMessageChannel.MessageHandler<Object>() {
    @Override
    public void onMessage(Object o, BasicMessageChannel.Reply<Object> reply) {
        System.out.println("onMessage: " + o);
        reply.reply("返回给flutter的数据");
    }
});
```

### 1.1.2. Android向Flutter发送消息

这个代码不一定成功，因为可能Android端在发送数据的时候，FLutter还没有绑定过监听。

Flutter代码

```dart
static const messageChannel2 = const BasicMessageChannel('basic_message_channel_sample', StandardMessageCodec());

void receiveMessage() {
    messageChannel2.setMessageHandler((message) async {
        print('message: $message');
        return '返回Native端的数据';
    });
}

@override
void initState() {
    // TODO: implement initState
    super.initState();
    receiveMessage();
}

```

Android代码

```java
// 触发事件执行
BasicMessageChannel<Object> messageChannel2 = new BasicMessageChannel<Object>(getFlutterView(), "basic_message_channel_sample", StandardMessageCodec.INSTANCE);

// 发送消息
messageChannel2.send("发送给flutter的数据", new BasicMessageChannel.Reply<Object>() {
    @Override
    public void reply(Object o) {

        System.out.println("onReply: " + o);
    }
});

```



## 1.2. MethodChannel

传递方法的调用，Flutter主动调用Android的方法，以调用系统API。

Android调用Flutter的方法与BasicMesageChannel的相似，不再记录。

Flutter代码

```dart
static const platform = const MethodChannel('method_channel_sample_battery');

Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
        final int result = await platform.invokeMethod('getBatteryLevel');
        batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
        batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
        _batteryLevel = batteryLevel;
    });
}
///通过调用_getBatteryLevel，获得系统电量。
```

Android代码

```java
new MethodChannel(getFlutterView(), "method_channel_sample_battery").setMethodCallHandler(
    new MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall call, Result result) {
            // TODO
            if (call.method.equals("getBatteryLevel")) {
                int batteryLevel = getBatteryLevel();

                if (batteryLevel != -1) {
                    result.success(batteryLevel);
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null);
                }
            } else {
                result.notImplemented();
            }
        }
    }
);


private int getBatteryLevel() {
    int batteryLevel = -1;
    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
        BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
        batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
    } else {
        Intent intent = new ContextWrapper(getApplicationContext()).
            registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
        batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
            intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
    }

    return batteryLevel;
}

```



## 1.3. EventChannel

事件通信，建立流监听，数据流通信。

Flutter代码

```dart
static const EventChannel _eventChannel =
      const EventChannel('event_channel_sample');

 void _onEvent(Object event) {
    print('返回的内容: $event');
  }

  void _onError(Object error) {
    print('返回的错误');
  }
  
  @override
  void initState() {
    super.initState();
    // 监听开始
    _eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);

  }

```

Android代码

```java
new EventChannel(getFlutterView(), CHANNEL2).setStreamHandler(
    new EventChannel.StreamHandler() {
        @Override
        public void onListen(Object o, EventChannel.EventSink eventSink) {
            this.eventSink = eventSink;
            handler.sendEmptyMessageDelayed(1, 1000);
        }

        @Override
        public void onCancel(Object o) {

        }

        private EventChannel.EventSink eventSink;
        private int count = 0;
        private Handler handler = new Handler() {
            @Override
            public void handleMessage(Message msg) {
                super.handleMessage(msg);
                eventSink.success((count++) + "主动发送消息给flutter");
                sendEmptyMessageDelayed(1,1000);
            }
        };

    }
);

```

# 2. 异步

异步包

## 2.1. Timer - 倒数定时器

Timer用于创建一个倒计时，倒计时结束后调用回调。

Timer有两个构造函数。

```dart
///默认的构造函数，倒计时到了，执行一个任务。
Timer(Duration(seconds:3),(timer){});

///另一个构造方法，会周期的调用，下面是个60s倒计时的例子
Timer _countdownTimer;
int _countdownNum=59;
_countdownTimer=Timer.periodic(Duration(seconds:1),(Timer timer){
    if(_countdownNum==0){
        _countdownTimer.cancel();
    }else{
        _countdownNum--;
    }
    setState((){});
})

```

## 2.2. Stream - 流

流就像是一个管道，有一个入口。有一个出口，通过入口向管道输入数据，监听出口，当有新数据从管道出来的时候，进行处理。

使用流的概念将入口和出口分离，入口不在关心数据流向哪里，出口不在关心数据从哪里来，各个部分只是负责自己的事情。

Stream中的名词：

- sink：管道入口，通过它向管道传递值。
- stream：管道出口，通过它设置监听。
- StreamController：管道的控制，通过这个来定义一个流，并通过它uode上面两个接口。

流分为两种，默认是单订阅流，即只能有一个listener，不能有多个监听者，在绑定之前和之后，他都不会发送事件。另一种时广播流，允许任意数量的监听者，中途加进来的监听者不会收到之前的消息。单订阅流很容易可以转换为一个广播流。

```dart
///单订阅，输出 aaa,bbb,ccc
StreamController<String> streamController = StreamController();
streamController.stream.listen((data)=> print(data));
streamController.sink.add("aaa");
streamController.add("bbb");
streamController.add("ccc");
streamController.close();



/// 直接创建广播流，输出 bbb,bbb
StreamController<String> streamController = StreamController.broadcast();
streamController.stream.listen((data){
    print(data);
},onError: (error){
    print(error.toString());
});
streamController.stream.listen((data) => print(data));
streamController.add("bbb");


  
/// 单订阅转换为广播，输出 aaa,aaa
StreamController<String> streamController = StreamController();
Stream stream =streamController.stream.asBroadcastStream();
stream.listen((data) => print(data));
stream.listen((data) => print(data));
streamController.sink.add("aaa");
streamController.close();
```

Widget中的StreamBuilder接受一个stream，当有事件发送出来，重新构造子树。

```dart
const StreamBuilder({
    Key key,
    this.initialData,
    Stream<T> stream,
    @required this.builder,
  })
```



## 2.3. RxDart - 流的扩展

[RxDart官方](https://pub.dev/packages/rxdart)

RxDart是对Dart包中的流Stream的扩展，对一些功能进行了扩展，使用时需要导入包。

RxDart中的Observable对应Dart中的Stream，Subject对应StreamController。

RxDart最主要的扩展时对Subject的扩展，定义了三个类型。

### 2.3.1. PublishSubject

PublishSubject对用普通的广播StreamController，对应一个Observable。它仅向监听器发送在订阅之后添加到Stream的事件。

![](https://user-gold-cdn.xitu.io/2019/4/3/169df04ae64db378?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

### 2.3.2. BehaviorSubject

BehaviorSubject和普通广播的区别是它会将最后发送的事件发送给刚刚订阅的监听器。

![](https://user-gold-cdn.xitu.io/2019/4/3/169df04ae65bc227?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

### 2.3.3. ReplaySubject

ReplaySubject可以选择缓存的数量，如果不设置数量，他会把所有的事件发送给任何新监听器。

![](https://user-gold-cdn.xitu.io/2019/4/3/169df04ae6716d5f?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

一个简单的例子

```dart
final subject = new BehaviorSubject<int>();

subject.add(1);
subject.add(2);
subject.add(3);

subject.stream.listen(print); // prints 3
subject.stream.listen(print); // prints 3
subject.stream.listen(print);
```

## 2.4. BloC - 状态管理

### 2.4.1. 什么是BloC

[BloC包](https://pub.dev/packages/bloc)，[flutter_bloc包](https://pub.dev/packages/flutter_bloc)

BloC模式是利用流的概念来进行状态管理的一个框架。

上面两个包使得在Flutter中使用BloC十分简单。

这个框架的目的是去耦合，将各个部分进行分离。

一个Widget如果状态发生变化，它不会去关心这个状态会产生怎样的影响，这个状态会不会使别的Widget发生什么样的变换，它只做一件是，产生一个状态，就把这个事件传入到流当中，后面的事件就与自己无关。

当有一个Widget和一个流绑定，依据流的事件构建自己，他不会去关心这个事件来自于哪里，它只关心管道的出口，有一个事件流出，他就进行重构，将数据展示出来。

![](https://user-gold-cdn.xitu.io/2019/4/3/169df04ae71e2b7d?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

### 2.4.2. 使用BloC实现一个登录页面

使用BloC账户密码的检测以及界面重构。

#### 2.4.2.1. 实现FormState类

State类用来存储登陆的状态。

Equatable用于比较对象，实现他的props方法，当两个对象进行比较的时候，就会比较props中的数据。

在当前State类中，首先存储了邮箱和密码，然后有四个标志位，分别是邮箱是否符合规则，密码是否符合规则，表单是否否都符合规则，密码和邮箱是否对应。

类中实现copyWith方法，从当前的State加入新的状态创建一个新的State。

```dart
class MyFormState extends Equatable {
  final String email;
  final bool isEmailValid;
  final String password;
  final bool isPasswordValid;
  final bool formSubmittedSuccessfully;

  bool get isFormValid => isEmailValid && isPasswordValid;

  const MyFormState({
    @required this.email,
    @required this.isEmailValid,
    @required this.password,
    @required this.isPasswordValid,
    @required this.formSubmittedSuccessfully,
  });

  factory MyFormState.initial() {
    return MyFormState(
      email: '',
      isEmailValid: false,
      password: '',
      isPasswordValid: false,
      formSubmittedSuccessfully: false,
    );
  }

  MyFormState copyWith({
    String email,
    bool isEmailValid,
    String password,
    bool isPasswordValid,
    bool formSubmittedSuccessfully,
  }) {
    return MyFormState(
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      password: password ?? this.password,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      formSubmittedSuccessfully:
          formSubmittedSuccessfully ?? this.formSubmittedSuccessfully,
    );
  }

  @override
  List<Object> get props => [
        email,
        isEmailValid,
        password,
        isPasswordValid,
        formSubmittedSuccessfully,
      ];

  @override
  String toString() {
    return '''MyFormState {
      email: $email,
      isEmailValid: $isEmailValid,
      password: $password,
      isPasswordValid: $isPasswordValid,
      formSubmittedSuccessfully: $formSubmittedSuccessfully
    }''';
  }
}
```

#### 2.4.2.2. 创建FormEvent类

Event用于管道的输入，不同的事件对应不同的处理方法，对State产生不同的变换。

```dart
abstract class MyFormEvent extends Equatable {
  //所有的事件的基类
  const MyFormEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends MyFormEvent {
  //对应邮箱发生变换的事件，内部存储变换后的邮箱
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email: $email }';
}

class PasswordChanged extends MyFormEvent {
  //对应密码发生变换的事件，内部存储变换后的密码
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}
//提交表格，就是输入完成后点击登录的按钮的事件
class FormSubmitted extends MyFormEvent {}
//表格重置的事件，将状态清除
class FormReset extends MyFormEvent {}
```

#### 2.4.2.3. 创建FormBloc类

BloC类就需要继承自bloc包中的Bloc基类，这个类的作用即使管道中如何处理，通俗的说，就是当输入一个事件，怎样用这个事件产生一个状态并输出。

首先Bloc需要两个泛型，第一个就是管道中输入的事件，第二就是管道输出的事件。

Bloc基类有两个必须实现的接口：

- initialState：初始状态，就是没有事件发生之前的State，因为当刚开始构建Widget的时候，也是需要依据State，所以需要有一个初始的State。
- mapEventToState：根据输入的状态输出新的State。

```dart
class MyFormBloc extends Bloc<MyFormEvent, MyFormState> {
  //这个应该是正则表达式，用来检验表单是否符合规则，我看不懂
  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );
	
  //初始状态，调用FormState.initial()创建一个空的状态。
  @override
  MyFormState get initialState => MyFormState.initial();

  //这个是Bloc的另一个接口，用于打印日志
  @override
  void onTransition(Transition<MyFormEvent, MyFormState> transition) {
    print(transition);
  }

  //根据输入的状态输出新的State
  @override
  Stream<MyFormState> mapEventToState(MyFormEvent event) async* {
    if (event is EmailChanged) {
      //输入的事件是邮箱发生了变化，并用正则表达式检测邮箱
      yield state.copyWith(
        email: event.email,
        isEmailValid: _isEmailValid(event.email),
      );
    }
    if (event is PasswordChanged) {
      //输入的事件是密码发生了变化，并用正则表达式检测密码 
      yield state.copyWith(
        password: event.password,
        isPasswordValid: _isPasswordValid(event.password),
      );
    }
    if (event is FormSubmitted) {
      //在这里应该检测密码和账户是否对应，即向服务器验证密码，这里没有写出，就直接将标志位标志位正确
      yield state.copyWith(formSubmittedSuccessfully: true);
    }
    if (event is FormReset) {
      //表单清空
      yield MyFormState.initial();
    }
  }

  bool _isEmailValid(String email) {
      //正则表达式检测邮箱
    return _emailRegExp.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
      //正则表达式检测密码
    return _passwordRegExp.hasMatch(password);
  }
}
```

#### 2.4.2.4. 创建Form界面

对于刚才创建的BloC，在Widget中使用需要使用到flutter_bloc包。

##### 2.4.2.4.1. BlocProvider

BlocProvider用于为子元素提供相应Bloc的实例，通过`BlocProvider.of<T>(context)`获得。

1. 当你需要将这个Bloc作用于整个app，因为在整个app中都可能会用到其中的状态，可以将它设置为整个app的父Widget。

```dart
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyFormBloc>(
        create: (context)=>MyFormBloc(),
        child:  MaterialApp(
      		home:  MyForm(),       
   	    )
    );
  }
}
```

2. 当你想要将这个Bloc作用于一个page，可将他设置为一个page的根widget。

```dart
class MyForm extends StatefulWidget {
  static void launch(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return BlocProvider<MyFormBloc>(
          create: (context) => MyFormBloc(), 
          child: MyForm()
      );
    }));                                        
  } 
  State<MyForm> createState() => _MyFormState();
}
```

##### 2.4.2.4.2. BlocBuilder

使用BlocBuilder在BlocProvider的子Widget中，它会调用`BlocProvider.of<T>(context)`获得Bloc，对他进行监听，有事件流出进行重构，如果无法通过BlocProvider获得Bloc，可以直接给它设置一个Bloc的实例。

他需要两个泛型，第一个是Bloc的子类，第二个是Bloc中的数据类型，然后通过builder构建实际的界面。

```dart
class _MyFormState extends State<MyForm> {
  MyFormBloc _myFormBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _myFormBloc = BlocProvider.of<MyFormBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: BlocBuilder<MyFormBloc, MyFormState>(
        builder: (context, state) {
          if (state.formSubmittedSuccessfully) {
            ///做登录成功后的逻辑页面
          }
          return Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                  autovalidate: true,
                  validator: (_) {
                    return state.isEmailValid ? null : 'Invalid Email';
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  autovalidate: true,
                  validator: (_) {
                    return state.isPasswordValid ? null : 'Invalid Password';
                  },
                ),
                RaisedButton(
                  onPressed: state.isFormValid ? _onSubmitPressed : null,
                  child: Text('Submit'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _myFormBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _myFormBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onSubmitPressed() {
    _myFormBloc.add(FormSubmitted());
  }
}
```

# 3. 调用原生View

有些控件在flutter中没有，比如地图，这个时候就需要在flutter中插入与那声View。

以实现一个textView作为例子。

## 3.1. Android中的代码

在android目录中找到mainActivity，在这个包下面创建相关类。

### 3.1.1. 创建MyView

原生View不能直接继承自View，需要继承实现PlatformView，他是一个包装类，在getView中将原生View对象返回给FLutter。在其中还实现了MethodCallHandler接口，这里用于绑定，以便在flutter中调用View的相关方法，这里实现setText。

```java
public class MyView implements PlatformView ,MethodChannel.MethodCallHandler{

    private final TextView myNativeView;

    MyView(Context context, BinaryMessenger messenger, int id, Map<String, Object> params) {
        TextView myNativeView = new TextView(context);
        myNativeView.setText("我是来自Android的原生TextView");
        this.myNativeView = myNativeView;
        //params用于实现初始化
        if (params.containsKey("myContent")) {
            String myContent = (String) params.get("myContent");
            myNativeView.setText(myContent);
        }
	    //绑定channel
        MethodChannel methodChannel = new MethodChannel(messenger, "plugins.nightfarmer.top/myview_" + id);
        methodChannel.setMethodCallHandler(this);

    }

    @Override
    public View getView() {
        return myNativeView;
    }

    @Override
    public void dispose() {

    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if ("setText".equals(methodCall.method)) {
            String text = (String) methodCall.arguments;
            myNativeView.setText(text);
            result.success(null);
        }
    }
}
```

### 3.1.2. 创建Factory

在Factory获得MyView创建需要的相关参数，传递这些参数创建View。

```java
public class MyViewFactory extends PlatformViewFactory {
    private final BinaryMessenger messenger;

    public MyViewFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
    }

    @SuppressWarnings("unchecked")
    @Override
    public PlatformView create(Context context, int id, Object args) {
        Map<String, Object> params = (Map<String, Object>) args;
        return new MyView(context, messenger, id, params);
    }
}
```

### 3.1.3. 注册插件

创建FlutterPlugin类，并在MainActivity的onCreate()中注册。

```java
public class MyViewFlutterPlugin {
    public static void registerWith(PluginRegistry registry) {
        final String key = MyViewFlutterPlugin.class.getCanonicalName();

        if (registry.hasPlugin(key)) return;

        PluginRegistry.Registrar registrar = registry.registrarFor(key);
        registrar.platformViewRegistry().registerViewFactory("plugins.nightfarmer.top/myview", new MyViewFactory(registrar.messenger()));
    }
}
```

onCreate()中添加代码

```java
 MyViewFlutterPlugin.registerWith(this)
```

## 3.2. 在FLutter中调用

在Flutter中调用使用AndroidView实现，viewType需要和Android中的相对应。

```java
class NativeViewPage extends StatefulWidget {
  static void launch(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NativeViewPage()));
  }

  @override
  State createState() => _NativeViewPageState();
}

class _NativeViewPageState extends State<NativeViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native View'),
      ),
      body: Center(
        child: AndroidView(
          viewType: 'plugins.nightfarmer.top/myview',
          creationParams: {"myContent": "参数传值"},//初始化参数
          creationParamsCodec: StandardMessageCodec(),//传递编码方法
          onPlatformViewCreated: onMyViewCreated,//通过回调监听原始组件
        ),
      ),
    );
  }
  MethodChannel _channel;

  void onMyViewCreated(int id) {
    _channel = new MethodChannel('plugins.nightfarmer.top/myview_$id');
    setMyViewText('sss');
  }

  Future<void> setMyViewText(String text) async {
    assert(text != null);
    return _channel.invokeMethod('setText', text);
  }
}
```

