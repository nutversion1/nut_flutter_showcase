import 'package:flutter/material.dart';

import 'showcase/fun_with_api/hobbies/screens/hobbies_screen.dart';
import 'showcase/fun_with_api/numbers/numbers_screen.dart';
import 'showcase/fun_with_api/programming_memes/screens/programming_memes_screen.dart';
import 'showcase/fun_with_api/random_quote/screens/random_quote_screen.dart';
import 'showcase/fun_with_api/translate/translate_screen.dart';
import 'showcase/fun_with_api/youtube_search/youtube_search_screen.dart';
import 'showcase/other/bloc_demo/screens/bloc_demo_screen.dart';
import 'showcase/other/cubit_demo/screens/cubit_demo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
              Tab(icon: Icon(Icons.backup_table), text: 'Other'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TabContent(buttons: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RandomQuoteScreen()));
                },
                child: const Text('Random Quote'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HobbiesScreen()));
                },
                child: const Text('Hobbies'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NumbersScreen()));
                },
                child: const Text('Numbers'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TranslateScreen()));
                },
                child: const Text('Translate'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProgrammingMemesScreen()));
                },
                child: const Text('Programming Memes'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const YoutubeSearchScreen()));
                },
                child: const Text('Youtube Search'),
              ),
            ]),
            const TabContent(buttons: [
              ElevatedButton(
                onPressed: null,
                child: Text('AR'),
              ),
              ElevatedButton(
                onPressed: null,
                child: Text('Game'),
              ),
            ]),
            TabContent(buttons: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TestScreen()));
                },
                child: const Text('Cubit Demo'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BlocDemoScreen()));
                },
                child: const Text('Bloc Demo'),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final List<Widget> buttons;

  const TabContent({super.key, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
        child: ListView(
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: buttons,
            ),
          ],
        ),
      ),
    );
  }
}
