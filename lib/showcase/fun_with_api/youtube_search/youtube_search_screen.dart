import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nut_flutter_showcase/widgets/search_widget.dart';
import 'package:nut_flutter_showcase/widgets/youtube_search_widget.dart';
import 'dart:convert';

import 'youtube_search.dart';
import 'youtube_search_detail_screen.dart';

class YoutubeSearchScreen extends StatefulWidget {
  const YoutubeSearchScreen({super.key});

  @override
  State<YoutubeSearchScreen> createState() => _YoutubeSearchScreenState();
}

class _YoutubeSearchScreenState extends State<YoutubeSearchScreen> {
  bool isFetchingData = false;
  List<YoutubeSearch> youtubeSearches = [];

  @override
  void initState() {
    super.initState();

    // youtubeSearches = [
    //   for (int i = 0; i < 3; i++)
    //     YoutubeSearch(
    //       title:
    //           'RICARDO KAKA In His Prime ► The Unstoppable Player (2003-2009) HD',
    //       link: 'https://youtu.be/xSdR7-8hBEU',
    //       thumbnail: 'https://i.ytimg.com/vi/xSdR7-8hBEU/hqdefault.jpg',
    //       description: 'Video: 720p.',
    //       views: 5383571,
    //       uploaded: 'vor 6 Jahren',
    //       durationString: '10:17',
    //     ),
    // ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Youtube Search')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        AbsorbPointer(
          absorbing: isFetchingData,
          child: SearchWidget(
            onSearch: (text) => _fetchYoutubeSearches(text),
          ),
        ),
        Expanded(
          child: isFetchingData
              ? const Center(child: CircularProgressIndicator())
              : YoutubeSearchWidget(
                  youtubeSearches: youtubeSearches,
                  onTap: (youtubeSearch) {
                    return Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => YoutubeSearchDetailScreen(
                              youtubeSearch: youtubeSearch,
                            )));
                  },
                ),
        ),
      ],
    );
  }

  Future<void> _fetchYoutubeSearches(String text) async {
    setState(() {
      isFetchingData = true;
    });

    var url =
        'https://youtube-search-results.p.rapidapi.com/youtube-search/?q=$text';
    var headers = {
      'X-RapidAPI-Key': 'd6c331a93dmsh50acb261fb544bbp104233jsnf173aa315856',
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    var jsonObject = json.decode(response.body);
    List valueMaps = jsonObject['videos'];

    youtubeSearches.clear();

    for (var valueMap in valueMaps) {
      var id = valueMap['id'];
      var title = valueMap['title'];
      var link = valueMap['link'];
      var thumbnail = valueMap['thumbnail'];
      var description = valueMap['description'];
      var views = valueMap['views'];
      var uploaded = valueMap['uploaded'];
      var durationString = valueMap['durationString'];

      var youtubeSearch = YoutubeSearch(
        id: id,
        title: title,
        link: link,
        thumbnail: thumbnail,
        description: description,
        views: views,
        uploaded: uploaded,
        durationString: durationString,
      );

      youtubeSearches.add(youtubeSearch);
    }

    setState(() {
      isFetchingData = false;
    });
  }
}
