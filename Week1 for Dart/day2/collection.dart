import 'dart:collection';

void main(){

  var strSet=new Set()
      ..add(100)
      ..add(100)
      ..add(200)
      ..add(300)
      ..remove(300)
      ..remove(400)
      ..toString();
  print(strSet);

  var strHashSet=new HashSet()
    ..add(100)
    ..add(100)
    ..add(200)
    ..add(300)
    ..remove(300)
    ..remove(400)
    ..toString();
  print(strHashSet);

  var map=new Map();
  map['sex']='man';
  map['name']='wangbufan';
  print(map);

  var hashMap=new HashMap();
  hashMap['name']='wangbufan';
  hashMap['sex']='man';
  print(hashMap);

  var numQ=new Queue.from([100,200,300]);
  var i=numQ.iterator;
  while(i.moveNext()){
    print(i.current);
  }



}