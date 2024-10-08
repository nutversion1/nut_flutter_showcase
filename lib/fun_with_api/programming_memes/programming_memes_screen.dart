import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'meme.dart';

class ProgrammingMemesScreen extends StatefulWidget {
  const ProgrammingMemesScreen({super.key});

  @override
  State<ProgrammingMemesScreen> createState() => _ProgrammingMemesScreenState();
}

class _ProgrammingMemesScreenState extends State<ProgrammingMemesScreen> {
  bool _isFetchingData = false;
  List<Meme> _memes = [];

  @override
  void initState() {
    super.initState();

    // _memes = [
    //   Meme(
    //     image:
    //         'https://del1.vultrobjects.com/memeapi/memeapi/memes/216.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=M2UKDCLPL3TGZCVVPT4N%2F20241008%2Fdel1%2Fs3%2Faws4_request&X-Amz-Date=20241008T060921Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=5013676ef41e0732249e00bde9819a12b616880306419c11e0cb72c6581f243d',
    //     created: '1',
    //     modified: '2',
    //   ),
    //   Meme(
    //     image:
    //         'https://del1.vultrobjects.com/memeapi/memeapi/memes/489.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=M2UKDCLPL3TGZCVVPT4N%2F20241008%2Fdel1%2Fs3%2Faws4_request&X-Amz-Date=20241008T060921Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=449e1b0b61c43442d91e47e127a7f7976057c2e3106a030d2c0d9af9ea942dbb',
    //     created: '1',
    //     modified: '2',
    //   ),
    // ];

    _fetchMemes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Programming Memes')),
      // body: _buildMemeCards(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return _isFetchingData
        ? const Center(child: CircularProgressIndicator())
        : Container(
            margin: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
            ),
            child: _buildMemeCards(),
          );
  }

  Widget _buildMemeCards() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.separated(
        itemCount: _memes.length,
        itemBuilder: (context, index) {
          return _buildMemeCard(_memes[index]);
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }

  Widget _buildMemeCard(Meme meme) {
    return Container(
      width: 250,
      height: 300,
      color: Colors.white54,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildMemeImage(meme),
          Text(meme.modified.substring(0, 10).toString()),
        ],
      ),
    );
  }

  Widget _buildMemeImage(Meme meme) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Image.network(
        meme.image,
      ),
    );
  }

  Future<void> _fetchMemes() async {
    setState(() {
      _isFetchingData = true;
    });

    var url = 'https://programming-memes-images.p.rapidapi.com/v1/memes';
    var headers = {
      'X-RapidAPI-Key': 'd6c331a93dmsh50acb261fb544bbp104233jsnf173aa315856',
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    List valueMaps = json.decode(response.body);

    _memes.clear();

    for (var valueMap in valueMaps) {
      var image = valueMap['image'];
      var created = valueMap['created'];
      var modified = valueMap['modified'];

      var meme = Meme(image: image, created: created, modified: modified);
      _memes.add(meme);
    }

    setState(() {
      _isFetchingData = false;
    });
  }
}
