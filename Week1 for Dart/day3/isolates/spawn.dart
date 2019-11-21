import 'dart:isolate';

void main(){
  Isolate.spawn(foo, 'hello');
  Isolate.spawn(foo, 'world');
  print('hello world');
}

void foo(String str){
  print(str);
}