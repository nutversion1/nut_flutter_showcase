import 'package:flutter/material.dart';
import 'package:nut_flutter_showcase/main.dart';
import 'package:nut_flutter_showcase/services/api_service.dart';
import 'package:text_link/text_link.dart';

import '../models/hobby_category.dart';
import '../models/hobby.dart';

class HobbiesScreen extends StatefulWidget {
  const HobbiesScreen({super.key});

  @override
  State<HobbiesScreen> createState() => _HobbiesScreenState();
}

class _HobbiesScreenState extends State<HobbiesScreen> {
  final apiService = locator<ApiService>();

  bool _isFetchingData = false;
  List<HobbyCategory> _categories = [];
  HobbyCategory? _selectedCategory;
  Hobby? _hobby;

  @override
  void initState() {
    super.initState();

    _categories = [
      HobbyCategory(title: 'General', value: 'general'),
      HobbyCategory(title: 'Sports and Outdoors', value: 'sports_and_outdoors'),
      HobbyCategory(title: 'Education', value: 'education'),
      HobbyCategory(title: 'Collection', value: 'collection'),
      HobbyCategory(title: 'Competition', value: 'competition'),
      HobbyCategory(title: 'Observation', value: 'observation'),
    ];
    _selectedCategory = _categories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hobbies')),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_hobby != null) _buildHobbyCard(),
        if (_hobby != null) const Divider(),
        _buildRadios(),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildHobbyCard() {
    return Column(
      children: [
        Text(
          _hobby?.hobby ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24.0),
        ),
        const SizedBox(height: 20),
        LinkText(text: 'Link: ${_hobby?.link}'),
        const SizedBox(height: 20),
        Text('Category: ${_hobby?.category}'),
      ],
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
        _fetchHobby();
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

  Future<void> _fetchHobby() async {
    setState(() {
      _isFetchingData = true;
    });

    var url =
        'https://hobbies-by-api-ninjas.p.rapidapi.com/v1/hobbies?category=${_selectedCategory!.value}';
    var response = await apiService.dio.get(url);

    Map valueMap = response.data;
    var hobby = valueMap['hobby'];
    var link = valueMap['link'];
    var category = valueMap['category'];

    setState(() {
      _hobby = Hobby(hobby: hobby, link: link, category: category);
      _isFetchingData = false;
    });
  }
}
