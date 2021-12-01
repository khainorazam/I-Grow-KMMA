import 'package:flutter/material.dart';

class SearchFriends extends StatelessWidget {
  const SearchFriends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightGreen.shade100,
        child: const Center(
          child: Text('Search Friends'),
        ),
      ),
    );
  }
}
