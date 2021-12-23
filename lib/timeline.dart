import 'package:flutter/material.dart';
import 'package:flutter_group9/chats/chatbox.dart';
import 'package:flutter_group9/newpost.dart';
import 'package:flutter_group9/mytimeline.dart';
import 'package:flutter_group9/test.dart';
import 'package:flutter_group9/test2.dart';
import 'package:flutter_group9/test3.dart';

import 'maininterface.dart';
import 'widget/custom_post.dart';

class Timeline extends StatelessWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> avatarUrl = [
      "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80",
      "https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
      "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80",
      "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80",
    ];
    final List<String> userName = [
      "Username",
      "Joe",
      "Mariam",
      "Username",
    ];
    final List<String> time = [
      "Just Now",
      "6min",
      "19h",
      "Yesterday",
    ];
    final List<String> Caption = [
      "Hello there",
      "Wassap",
      "Im new here",
      "Hehe!!!",
    ];
    final List<String> storyUrl = [
      "",
      "https://images.unsplash.com/photo-1600174297956-c6d4d9998f14?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
      "https://images.unsplash.com/photo-1600008646149-eb8835bd979d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=666&q=80",
      "https://images.unsplash.com/photo-1502920313556-c0bbbcd00403?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=967&q=80",
    ];

    return Scaffold(
      backgroundColor: Colors.lightGreen.shade100,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          FittedBox(
                            fit: BoxFit.contain,
                            child: CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(avatarUrl[0]),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Username",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        color: Color(0xFF505050),
                        thickness: 1.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainInterface.select(0)));
                            },
                            icon: const Icon(Icons.assignment_ind_rounded),
                            label: const Text("My Timeline"),
                            color: Color(0xFFF23E5C),
                          ),
                          RaisedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen()));
                            },
                            icon: const Icon(Icons.mail_outline_rounded),
                            label: const Text("Messages"),
                            color: Colors.blue[300],
                          ), //
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Column(
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
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewPost()));
          // context,
          // MaterialPageRoute(builder: (context) => AddSharing()));
          //context,MaterialPageRoute(builder: (context) => GetUserName()));
          //context,MaterialPageRoute(builder: (context) => CameraWidget()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green[700],
        tooltip: "New Post",
      ),
    );
  }
}

Widget actionButton(
    IconData icon, String actionTitle, Color iconColor, String nextPage) {
  return Builder(builder: (context) {
    return Expanded(
      child: FlatButton.icon(
        onPressed: () {
          if (nextPage == "MyTimeline") {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyTimeline()));
          } else {}
        },
        icon: Icon(
          icon,
          color: iconColor,
        ),
        label: Text(
          actionTitle,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  });
}
