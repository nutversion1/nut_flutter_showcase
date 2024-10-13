import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nut_flutter_showcase/showcase/other/posts/posts.dart';

class PostsList extends StatefulWidget {
  const PostsList({super.key});

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      return switch (state.status) {
        PostStatus.initial => const Center(child: CircularProgressIndicator()),
        PostStatus.failure =>
          const Center(child: Text('failed to fetch posts')),
        PostStatus.success => ListView.builder(
            itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
            itemBuilder: (context, index) {
              return index >= state.posts.length
                  ? const BottomLoader()
                  : PostListItem(post: state.posts[index]);
            },
            controller: _scrollController,
          ),
      };
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
