import 'package:flutter/material.dart';

import 'random_quote_screen.dart';
import 'hobbies_screen.dart';

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
    }
  }
}
