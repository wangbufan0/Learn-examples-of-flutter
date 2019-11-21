main(){

  Future.delayed(new Duration(seconds: 2),(){
    //return 'Hi';
    throw AssertionError('Error');
  }).then((data){
    print(data);
  }).catchError((e){
    print(e);
  });

  Future.delayed(new Duration(seconds: 2),(){
    //return 'Hi';
    throw AssertionError('Error');
  }).then((data){
    print(data);
  },onError: (e){
    print(e.message);
  }).whenComplete((){
    print('complete');
  });

}

