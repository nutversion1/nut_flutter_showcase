import 'package:flutter/material.dart';
import 'package:nut_flutter_showcase/fun_with_api/youtube_search/youtube_search_screen.dart';

import 'fun_with_api/programming_memes/programming_memes_screen.dart';
import 'fun_with_api/random_quote/random_quote_screen.dart';
import 'fun_with_api/hobbies/hobbies_screen.dart';
import 'fun_with_api/numbers/numbers_screen.dart';
import 'fun_with_api/translate/translate_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Nut's Flutter Showcase",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.startOffset,
            tabs: [
              Tab(icon: Icon(Icons.api), text: 'Fun With API'),
              Tab(icon: Icon(Icons.web_asset_sharp), text: 'WebGl'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildFunWithApiContent(context),
            _buildWebglContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFunWithApiContent(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
        child: ListView(
          children: [
            _buildMenuButtons(
              buttons: [
                _buildMenuButton(
                  context,
                  buttonName: 'Random Quote',
                ),
                _buildMenuButton(
                  context,
                  buttonName: 'Hobbies',
                ),
                _buildMenuButton(
                  context,
                  buttonName: 'Numbers',
                ),
                _buildMenuButton(
                  context,
                  buttonName: 'Translate',
                ),
                _buildMenuButton(
                  context,
                  buttonName: 'Programming Memes',
                ),
                _buildMenuButton(
                  context,
                  buttonName: 'Youtube Search',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWebglContent(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
        child: ListView(
          children: [
            _buildMenuButtons(
              buttons: [
                _buildMenuButton(
                  context,
                  buttonName: 'AR',
                ),
                _buildMenuButton(
                  context,
                  buttonName: 'Game',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuHeader({
    required String name,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMenuButtons({
    required List<Widget> buttons,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: buttons,
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required String buttonName,
  }) {
    return ElevatedButton(
      onPressed: () {
        _navigateToScreen(context, buttonName);
      },
      child: Text(buttonName),
    );
  }

  void _navigateToScreen(BuildContext context, String screenName) {
    switch (screenName) {
      case 'Random Quote':
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const RandomQuoteScreen()));
        break;
      case 'Hobbies':
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const HobbiesScreen()));
        break;
      case 'Numbers':
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NumbersScreen()));
        break;
      case 'Translate':
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const TranslateScreen()));
        break;
      case 'Programming Memes':
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ProgrammingMemesScreen()));
        break;
      case 'Youtube Search':
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const YoutubeSearchScreen()));
        break;
    }
  }
}
