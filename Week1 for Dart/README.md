
Dart语言是flutter使用的语言，对flutter语法进行记录。

1. # 数据类型

- Nuber: int,double
- String 
- bool
- Collection:List,Set,Map,Queue

# 2. 循环

- while
- do...while
- for
- for...in
- break,continue

```dart
void main() { 
   var obj = [12,13,14]; 
   
   for (var prop in obj) { 
      print(prop); 
   } 
}
```

# 3. 判断语句

- if
- if...else
- else if
- swith...case

```dart
void main() { 
   var grade = "A"; 
   switch(grade) { 
      case "A": {  print("Excellent"); } 
      break; 
     
      case "B": {  print("Good"); } 
      break;
           
      default: { print("Invalid choice"); } 
      break; 
   } 
}
```

# 4. 方法

dart有可选参数，将最后一个参数用方括号[]括起来，就可以传递也可以不传递。

多个可选命名参数用花括号括起来，船只需要指定名称。还可分配默认参数。

```dart
void main() { 
   test_param(123); 
   test_param(123,s1:'hello'); 
   test_param(123,s2:'hello',s1:'world'); 
}  
test_param(n1,{s1,s2}) { 
   print(n1); 
   print(s1); 
}  
```

当函数简单可以用箭头

```dart
printMsg()=>
print("hello");
```



# 5. 接口

在dart中，任何类都是接口，当使用implements关键词就是当作接口。

```dart
class A{
  int get10(){return 10;}
}
class B{
  int get10000(){}
}
abstract class D{
  int get1();
}

class C extends D implements A,B{
  @override
  int get10000() {
    // TODO: implement get10000
    return 10000;
  }

  @override
  int get10() {
    // TODO: implement get10
    return 10;
  }
}
```

# 6. 类

类通过class声明，单继承关系，dart中没有public这些，想要设置私有变量，在属性名称和方法前面加上下划线。

```dart
class Person{
    String name;
	int _age;
}
```

不支持重载，多个构造函数的实现通过命名通过函数实现,如下面的from方法，名字可以随意指定。

```dart
class Person{
	String name;
	int _age;
	Person(this.name,[int age]){
        if(age==null) _age=_AVERAGE_AGE;
        else this._age=age;
    }
    Person.from(Person people){
        name=people.name;
        _age=people.getAge;
 	}
}
```

类默认创建默认的setter和getter，可以通过显示的定义覆盖默认值，通过`get`和`set`关键词创建。

```dart
  set setAge(age){
    if(age<=0)
      print('age<=0');
    else
      this._age=age;
  }
  int get getAge=>_age;
```

# 7. mixin

mixin主要的功能就是可以继承多个类，十分实用。

Mixin功能的实现类似于扩展类，当混入多个类的时候，会自动创建多个中间类，每次添加一个类的方法和属性进来，然后继承最后一个类，就相当于继承了所有类的方法和属性。

```dart
abstract class Super{
  void mprint(){
    print("Super");
  }
}

mixin Mixin on Super{
  void mprint(){
    super.mprint();
    print('Mixin');
  }
}

class Client extends Super with Mixin{}
```

# 8. 异步

Dart中使用Future进行异步处理，Future的Api返回值仍是Future，很方便的进行链式调用。

```dart
Future.delayed(new Duration(seconds: 2),(){
    //return 'Hi';
    throw AssertionError('Error');
  }).then((data){
    print(data);
  },onError: (e){
    print(e.message);
  }).whenComplete((){
    print('complete');
  });
```

在函数后面加上async表明方法是异步的，会返回Future，实现自定义

```dart
Future<String> login(String user,String pwd)async{
  return '';
}
```

当回调增多，会有一层层的回调，可以通过`async/await`像同步操作那样书写代码。

```dart
task() async {
   try{
    String id = await login("alice","******");
    String userInfo = await getUserInfo(id);
    await saveUserInfo(userInfo);
    //执行接下来的操作   
   } catch(e){
    //错误处理   
    print(e);   
   }  
}
```

# 9. 并发

并发是同时执行多个任务，通过`Isolate`实现。

```dart
void main(){
  Isolate.spawn(foo, 'hello');
  Isolate.spawn(foo, 'world');
  print('hello world');
}

void foo(String str){
  print(str);
}
```

