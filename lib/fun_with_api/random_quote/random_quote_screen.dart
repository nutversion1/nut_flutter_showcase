import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'quote.dart';

class RandomQuoteScreen extends StatefulWidget {
  const RandomQuoteScreen({super.key});

  @override
  State<RandomQuoteScreen> createState() => _RandomQuoteScreenState();
}

class _RandomQuoteScreenState extends State<RandomQuoteScreen> {
  bool _isFetchingData = false;
  Quote? _quote;

  @override
  void initState() {
    super.initState();

    _fetchRandomQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Quote')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _isFetchingData
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildQuoteCard(),
                    const SizedBox(height: 100),
                    _buildNextButton(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: () {
        _fetchRandomQuote();
      },
      child: const Text('Next', style: TextStyle(fontSize: 18.0)),
    );
  }

  Widget _buildQuoteCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              _quote?.quote ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20),
            Text(
              '-${_quote?.author}',
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchRandomQuote() async {
    setState(() {
      _isFetchingData = true;
    });

    var response = await http.get(
      Uri.parse('https://quotes15.p.rapidapi.com/quotes/random/'),
      headers: {
        'X-RapidAPI-Key': 'd6c331a93dmsh50acb261fb544bbp104233jsnf173aa315856',
      },
    );

    Map valueMap = json.decode(response.body);
    var quote = valueMap['content'];
    var author = valueMap['originator']['name'];

    setState(() {
      _quote = Quote(quote, author);
      _isFetchingData = false;
    });
  }
}
