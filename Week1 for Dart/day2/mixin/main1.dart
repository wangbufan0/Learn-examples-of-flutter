main(){

  print(new AB().getMessage());
  var ba=new BA();
  print(ba.getMessage());
  print(ba is A);
  print(ba is B);
  print(ba is P);

}

class A{
  String getMessage()=>'A';
}
class B{
  String getMessage()=>'B';
}
class P{
  String getMessage()=>'P';
}

class AB extends P with A,B{}

class BA extends P with B,A{}