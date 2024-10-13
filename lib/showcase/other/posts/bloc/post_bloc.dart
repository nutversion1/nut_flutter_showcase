import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';
import 'package:nut_flutter_showcase/showcase/other/posts/posts.dart';

part 'post_event.dart';
part 'post_state.dart';

const throttleDuration = Duration(microseconds: 100);
const _postLimit = 20;

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  void _onPostFetched(PostFetched event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) return;

    try {
      final posts = await _fetchPosts(startIndex: state.posts.length);

      if (posts.isEmpty) {
        return emit(state.copyWith(hasReachedMax: true));
      }

      final newState = state.copyWith(
        status: PostStatus.success,
        posts: [...state.posts, ...posts],
      );

      print('_onPostFetched: ${newState.posts.length}');

      emit(newState);
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPosts({required int startIndex}) async {
    final response = await httpClient.get(Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        {'_start': '$startIndex', '_limit': '$_postLimit'}));

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;

      return body.map((json) {
        final map = json as Map<String, dynamic>;
        return Post(
          id: map['id'] as int,
          title: map['title'] as String,
          body: map['body'] as String,
        );
      }).toList();
    }

    throw Exception('error fetching posts');
  }
}
