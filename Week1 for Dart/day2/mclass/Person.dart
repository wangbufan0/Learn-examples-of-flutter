

class Person{

  static int _AVERAGE_AGE=20;

  String name;
  int _age;


  set setAge(age){
    if(age<=0)
      print('age<=0');
    else
      this._age=age;
  }
  int get getAge=>_age;

//  People(name){
//    this.name=name;
//  }

  Person(this.name,[int age]){
    if(age==null) _age=_AVERAGE_AGE;
    else this._age=age;
  }

  Person.from(Person people){
    name=people.name;
    _age=people.getAge;
  }




  mprint(){
    print('$name\'s age is $_age');
  }


}