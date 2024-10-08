import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'number.dart';
import 'number_category.dart';

class NumbersScreen extends StatefulWidget {
  const NumbersScreen({super.key});

  @override
  State<NumbersScreen> createState() => _NumbersScreenState();
}

class _NumbersScreenState extends State<NumbersScreen> {
  bool _isFetchingData = false;
  List<NumberCategory> _categories = [];
  NumberCategory? _selectedCategory;
  Number? _number;

  @override
  void initState() {
    super.initState();

    _categories = [
      NumberCategory(title: 'Date', value: 'date'),
      NumberCategory(title: 'Math', value: 'math'),
      NumberCategory(title: 'Trivia', value: 'trivia'),
      NumberCategory(title: 'Year', value: 'year'),
    ];
    _selectedCategory = _categories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Numbers')),
      body: Stack(
        children: [
          _buildBody(),
          if (_isFetchingData) _buildLoadingBarrier(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (_number != null) _buildNumberCard(),
        if (_number != null) const Divider(),
        _buildRadios(),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildNumberCard() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Number: ${_number?.number}'),
          const SizedBox(height: 20),
          Text('Fact: ${_number?.text}'),
          if (_number?.year != null) const SizedBox(height: 20),
          if (_number?.year != null) Text('Year: ${_number?.year}'),
        ],
      ),
    );
  }

  Widget _buildRadios() {
    return Column(
      children: _buildRadioWidgets(),
    );
  }

  List<Widget> _buildRadioWidgets() {
    List<Widget> widgets = [];

    for (var category in _categories) {
      var widget = RadioListTile(
        title: Text(category.title),
        value: category,
        groupValue: _selectedCategory,
        onChanged: (value) {
          setState(() {
            _selectedCategory = value;
          });
        },
      );

      widgets.add(widget);
    }

    return widgets;
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        _fetchNumber();
      },
      child: const Text('Submit'),
    );
  }

  Widget _buildLoadingBarrier() {
    return const Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        Center(child: CircularProgressIndicator()),
      ],
    );
  }

  Future<void> _fetchNumber() async {
    setState(() {
      _isFetchingData = true;
    });

    var url =
        'https://numbersapi.p.rapidapi.com/random/${_selectedCategory!.value}?fragment=true&json=true';
    var headers = {
      'X-RapidAPI-Key': 'd6c331a93dmsh50acb261fb544bbp104233jsnf173aa315856',
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    Map valueMap = json.decode(response.body);
    var text = valueMap['text'];
    var year = valueMap['year'];
    var number = valueMap['number'];
    var found = valueMap['found'];
    var type = valueMap['type'];

    setState(() {
      _number = Number(
        text: text,
        year: year,
        number: number,
        found: found,
        type: type,
      );
      _isFetchingData = false;
    });
  }
}
