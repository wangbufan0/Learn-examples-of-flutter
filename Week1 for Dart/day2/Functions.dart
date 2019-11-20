
void main(){
  print(addition(1, 2));
  print(addition(1, 2,3));
}

addition(a,b,[c])=>c==null?a+b:a+b+c;