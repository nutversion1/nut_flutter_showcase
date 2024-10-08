import 'package:flutter/material.dart';
import 'package:nut_flutter_showcase/fun_with_api/youtube_search/youtube_search.dart';
import 'package:text_link/text_link.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeSearchDetailScreen extends StatelessWidget {
  final YoutubeSearch youtubeSearch;

  const YoutubeSearchDetailScreen({super.key, required this.youtubeSearch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Detail')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(youtubeSearch.title),
          const SizedBox(height: 20),
          Text('Description: ${youtubeSearch.description}'),
          const SizedBox(height: 20),
          LinkText(text: youtubeSearch.link),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            height: 200,
            child: VideoPlayerWidget(videoId: 'JTMVOzPPtiw'),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({super.key, required this.videoId});
  final String videoId;

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: YoutubePlayerController(initialVideoId: videoId),
    );
  }
}
