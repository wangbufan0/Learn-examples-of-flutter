main()async{
  String id=await login('www', 'sss');
  print(id);
  String userInfo=await getUserInfo(id);
  await saveUserInfo(userInfo);
  print(userInfo);
}


Future<String> login(String user,String pwd)async{
  await Future.delayed(new Duration(seconds: 2));
  return user+pwd;
}

Future<String> getUserInfo(String id)async{
  await Future.delayed(new Duration(seconds: 2));
  return id+'2';
}

Future saveUserInfo(String userInfo)async{

}