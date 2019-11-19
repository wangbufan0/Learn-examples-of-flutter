void main(){
  print(num.parse("111"));
  print(num.parse("22.2"));
//  int m;
//  m=num.parse("22.2");

  int a=1;
  print(a.hashCode);
  //如果数量有限，则为true；否则为true。否则为假。
  print(a.isFinite);
  //如果数字是正无穷大或负无穷大，则为true；否则为false。否则为假。
  print(a.isInfinite);
  //如果数字是非数字双精度值，则为true
  print(11.2.isNaN);
  //如果数字为负，则为true
  print(11.2.isNegative);
  //根据数字的符号和数值，返回负一，零或加一。
  print(a.sign);
  //如果数字是偶数，则返回true。
  print(a.isEven);
  //如果数字是奇数，则返回true。
  print(a.isOdd);


  var b=11.2;

  print(b.abs());//绝对值
  



}