import 'package:flutter/material.dart';

class SearchFriends extends SearchDelegate {
  List<String> searchTerms = [
    "Ahmad Mujahid",
    "Ali Baba",
    "firdaus",
    "Ibrahim Musa",
    "Idham Anur",
    "Khainor Azam",
    "Muhammad Firdaus",
    "Nor Ain Salleh",
    "Yasmeen Abu Bakar",
  ];

//  @override
// ThemeData appBarTheme(BuildContext context) {
//    return ThemeData(
//    appBarTheme: const AppBarTheme(
//     backgroundColor: Color(0xFF388E3C), // affects AppBar's background color
//       // hintColor: Colors.lightGreen, // affects the initial 'Search' text
//     // textTheme: const TextTheme(
//     //   headline6: TextStyle( // headline 6 affects the query text
//     //       color: Colors.white,
//     //       fontSize: 16.0,
//     //       fontWeight: FontWeight.bold)),
//    ),
//   );
// }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.cancel),
        iconSize: 20,
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var username in searchTerms) {
      if (username.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(username);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var username in searchTerms) {
      if (username.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(username);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }
}
