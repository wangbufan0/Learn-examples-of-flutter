void main(){
  var person=new Person();
  try{
    person.setAge=-1;
  }catch(e){
    print(e);
  }finally{
    print('finally');
  }
}

class Person{
  int age;
  set setAge(age){
    if(age<=0){
      throw new myAgeLessThanZeroException();
    }else
      this.age=age;
  }
}

class myAgeLessThanZeroException implements Exception{
 @override
  String toString()=>'AgeLessThanZeroException';
}