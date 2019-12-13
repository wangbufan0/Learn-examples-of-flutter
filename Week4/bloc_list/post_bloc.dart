import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_to_bative/bloc_infinite_list/post.dart';
import 'package:flutter_to_bative/bloc_infinite_list/post_event.dart';
import 'package:flutter_to_bative/bloc_infinite_list/post_state.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final Client httpClient;

  PostBloc({@required this.httpClient});

  @override
  Stream<PostState> transformEvents(
      Stream<PostEvent> events, Stream<PostState> next(PostEvent event)) {
    return super.transformEvents(
        (events as Observable<PostEvent>)
            .debounceTime(Duration(milliseconds: 500)),
        next);
  }

  @override
  // TODO: implement initialState
  PostState get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    final currentState = state;
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostUninitialized) {
          final posts = await _fetchPosts(0, 20);
          yield PostLoaded(posts: posts, hasReachedMax: false);
          return;
        }
        if (currentState is PostLoaded) {
          final posts = await _fetchPosts(currentState.posts.length, 20);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostLoaded(
                  posts: currentState.posts + posts, hasReachedMax: false);
        }
      } catch (_) {
        yield PostError();
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostLoaded && state.hasReachedMax;

  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    final response = await httpClient.get(
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawPost) {
        return Post(
            id: rawPost['id'], title: rawPost['title'], body: rawPost['body']);
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}
