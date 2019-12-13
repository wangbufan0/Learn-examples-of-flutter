

import 'package:equatable/equatable.dart';

class Post extends Equatable{
  final int id;
  final String title;
  final String body;
  Post({this.id,this.title,this.body});

  @override
  List<Object> get props {
    return [id,title,body];
  }

  @override
  String toString() {
    return 'Post {id:$id}';
  }


}