main(){
 new Client().mprint();
}

abstract class Super{
  void mprint(){
    print("Super");
  }
}

class mySuper implements Super{
  @override
  void mprint() {
    print('mySuper');
  }
}

mixin Mixin on Super{
  void mprint(){
    super.mprint();
    print('Mixin');
  }
}

class Client extends mySuper with Mixin{}