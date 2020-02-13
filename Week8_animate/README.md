

flutter动画的原理就是在一段时间内，快速的多次改变UI外观，就会看起来是一个连续的动画。

flutter中动画的实现需要几个核心角色：

- Animation：动画对象。
- AnimationController：动画的控制器，能够控制动画的播放，停止等。需要释放资源。
- Tween：变换的类型，类如int，double，Color等等。
- Curve：控制动画的曲线，如果不设置则是线性。

# 1. 一个简单的例子

先看一个简单的例子，实现一个Widget的放大过程，然后分析其中的步骤。

```dart
import 'package:flutter/material.dart';

///
/// author：wangbufan
/// time: 2020/1/30
/// email: wangbufan00@gmail.com
///

class AnimationPage extends StatefulWidget {
  static launch(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => Animation1Page(),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<Animation1Page>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = Tween(begin: 0.0, end: 300.0).animate(animation)
      ..addListener(() {
      		setState(() {});
   	 	}
    );
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        width: animation.value,
        child: Image.asset('images/girl.jpg'),
      ),
    );
  }
}
```

## 1.1. Controller

controller用于动画的控制，他的定义传递了两个值，第一个是动画的时长。第二个值是一个TickerProvider类型的对象，他的职责是创建一个Ticker对象，Ticker来驱动动画，一般将他绑定到屏幕刷新的回调，这样每次当屏幕刷新的时候 ，就会调用动画的执行。

通常我们会将`SingleTickerProviderStateMixin`添加到`State`的定义中，然后将State对象作为`vsync`的值，这样就可以将两者绑定起来。(注意：`SingleTickerProviderStateMixin`是单动画，多动画实现`TickerProviderStateMixin`)。

他的一些常用方法：

- forward()：正向播放动画。
- stop()：停止动画。
- reset()：重置动画。
- reverse()：反向播放动画，必须处于正向播放完成的状态才可用。
- dispose()：资源释放。

## 1.2. Curve

Curve控制动画执行曲线，可以指定它为匀速，匀减速等等，他的内部具有很多枚举值。关于他的具体效果可以在[这里](https://api.flutter.dev/flutter/animation/Curves-class.html)看到。

## 1.3. Tween

默认情况下，Controller的对象范围是0-1，可以使用Tween来添加映射生成不同范围的值，然后调用animate()方法，然后传入一个控制器对象。

## 1.4. Animation

Animation是一个抽象类，保存动画的状态和插值，在动画的每一帧，可以通过Animation对象的value属性获得动画的当前状态值。

我们可以通过给Animation设置监听的方法更新UI，即在`addListener()`中调用`setState()`来触发重建。

我们还可以监听动画的状态，即在`addStatusListener()`中检测动画的状态，动画的状态具有四个枚举值：

- dismissed：在起始状态停止。
- forward：正在正向执行。
- reverse：正在反向执行。
- completed：在终点停止。

如此，如果我们想要循化执行动画，只需要：

```dart
controller =
    AnimationController(duration: Duration(seconds: 1), vsync: this);
animation = CurvedAnimation(parent: controller, curve: Curves.linear);
animation = Tween(begin: 0.0, end: 300.0).animate(animation)
  ..addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      controller.forward();
    }
  })
   ..addListener(() {
      		setState(() {});
   	 	}
    );
controller.forward();
```



# 2. 动画的简化

再上一个，我们刷新动画是使用setState()，他说书信全局的方法，但是动画执行只需要我们刷新局部，所以需要一定的封装。

## 2.1. AnimatedBuilder

AnimatedBuilder将渲染逻辑分离出来，类如：

```dart
 Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation: animation,
          child: Image.asset('images/girl.jpg')
          builder: (context, child) {
            return Center(
              child: Container(
                color: Colors.grey,
                width: animation.value,
                child: child,
              ),
            );
          }),
    );
  }
```

这样，就不需要添加监听了。

注意：其中child可能被传递两次。

## 2.2. AnimatedWidget

有一些常用的动画效果，我们可将它封装起来，便于复用。

类如，我们可以封装一个变大变小的动画，我们通过继承AnimatedWidget来实现，它封装了setState()方法。

```dart
class SizeAnimated extends AnimatedWidget {
  SizeAnimated({Key key, Animation<double> animation,this.child})
      : super(key: key, listenable: animation);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
        width: animation.value,
        child: child,
      ),
    );
  }
}
```

然后我们只需：

```dart
Widget build(BuildContext context) {
    return Scaffold(
      body: SizeAnimated(
        animation: animation,
        child: Image.asset('images/girl.jpg'),
      ),
    );
  }
```

事实上翻阅AnimatedWidget的源代码，就可以看到，官方已经为我们封装好了很多的动画组件，类如Rotation，Scale等等，可以查阅。

# 3. 动画的组合

一个复杂的动画通常由若干个简单动画组合而成，这里动画的组合的方法是将多个animation绑定到一个Controller上进行控制。例如：

```dart
var animationController = new AnimationController(vsync: this,duration: Duration(milliseconds: 1500));
var animation1 = Tween<double>(begin: 100.0, end: 100.0*2.0).animate(animationController);
var animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);

animationController.forward();

```

如此即可同时执行这些动画。

另外还有一种情况，如果我们需要先执行完一个动画，然后再执行另一个动画，只是就需要给每个Animation指定间隔。

前面说过，Controller值再0-1，我们就需要分割这段时间，类如，实现一个柱状图增长的动画，动画的前0.6高度增长，后0.4沿着x轴平移。

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// author：wangbufan
/// time: 2020/2/3
/// email: wangbufan00@gmail.com
///

class StaggerAnimationWidget extends StatelessWidget {
  StaggerAnimationWidget({Key key, this.controller}) : super(key: key) {
    height = Tween<double>(begin: .0, end: 300.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.6, curve: Curves.ease),
      ),
    );

    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.6, curve: Curves.ease),
      ),
    );

    padding = Tween<EdgeInsets>(
      begin: EdgeInsets.only(left: .0),
      end: EdgeInsets.only(left: 100.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.6, 1.0, curve: Curves.ease),
      ),
    );
  }

  final Animation<double> controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

  Widget _buildAnimation(context, child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }
}

```

在其中，定义了三个动画，分别是height，color，padding。

通过Interval给每个动画设置起始点和终点，让动画达到连续的效果。