import 'package:flutter/material.dart';
import 'package:flutter_group9/maininterface.dart';
import 'package:flutter_group9/widget/custom_post.dart';

final List<String> avatarUrl = [
  "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80",
  "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80",
];
final List<String> userName = [
  "Username",
  "Username",
];
final List<String> time = [
  "Just Now",
  "Yesterday",
];
final List<String> Caption = [
  "Hello there",
  "Hehe!!!",
];
final List<String> storyUrl = [
  "https://images.unsplash.com/photo-1600055882386-5d18b02a0d51?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=621&q=80",
  "",
];

class MyTimeline extends StatelessWidget {
  const MyTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade100,
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainInterface.select(0),
                ));
          },
        ),
        title: const Text(
          "My Timeline",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 22,
              ),
              Container(
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage(avatarUrl[0]),
                ),
              ),
              Text(
                "Username",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: storyUrl.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: feedBox(
                                '${avatarUrl[index]}',
                                '${userName[index]}',
                                '${time[index]}',
                                '${Caption[index]}',
                                '${storyUrl[index]}'),
                          );
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
