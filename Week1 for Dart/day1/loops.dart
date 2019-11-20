void main() {
  bool isA=true;
  var a=1;var b=1;
  var i=20;
  print(a);
  print(b);
  while(i-->0){
    if(isA){
      isA=false;
      a+=b;
      print(a);
    }else{
      isA=true;
      b+=a;
      print(b);
    }
  }
}