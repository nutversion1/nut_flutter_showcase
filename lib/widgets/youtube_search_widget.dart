import 'package:flutter/material.dart';

import '../fun_with_api/youtube_search/youtube_search.dart';

class YoutubeSearchWidget extends StatelessWidget {
  final List<YoutubeSearch> youtubeSearches;

  const YoutubeSearchWidget({super.key, required this.youtubeSearches});

  @override
  Widget build(BuildContext context) {
    return _buildYoutubeSearchCards();
  }

  Widget _buildYoutubeSearchCards() {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: youtubeSearches.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildYoutubeSearchCard(youtubeSearches[index]);
          },
        ));
  }

  Widget _buildYoutubeSearchCard(YoutubeSearch youtubeSearch) {
    return Card(
      color: Colors.blue,
      child: Container(
        width: 250,
        height: 300,
        padding: EdgeInsets.all(10),
        color: Colors.white54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              youtubeSearch.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildTitleImage(youtubeSearch),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleImage(YoutubeSearch youtubeSearch) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Image.network(
        youtubeSearch.thumbnail,
      ),
    );
  }
}
