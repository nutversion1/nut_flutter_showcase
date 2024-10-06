import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RandomQuoteScreen extends StatefulWidget {
  const RandomQuoteScreen({super.key});

  @override
  State<RandomQuoteScreen> createState() => _RandomQuoteScreenState();
}

class _RandomQuoteScreenState extends State<RandomQuoteScreen> {
  String quote = '';
  String author = '';

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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: quote.isEmpty || author.isEmpty
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildQuoteCard(),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        quote = '';
                        author = '';
                      });

                      _fetchRandomQuote();
                    },
                    child: const Icon(Icons.navigate_next),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildQuoteCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              quote,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20),
            Text(
              '-$author',
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchRandomQuote() async {
    var response = await http.get(
      Uri.parse('https://quotes15.p.rapidapi.com/quotes/random/'),
      headers: {
        'X-RapidAPI-Key': 'd6c331a93dmsh50acb261fb544bbp104233jsnf173aa315856',
      },
    );

    setState(() {
      Map valueMap = json.decode(response.body);
      quote = valueMap['content'];
      author = valueMap['originator']['name'];
    });
  }
}
