void main(){
  var c=new C();
  print(c.get10());
  print(c.get1000());
  //var a=new A();
  var a=new C();
  print(a.get10());
  print(a.get1000());

  //var d=new D();
  D d=new C();
  d.get1();
}

class A{
  int get10(){return 10;}
  int get1000(){}
}
class B{
  int get10000(){}
}
abstract class D{
  int get1();
}

class C extends D implements A,B{
  @override
  int get1000() {
    // TODO: implement get1000
    return 1000;
  }

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

  @override
  int get1() {
    // TODO: implement get1
    return 1;
  }

}