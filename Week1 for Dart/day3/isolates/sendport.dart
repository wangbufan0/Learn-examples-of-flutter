import 'dart:isolate';

void main(){
  SendPort childSendPort;
  ReceivePort receivePort=new ReceivePort();
  Isolate.spawn(isolateMain, receivePort.sendPort);

  receivePort.listen((message){
    if(message is SendPort){
      print('我是主isolate,我接收到了子isolate的发送器');
      childSendPort=message;
    }else{
      print('我是主isolate，我接收到新消息:$message');
      if (childSendPort != null) {
        childSendPort.send('我是主isolate，我收到了你的消息');
      }
    }
  });
}

void isolateMain(SendPort sendPort){

  ReceivePort receivePort=new ReceivePort();
  sendPort.send(receivePort.sendPort);
  sendPort.send("我是子isolate，我向主isolate发送消息");
  receivePort.listen((message){
    print('我是子isolate，我接收到新消息:$message');
  });
}