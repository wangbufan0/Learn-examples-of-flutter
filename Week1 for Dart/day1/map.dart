void main(){
  var map1={'name':'wangbufan','sex':'man','age':20};
  print(map1);
  var map2=new Map();
  map2['name']='wangbufan1';
  map2['sex']='man';
  map2['age']=20;
  print(map2);

  print(map2.keys);
  print(map2.values);
  print(map2.length);
  print(map2.isNotEmpty);

  map2.remove('sex');
  map2.forEach((k,v)=>print('$k is $v'));
  map2['name'] = 'wangbufan2';
  print(map2);
  
}