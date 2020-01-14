

Flutter学习第三周，继续学习Widget。

# 1. 装饰容器-DecoratedBox

DecoratedBox用于绘制一些背景、边框、渐变等。

```dart
const DecoratedBox({
    @required this.decoration,//绘制的装饰，接受抽象类Decoration
    this.position = DecorationPosition.background,//绘制位置，接受DecorationPosition的枚举值，background表示背景，foreground表示前景
    Widget child,
})
```

BoxDecoration是decoration的子类，实现了常用的转世元素。

```dart
BoxDecoration({
  Color color, //颜色
  DecorationImage image,//图片
  BoxBorder border, //边框
  BorderRadiusGeometry borderRadius, //圆角
  List<BoxShadow> boxShadow, //阴影,可以指定多个
  Gradient gradient, //渐变
  BlendMode backgroundBlendMode, //背景混合模式
  BoxShape shape = BoxShape.rectangle, //形状
})
```

# 2.变换 - Transform

Transform可以对子控件做变换。四个常用的方法。

- `Transform.translate`：平移，接受一个offset属性，指定x，y平移距离。
- `Transform.rotate`：旋转，接受angle属性，指定旋转角度。RotatedBox可实现相同功能，不同的是这个控件绘制在layout阶段，会改变空间大小。
- `Transform.scale`：缩放，接受scale属性。

```dart
const Transform({
...
@required Matrix4 transform,//变换样式
Offset origin,//旋转点，相对于左上顶点的偏移。
AlignmentGeometry alignment,//对齐方式
bool transformHitTests: true,//点击区域是否也做相应的改变
Widget child
})
```

# 3. 容器类组合容器 - Container

Container是一个组合类组件，他是DecoratedBox,ConstrainedBox,Transform,Padding,Align的组合。

```dart
Container({
  this.alignment,//对齐方式
  this.padding, //容器内补白
  Color color, // 背景色
  Decoration decoration, // 背景装饰
  Decoration foregroundDecoration, //前景装饰
  double width,//容器的宽度
  double height, //容器的高度
  BoxConstraints constraints, //容器大小的限制条件
  this.margin,//容器外补白，不属于decoration的装饰范围
  this.transform, //变换
  this.child,
})
```

# 4. 路由 - Scaffold

Scaffed是一个路由页的框架，使用它剋拼出很完整的页面。

```dart
const Scaffold({
   	 ...
    PreferredSizeWidget appBar,//导航栏
    Widget body,//主体
    Widget floatingActionButton,//漂浮按钮
    Widget drawer,//抽屉菜单
    Widget endDrawer,//右侧菜单
    Widget bottomNavigationBar,//底部导航栏
})
```

```dart
AppBar({
  this.leading, //导航栏最左侧Widget，常见为抽屉菜单按钮或返回按钮，添加抽屉菜单会默认设置成菜单按钮。
  this.automaticallyImplyLeading = true, //如果leading为null，是否自动实现默认的leading按钮
  this.title,// 页面标题
  this.actions, // 导航栏右侧菜单
  this.bottom, // 导航栏底部菜单，通常为Tab按钮组(用TabBar包装起来，可以与TabBarView绑定同一个控制器实现同步切换)
  this.elevation = 4.0, // 导航栏阴影
  this.centerTitle, //标题是否居中 
  this.backgroundColor,
  ...   
})
```

# 5. 裁剪 - Clip

用于对组件进行剪裁。

- ClipOval：内贴圆形
- ClipRRect：圆角矩形
- ClipRect：剪切到实际占用的矩形大小

# 6. SingleChildScrollView

SingleChildScrollView包装一个单独的widget，当超出屏幕厚可滚动。

```dart
SingleChildScrollView({
    Axis scrollDirection = Axis.vertical, //滚动方向，默认是垂直方向
    bool reverse = false, //阅读方向相反
    EdgeInsetsGeometry padding, 
    bool primary, //是否使用默认的控制器
    ScrollPhysics physics, //响应用户操作
    ScrollController controller,//滚动位置控制和监听滚动事件
    this.child,
})
```

# 7. ListView

ListView可以沿着一个方向线性布局所有控件。

- ListView()：接受一个Widget列表，只适合少量widget。他会提前创建好所有子Widget.

