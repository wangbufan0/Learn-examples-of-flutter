
typedef ManyOperation(int a,int b);

void main(){

  ManyOperation oper=Add;
  oper(1,2);
  oper=Subtract;
  oper(2,3);
  ff(3,4,Divide);
}

Add(int a,int b){
  print('Add result is ${a+b}');
}

Subtract(int a,int b){
  print('Add result is ${a-b}');
}

Divide(int a,int b){
  print('Add result is ${a/b}');
}

ff(int a,int b,ManyOperation oper){
  print('ff');
  oper(a,b);
}