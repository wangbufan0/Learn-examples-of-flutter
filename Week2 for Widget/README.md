


Flutter学习第二周，学习Flutter中常用的一些Widget。

widget是FLutter的基石，用它来描述页面，但他和最终的渲染和显示并没有关系，他只是对视图信息的描述，并且是不可变的，所以可以以极低的代价重构Widget树。
Element是Widget的实现，通过遍历Widget树生成Element树，Element树是可变的，他对Widget的变换做了抽象，当widget树发生变化的时候，只将真正更改的部分同步到RenderObject树即可，而RenderObject树才是真正用于显示的树。
而对于目前而言，只需要对Element和renderobject做了解，因为这是Flutter设计的巧妙，开发的时候，更多的接触是Widget。


# 1. 文本-Text

`Text`用于显示简单文本，他的构造函数如下。参数详情和常用值：[Text 参数详解](https://blog.csdn.net/chenlove1/article/details/84574651)

```dart
const Text(
String data,
{
...
TextAlign textalign,//文本对齐方式
int maxLines,
TextOverflow overflow,//截断方式
double textScaleFactor,//缩放因子
TextStyle style,//文本显示样式
}
)
```

# 2. 富文本-TextSpan

`TextSpan`用于实现富文本，他代表一个片段，它可以有多个子控件，一般是将富文本分割成几个TextSpan然后外面再用一个TextSpan合起来，然后传递给`Text.rich()`或者`RichText()`构建显示。

```dart
const TextSpan({
  TextStyle style, //文本显示样式
  Sting text,
  List<TextSpan> children,
  GestureRecognizer recognizer,//手势识别(点击)
});
```



# 3. 默认文本样式-DefaultTextStyle

`DefaultTextStyle`不用于显示，而是特用于样式设置，他的子孙节点的Text都继承他的文本样式。

当子孙节点不想继承样式，可将自己的style中的`inherit`设置为false。

# 4. 按钮-MaterialButton

官方三个常用控件的父类，基本上子类有相同的参数，官方不推荐直接使用这个控件，而是使用他的子控件：

- `RaisedButton`：有阴影，圆角
- `FlatButton`：没有阴影，没有圆角，没有边框，背景透明
- `OutlineButton`：没有阴影，有圆角的边框

```dart
const MaterialButton({
    ...
    @required VoidCallback onPressed,//点击回调
    Color textColor,//文本颜色
    Color disabledTextColor,//禁用时文本颜色
    Color color,//按钮颜色
    Color disabledColor,//禁用时按钮颜色
    Color highlightColor,//长按按钮颜色
    Color splashColor,//点按水波颜色
    double elevation,//阴影范围
    EdgeInsetsGeometry padding,//边距
    ShapeBorder shape,//外形
    Widget child,//文本控件
})
```

# 5. 带图标的按钮-IconButton

 `IconButton`是一个可点击的Icon，不包括文字，默认没有背景，点击后会出现背景 。通过向`icon`参数传递一个`Icon`实例实现。

 `RaisedButton`、`FlatButton`、`OutlineButton`都有一个`icon()` 构造函数 ，通过向他传递一个icon，创建既有icon也有文字的按钮。



# 6. 图片-Image

图片加载通过Image的image属性实现，分为AssetImage(加载本地图片)和NetworkImage(加载网络图片)，他们都是ImageProvider的实现类，加载本地图片需要在`pubspec.yaml`中声明。

也可分别通过`Image.asset()`和`Image.network()`加载本地和网络图片。

关于其他属性的示例查看[Image 参数详解](https://blog.csdn.net/chenlove1/article/details/84111554 )

```dart
const Image({
    ...
    ImageProvider image,//获取图像
    double width, //图片的宽
    double height, //图片高度
    Color color, //图片的混合色值
    BlendMode colorBlendMode, //混合模式
    BoxFit fit,//缩放模式
    AlignmentGeometry alignment = Alignment.center, //对齐方式
    ImageRepeat repeat = ImageRepeat.noRepeat, //重复方式
    ...
})
```



# 7. 单选框-Switch

Switch用于单选，主要属性如下，一目了然。

可以通过SwitchListTile设置带标题的开关，属性基本一致，只需要向title传递一个Text，即可设置文本。

```dart
const Switch({
    ...
    bool value,//开关状态
    ValueChanged onChanged,//监听
    Color activeColor,//激活时原点颜色
    Color activeTrackColor,//激活时横条颜色
    Color inactiveThumbColor,//非激活远点颜色
    Color inactiveTrackColor,//非激活横条颜色
    ImageProvider activeThumbImage,//激活时效果，图片
    ImageProvider inactiveThumbImage,//非激活时图片
  }) 
```

# 8. 复选框-Checkbox

Checkbox与Switch基本类似，对照使用，同样也有SwitchListTile。

# 9. 文本输入-TextField

文本输入大致属性如下，关于细节查阅[TextField属性](https://blog.csdn.net/yuzhiqiang_1993/article/details/88204031)

```dart
const TextField({
  ...
  TextEditingController controller, //控制器，用来于编辑框进行交互。
  FocusNode focusNode,//焦点控制
  InputDecoration decoration = const InputDecoration(),//外观
  TextInputType keyboardType,//文本输入类型
  TextInputAction textInputAction,//键盘回车图标
  TextStyle style,//文本样式
  TextAlign textAlign = TextAlign.start,//对齐方式
  bool autofocus = false,//自动获得焦点
  bool obscureText = false,//隐藏文本
  int maxLines = 1,//行数，设置null不限
  int maxLength,//输入的字数
  bool maxLengthEnforced = true,//字数够了之后，是否禁止输入
  ValueChanged<String> onChanged,//回调监听，也可通过控制器建通
  VoidCallback onEditingComplete,//输入完成的回调，键盘的回车键
  ValueChanged<String> onSubmitted,//也是输入的回调，有个传入值
  List<TextInputFormatter> inputFormatters,//输入格式
  bool enabled,//false禁用
  this.cursorWidth = 2.0,//光标宽度
  this.cursorRadius,//圆角
  this.cursorColor,//颜色
  ...
})
```



# 10. 表单-Form

用于合法性检测。

```dart
Form({
  @required Widget child,//子孙元素必须为FormFiled，实现类时TextFormField
  bool autovalidate = false,//是否自动检测
  WillPopCallback onWillPop,//用于拦截返回按钮
  VoidCallback onChanged,//任意一个子类发生变化触发此回调
})
```

```dart
const FormField({
  ...
  FormFieldSetter<T> onSaved, //保存回调
  FormFieldValidator<T>  validator, //验证回调
  T initialValue, //初始值
  bool autovalidate = false, //是否自动校验。
})
```

可以通过`Form.of()`或`GlobalKey`获得`FormState`，`FormState`为`Form`的`State`类。我们可以通过它来对`Form`的子孙`FormField`进行统一操作。

- `FormState.validate()`：调用此方法后，会调用`Form`子孙`FormField的validate`回调，如果有一个校验失败，则返回false，所有校验失败项都会返回用户返回的错误提示。
- `FormState.save()`：调用此方法后，会调用`Form`子孙`FormField`的`save`回调，用于保存表单内容
- `FormState.reset()`：调用此方法后，会将子孙`FormField`的内容清空。

# 11. 进度条-Progress

进度条分为两个，`LinearProgressIndicator(线性，条状)`和`CirularProgressIndicator(圆形)`。

```dart
 CircularProgressIndicator({
  double value,//进度，null会循环执行动画
  Color backgroundColor,//背景颜色
  Animation<Color> valueColor,//指示器颜色，可以指定动画，通过AlwaysStoppedAnimation设置单一颜色
  this.strokeWidth = 4.0,//圆形进度条的粗细
  ...   
})
```

# 12. 线性布局-Row、Column

两个使用方式基本相同，区别就是主轴方向不同，Row主轴是横向，Column主轴是纵向。

```dart
Row({
  ...  
  TextDirection textDirection,//布局顺序，从左到右还是从右到左
  MainAxisSize mainAxisSize = MainAxisSize.max,//主轴方向占用的空间，max占用尽可能多的空间。
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,//主轴对齐方式
  VerticalDirection verticalDirection = VerticalDirection.down,  //另一个轴的对齐方向
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,//另一个轴的对齐方式
  List<Widget> children = const <Widget>[],//
})
```

# 13. 弹性布局-Flex

Flex是Row和Column的父类，设置方向后和两个子类没有区别。

```dart
Flex({
  ...
  Axis direction, //弹性布局的方向, Axis有两个实例，Axis.horizontal、Axis.vertical表示横向和纵向。
  List<Widget> children = const <Widget>[],
})
```

按比例分配使用Expanded控件，他有一个包装类Spacer，默认flex为1

```dart
const Expanded({
  int flex = 1, 
  @required Widget child,
})
```

# 14. 流式布局-Wrap

flex布局超出屏幕范围会报错，超出范围厚wrap会折行。

```dart
Wrap({
  ...
  this.direction = Axis.horizontal,//方向
  this.alignment = WrapAlignment.start,//主轴方向对齐方式
  this.spacing = 0.0,//主轴方向间距
  this.runAlignment = WrapAlignment.start,//另一个轴对齐方式
  this.runSpacing = 0.0,//纵轴方向间距
  this.crossAxisAlignment = WrapCrossAlignment.start,//纵轴对齐方式
  this.textDirection,//布局方向
  this.verticalDirection = VerticalDirection.down,//纵轴对齐方向
  List<Widget> children = const <Widget>[],
})
```

# 15. 层叠布局-Stack、Positioned

层叠布局允许层叠放置，通过绝对位置定位子控件，Positioned是子控件，根据Stack四个角确定子控件位置。

```dart
Stack({
  this.alignment = AlignmentDirectional.topStart,//如何对齐没有定位的子组件
  this.textDirection,//对其方向
  this.fit = StackFit.loose,//没有定位的子控件的大小，loose表示使用子控件的大小，expand表示扩伸到Stack的大小
  this.overflow = Overflow.clip,//如何显示超出显示空间的控件，clip超出部分被裁剪，visible不会
  List<Widget> children = const <Widget>[],
})
```

Position一个方向只能指定三个数星星中的两个，如指定left和width后，会自定计算出right。

```dart
const Positioned({
  this.left, //表示距离Dart左边的距离
  this.top,
  this.right,
  this.bottom,
  this.width,//控件大小
  this.height,
  @required Widget child,
})
```

# 16. 相对定位-Align

Align可以通过相对位置确定自控件位置，并且可以通过子控件宽高确定自身的宽高。

alignment确定子控件坐标轴，有两个常用的。

- Alignment(x,y)：x，y从-1到1，坐标原点位置，0，0表示矩形中心点。
- FractionlOffset(x,y):原点是左上角，0到1

Align有一个子类Center，他是指定alignment为Alignment.center的Align

```dart
Align({
  ...
  this.alignment = Alignment.center,
  this.widthFactor,//宽度缩放因子，乘以子控件的宽度，计算自身的宽度。
  this.heightFactor,//高度缩放因子
  Widget child,
})
```

# 17. 填充-Padding

EdgeInsets提供的方法：

- fromLTRB(left,top,right,bottom)：四个方向的填充
- all(value)：所有方向
- only({left,top,right,bottom})：具体方向
- symmetric({vertical,horizontal})：设置对称方向的填充，分别指定竖和横向。

```dart
Padding({
  ...
  EdgeInsetsGeometry padding,//一般使用EdgeInsets
  Widget child,
})
```

# 18. 尺寸限制-ConstrainedBox

ConstrainedBox主要用于限制子控件的最大、最小的大小。他只有两个属性`BoxConstraints constraints`和`child`，第一个用于设置限制条件。

BoxConstraints提供的方法：

- BoxConstraints({minWidth,maxWidth,minHeight,minHeight})
- BoxConstraints.tight(Size size)
- BoxConstraints.tightFor({width,height})
- BoxConstraints.Expand()

他有一个定制类SizeBox(width,height)，和上面第三个方法一致。



### 下一篇：[Flutter学习(三)-Widget2](http://wangbufan.cn/2019/12/08/Flutter%E5%AD%A6%E4%B9%A0(%E4%B8%89)%20-%20Widget2/)













