import 'package:flutter/material.dart';
import 'package:nut_flutter_showcase/fun_with_api/youtube_search/youtube_search.dart';
import 'package:text_link/text_link.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeSearchDetailScreen extends StatefulWidget {
  final YoutubeSearch youtubeSearch;

  const YoutubeSearchDetailScreen({super.key, required this.youtubeSearch});

  @override
  State<YoutubeSearchDetailScreen> createState() =>
      _YoutubeSearchDetailScreenState();
}

class _YoutubeSearchDetailScreenState extends State<YoutubeSearchDetailScreen> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = YoutubePlayerController(
      initialVideoId: 'JTMVOzPPtiw',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }

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
          Text(widget.youtubeSearch.title),
          const SizedBox(height: 20),
          Text('Description: ${widget.youtubeSearch.description}'),
          const SizedBox(height: 20),
          LinkText(text: widget.youtubeSearch.link),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            height: 300,
            child: _buildYoutubePlayer(widget.youtubeSearch),
          ),
        ],
      ),
    );
  }

  Widget _buildYoutubePlayer(YoutubeSearch youtubeSearch) {
    return YoutubePlayer(
      controller: controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.amber,
      progressColors: const ProgressBarColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent,
      ),
      onReady: () {
        controller.addListener(() {});
      },
    );
  }
}
