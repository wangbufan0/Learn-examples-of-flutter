void main(){
  int x=1;
  int y=0;
  int res;

  try{
    res=x~/y;
  }catch(e){
    print(e);
  }finally{
    print('finally');
  }



}