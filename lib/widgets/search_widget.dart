import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final double padding;
  final Function(String text) onSearch;

  const SearchWidget({
    super.key,
    this.padding = 20,
    required this.onSearch,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(widget.padding),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
              ),
              onChanged: (newText) {
                setState(() {
                  text = newText;
                });
              },
            ),
          ),
          IconButton(
            onPressed: text.isEmpty ? null : () => widget.onSearch(text),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
