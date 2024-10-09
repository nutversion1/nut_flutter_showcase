import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  bool _isFetchingData = false;
  String _text = '';
  String _translatedText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Translate')),
      body: Stack(
        children: [
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 250,
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter text',
              ),
              onChanged: (newText) {
                setState(() {
                  _text = newText;
                });
              },
            ),
          ),
        ),
        Text('Result: $_translatedText'),
        _buildTranslateButton(),
      ],
    );
  }

  Widget _buildTranslateButton() {
    return ElevatedButton(
      onPressed: _text.isEmpty ? null : () => _fetchTranslate(),
      child: const Text('Translate'),
    );
  }

  Future<void> _fetchTranslate() async {
    setState(() {
      _isFetchingData = true;
    });

    var url = 'https://deep-translate1.p.rapidapi.com/language/translate/v2';
    var headers = {
      'X-RapidAPI-Key': 'd6c331a93dmsh50acb261fb544bbp104233jsnf173aa315856',
    };
    var body = json.encode({
      'q': _text,
      'source': 'en',
      'target': 'th',
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    Map valueMap = json.decode(response.body);
    var translatedText = valueMap['data']['translations']['translatedText'];

    setState(() {
      _translatedText = translatedText;
      _isFetchingData = false;
    });
  }
}