Dart是一个单线程语言，每次调用spawn时新建一个isolate，类似于java的线程，但是每个isolate都是独立运行，没有共享变量。当需要通信的时候通过`sendPort`和`ReceivePort`实现。

`ReceivePort`在isolate中新建，他只能接受自己的`sendPort`发送的消息。

下面的例子中，在主进程中创建一个`ReceivePort`，接着将自己的`sendPort`发送给子线程，子线程使用主线程的`sendPort`将自己的`sendPort`发送给主线程。这样就可以相互通信。

```dart
import 'dart:isolate';

void main(){
  SendPort childSendPort;
  ReceivePort receivePort=new ReceivePort();
  Isolate.spawn(isolateMain, receivePort.sendPort);

  receivePort.listen((message){
    if(message is SendPort){
      print('我是主isolate,我接收到了子isolate的发送器');
      childSendPort=message;
    }else{
      print('我是主isolate，我接收到新消息:$message');
      if (childSendPort != null) {
        childSendPort.send('我是主isolate，我收到了你的消息');
      }
    }
  });
}
void isolateMain(SendPort sendPort){
  ReceivePort receivePort=new ReceivePort();
  sendPort.send(receivePort.sendPort);
  sendPort.send("我是子isolate，我向主isolate发送消息");
  receivePort.listen((message){
    print('我是子isolate，我接收到新消息:$message');
  });
}
```

# 10. 异常

异常都是Exception的子类，在`try/on/catch`中嵌入代码。

```dart
  int x=1;
  int y=0;
  int res;
  try {
    res = x ~/ y;
  } on IntegerDivisionByZeroException catch(e) {
    print(e);
  }finally{
    print('finally');
  }
```

自定义一个异常需要实现Exception，当在当前位置无法处理这个异常，就可以通过throw这个异常。

```dart
void main(){
  var person=new Person();
  try{
    person.setAge=-1;
  }catch(e){
    print(e);
  }finally{
    print('finally');
  }
}

class Person{
  int age;
  set setAge(age){
    if(age<=0){
      throw new myAgeLessThanZeroException();
    }else
      this.age=age;
  }
}

class myAgeLessThanZeroException implements Exception{
 @override
  String toString()=>'AgeLessThanZeroException';
}
```

# 11. 函数传递

通过`typedef`定义函数类型，然后就可以通过它定义一个对象，可以将相同函数类型的函数传递给这个对象，也可以传递这个对象。

```dart

typedef  ManyOperation(int a,int b);

void main(){

  ManyOperation oper=Add;
  oper(1,2);
  ff(3,4,Divide);
}

Add(int a,int b){
  print('Add result is ${a+b}');
}

Subtract(int a,int b){
  print('Add result is ${a-b}');
  return 1;
}

ff(int a,int b,ManyOperation oper){
  print('ff');
  oper(a,b);
}
```

# 12. 单元测试

测试的功能就是测试一个函数是否实现了预期功能，而不需要编译真个项目。

要使用这个共能需要先导入包`test`。

```dart
import 'package:test/test.dart';

int Add(int x,int y){
  return x+y;
}
int Sub(int x,int y){
  return x-y-1;
}

void main(){
  test('test to check sub',(){
    var expected=30;//想要的结果
    var actual=Add(10, 20);//实际的结果
    expect(actual,expected);
  });

  test('test to check Sub', (){
    var expected=10;
    var actual=Sub(30, 20);
    expect(actual,expected);
  });
}
```

可以对用例进行分组测试。

```dart
group('Stirng', (){
    test('test on splite()', (){
      var string = "foo,bar,baz";
      expect(string.split(","), equals(["foo", "bar", "baz"])); 
    });

    test('test on trim()', (){
      var string = ' foo  ';
      expect(string.trim(), 'foo');
    });
  });
```



# 参考文章

[Dart Programming Tutorial](https://www.tutorialspoint.com/dart_programming/index.htm ) 

[Dart语言教程](https://www.yiibai.com/dart)

[Dart语言简介](https://book.flutterchina.club/chapter1/dart.html)

[（五）flutter入门之dart中的并发编程、异步和事件驱动详解](https://www.jianshu.com/p/d4df418244e8)



