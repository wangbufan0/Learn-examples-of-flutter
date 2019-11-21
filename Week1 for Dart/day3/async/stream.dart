import 'await.dart';

main(){
  Stream.fromFutures([
    login('www', 'sss'),
    Future.delayed(new Duration(seconds: 2),(){
      throw AssertionError("Error");
    }),
    Future.delayed(new Duration(seconds: 3), () {
      return "hello 3";
    })
  ]).listen((data){
    print(data);
  }, onError: (e){
    print(e.message);
  },onDone: (){

  });
}