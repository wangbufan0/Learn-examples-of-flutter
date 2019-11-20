void main(){
  //定长
  List list=new List(5);
  for(var i=1;i<=5;i++){
    list[i-1]=i*i;
  }
  print(list);
  //不定长
  var list1=[1,4,9,16,25];
  list1.add(100);
  list1.remove(1);
  print(list1);
  list1.removeAt(1);
  print(list1);
  list1.removeRange(2, 3);
  print(list1);
  var list2=new List();
  list2.add(1);
  list2.add(2);
  list2.addAll([1,2,4]);
  print(list2);
  list2.replaceRange(1, 4, [1,1,1]);//整体替换
  print(list2);


  print(list2.first);
  print(list2.isEmpty);
  print(list2.length);
  print(list2.last);
  print(list2.reversed);//逆序
  //print(list2.single);
  list2.add(2.42434);
  list2.add('ssss');
  print(list2);
}