```dart
ListView({
  ...  
  //ListView各个构造函数的共同参数  
  double itemExtent,//强制决定子控件的长度，为null会进行计算
  bool shrinkWrap = false,//是否根据子组件的总长度来设置ListView的长度
  bool addAutomaticKeepAlives = true,//是否包含在AutomaticKeepAlive中，如果包裹，完全划出也不会被GC，如果列表自己维护KeepAlive，此参数必须为false
  bool addRepaintBoundaries = true,//该属性表示是否将子组件包裹在RepaintBoundary组件中。当可滚动组件滚动时，将列表项包裹在RepaintBoundary中可以避免列表项重绘
  double cacheExtent,
  //子widget列表
  List<Widget> children = const <Widget>[],
})
```

- ListView.builder()：列表项比较的的情况。

```dart
ListView.builder({
  // ListView公共参数已省略  
  ...
  @required IndexedWidgetBuilder itemBuilder,//列表项构造器，返回一个widget
  int itemCount,//数量
  ...
})
```

- ListView.separated()：在列表项之间添加一个分割组件。

```dart
ListView.separated({
    ...
    //拥有builder()所有方法
    Widget separatorBuilder;//分割器
})
```

# 8. 网络列表 - GridView

GridView可以构建一个二维网络列表。大多数属性和ListView相同。

```dart
GridView({
  ...
  @required SliverGridDelegate gridDelegate, //控制子widget layout的委托
  List<Widget> children = const <Widget>[],
})
```

Flutter提供SliverGridDelegate两个子类：

SliverGridDelegateWithFixedCrossAxisCount：实现一个横轴为固定数量子元素的Layout

```dart
SliverGridDelegateWithFixedCrossAxisCount({
  @required double crossAxisCount, //横轴元素个数，并确定子元素的长度
  double mainAxisSpacing = 0.0,//主轴方向间距
  double crossAxisSpacing = 0.0,//横轴方向间距
  double childAspectRatio = 1.0,//子元素横纵比
})
```

SliverGridDelegateWithMaxCrossAxisExtent：实现一个横轴子元素为固定最大长度的Layout

```dart
SliverGridDelegateWithMaxCrossAxisExtent({
  double maxCrossAxisExtent,//子元素最大长度
  double mainAxisSpacing = 0.0,//主轴间距
  double crossAxisSpacing = 0.0,//横轴间距
  double childAspectRatio = 1.0,//子元素横纵比
})
```

# 9. 滚动组合组件 - CustomScrollView

CustomscrollView可以包含多种滚动模型。CustrmScrollView的子控件必须是Sliver，大多数的控件都有对应的Sliver，比如SliverPadding,SliverAppBar,SliverList,SliverGrid等。

```
CustomScrollView({
	...
	List<Widget> slivers;
})
```



# 10. 导航返回拦截 - WillPopScope

WillPopScope用于一些防误触操作。

```dart
const WillPopScope({
  ...
  @required WillPopCallback onWillPop,//点击返回按钮时回调，返回一个Future，如果最终值为true时，返回。
  @required Widget child
})
```

# 11. 数据共享 - InheritedWidget

InheritedWidget用于共享数据。他会在Widget树中从上到下的传递。



# 12. 主题 - Theme

在`Flutter`中使用ThemeData来在应用中共享颜色和字体样式，Theme有两种：全局Theme和局部Theme。 全局Theme是由应用程序根`MaterialApp`创建的Theme 。

可使用Theme.of(context).copyWith()扩展父主题。

```dart
ThemeData({
  Brightness brightness, //深色还是浅色
  MaterialColor primarySwatch, //主题颜色样本，见下面介绍
  Color primaryColor, //主色，决定导航栏颜色
  Color accentColor, //次级色，决定大多数Widget的颜色，如进度条、开关等。
  Color cardColor, //卡片颜色
  Color dividerColor, //分割线颜色
  ButtonThemeData buttonTheme, //按钮主题
  Color cursorColor, //输入框光标颜色
  Color dialogBackgroundColor,//对话框背景颜色
  String fontFamily, //文字字体
  TextTheme textTheme,// 字体主题，包括标题、body等文字样式
  IconThemeData iconTheme, // Icon的默认样式
  TargetPlatform platform, //指定平台，应用特定平台控件风格
  ...
})
```



# 13. 异步UI更新(1) - FutureBuilder

FutureBuilder会依赖一个Future，它会根据所依赖的Future的状态来动态构建自身。

```DART
FutureBuilder<T>({
  this.future<T>,//依赖的Future
  this.initialData,//初始数据
  @required this.builder,//回调，构建器为Function(BuildContext context,AsyncSnapshot snapshot)
})
```

# 14. 异步UI更新(2) - StreamBuilder

```dart
StreamBuilder<T>({
  this.initialData,
  Stream<T> stream,//依赖的Stream
  @required this.builder,
})
```

