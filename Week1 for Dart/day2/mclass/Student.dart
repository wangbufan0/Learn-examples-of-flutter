import 'package:flutter_app/Wednesday/mclass/Person.dart';

class Student extends Person{
  int sno;

  Student(String name,this.sno) : super(name);

  @override
  mprint() {
    // TODO: implement mprint
    super.mprint();
    print(',and sno is $sno');
  }
}