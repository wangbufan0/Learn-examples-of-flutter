import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_bative/bloc_infinite_list/post.dart';
import 'package:flutter_to_bative/bloc_infinite_list/post_bloc.dart';
import 'package:flutter_to_bative/bloc_infinite_list/post_event.dart';
import 'package:flutter_to_bative/bloc_infinite_list/post_state.dart';
import 'package:http/http.dart';

class PostListPage extends StatefulWidget {
  static void launch(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return BlocProvider<PostBloc>(
        create: (context) => PostBloc(httpClient: Client())..add(Fetch()),
        child: PostListPage(),
      );
    }));
  }

  @override
  State createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<PostBloc>(context);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <=_scrollThreshold) {
      _postBloc.add(Fetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostUninitialized) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PostError) {
            return Center(
              child: Text('onError'),
            );
          }
          if (state is PostLoaded) {
            if (state.posts.isEmpty) {
              return Center(
                child: Text('no posts'),
              );
            }
            return ListView.builder(
                itemCount: state.hasReachedMax
                    ? state.posts.length
                    : state.posts.length + 1,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return index >= state.posts.length
                      ? BottomLoader()
                      : PostWidget(post: state.posts[index]);
                });
          }

          return Text('end');
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${post.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(post.title),
      isThreeLine: true,
      subtitle: Text(post.body),
      dense: true,
    );
  }
}
