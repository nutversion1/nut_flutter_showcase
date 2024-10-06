import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class HobbiesScreen extends StatefulWidget {
  const HobbiesScreen({super.key});

  @override
  State<HobbiesScreen> createState() => _HobbiesScreenState();
}

class _HobbiesScreenState extends State<HobbiesScreen> {
  int selectedValue = -1;
  String hobby = 'a';
  String link = 'a';
  String category = 'a';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hobbies')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: hobby.isEmpty || link.isEmpty
            ? const CircularProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildRadios(),
                  const SizedBox(height: 100),
                  _buildHobbyCard(),
                ],
              ),
      ),
    );
  }

  Widget _buildHobbyCard() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            hobby,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24.0),
          ),
          const SizedBox(height: 20),
          Text('Link: $link'),
          const SizedBox(height: 20),
          Text('Category: $category'),
        ],
      ),
    );
  }

  Widget _buildRadios() {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            title: const Text('General'),
            leading: Radio(
              value: 0,
              groupValue: selectedValue,
              onChanged: (int? value) {
                setState(() {
                  selectedValue = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Sports and Outdoors'),
            leading: Radio(
              value: 1,
              groupValue: selectedValue,
              onChanged: (int? value) {
                setState(() {
                  selectedValue = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Education'),
            leading: Radio(
              value: 2,
              groupValue: selectedValue,
              onChanged: (int? value) {
                setState(() {
                  selectedValue = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Collection'),
            leading: Radio(
              value: 3,
              groupValue: selectedValue,
              onChanged: (int? value) {
                setState(() {
                  selectedValue = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Competition'),
            leading: Radio(
              value: 4,
              groupValue: selectedValue,
              onChanged: (int? value) {
                setState(() {
                  selectedValue = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Observation'),
            leading: Radio(
              value: 5,
              groupValue: selectedValue,
              onChanged: (int? value) {
                setState(() {
                  selectedValue = value!;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          _buildGenerateButton(),
        ],
      ),
    );
  }

  Widget _buildGenerateButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          hobby = '';
          link = '';
        });

        _fetchHobby();
      },
      child: const Text('Generate'),
    );
  }

  Future<void> _fetchHobby() async {
    print('value: $selectedValue');

    var selectedCategory = 'general';

    switch (selectedValue) {
      case 0:
        selectedCategory = 'general';
        break;
      case 1:
        selectedCategory = 'sports_and_outdoors';
        break;
      case 2:
        selectedCategory = 'education';
        break;
      case 3:
        selectedCategory = 'collection';
        break;
      case 4:
        selectedCategory = 'competition';
        break;
      case 5:
        selectedCategory = 'observation';
        break;
    }

    var response = await http.get(
      Uri.parse(
          'https://hobbies-by-api-ninjas.p.rapidapi.com/v1/hobbies?category=$selectedCategory'),
      headers: {
        'X-RapidAPI-Key': 'd6c331a93dmsh50acb261fb544bbp104233jsnf173aa315856',
      },
    );

    setState(() {
      Map valueMap = json.decode(response.body);
      hobby = valueMap['hobby'];
      link = valueMap['link'];
      category = valueMap['category'];
    });
  }
}
