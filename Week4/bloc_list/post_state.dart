

import 'package:equatable/equatable.dart';
import 'package:flutter_to_bative/bloc_infinite_list/post.dart';

abstract class PostState extends Equatable{
  const PostState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PostUninitialized extends PostState{}

class PostError extends PostState{}

class PostLoaded extends PostState{
  final List<Post> posts;
  final bool hasReachedMax;
  PostLoaded({this.posts,this.hasReachedMax});

  PostLoaded copyWith({List<Post> posts,bool hasReachedMax}){
    return PostLoaded(
        posts:posts?? this.posts,
      hasReachedMax: hasReachedMax??this.hasReachedMax
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [posts,hasReachedMax];

  @override
  String toString() {
    // TODO: implement toString
    return 'PostLoaded { posts: ${posts.length}, hasReachedMax: $hasReachedMax }';
  }

}