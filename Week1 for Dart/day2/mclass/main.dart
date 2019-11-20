import 'package:flutter_app/Wednesday/mclass/Student.dart';

import 'Person.dart';

void main(){

  var people=new Person("wangbufan");
  people.setAge=20;
  //print(people._age);
  print(people.getAge);
  var people2=Person.from(people);
  people2.setAge=-1;
  people2.mprint();

  Student student=new Student('www', 1);
  student.mprint();

  Person people3=new Student('www', 2);
  people3.mprint();

  new Student('www', 3)
  ..setAge=21
  ..mprint();


}


