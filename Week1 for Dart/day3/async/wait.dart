main(){

  Future.wait([
    Future.delayed(new Duration(seconds: 2),(){
      return 'hello';
    }),
    Future.delayed(new Duration(seconds: 3),(){
      return 'world';
    })
  ]).then((results){
    print(results[0]+results[1]);
  });
}