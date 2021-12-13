import 'package:flutter/material.dart';

class SearchFriends extends StatefulWidget {
  const SearchFriends({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchFriendsState();
  }
}

class SearchFriendsState extends State<SearchFriends> {
  @override
  Widget build(BuildContext context) {
    //put logic here

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //put widget here
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[700],
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Search for Friends",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: Container(
            color: Colors.lightGreen[100],
          )),
    );
  }
}
