import 'package:flutter/material.dart';
import 'package:flutter_group9/newpost.dart';
import 'package:flutter_group9/mytimeline.dart';

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
      "https://images.unsplash.com/photo-1600055882386-5d18b02a0d51?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=621&q=80",
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
                        children: [
                          actionButton(Icons.assignment_ind_rounded,
                              "MyTimeline", Color(0xFFF23E5C), "MyTimeline"),
                          actionButton(Icons.mail_outline_rounded, "Messages",
                              Color(0xFF2962FF), "")
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

Widget feedBox(String avatarUrl, String userName, String date,
    String contentText, String contentImg) {
  return Column(
    children: [
      PhysicalModel(
        color: Colors.transparent,
        shadowColor: Colors.green,
        elevation: 20,
        child: Container(
          margin: EdgeInsets.only(bottom: 20.0),
          width: 360,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  FittedBox(
                    fit: BoxFit.contain,
                    child:
                        CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(userName,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(
                        date,
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                contentText,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 200,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.network(contentImg),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //like comment share

                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                          color: Colors.grey.shade500,
                        ),
                        bottom: BorderSide(
                          color: Colors.grey.shade500,
                        ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: [
                        IconButton(
                          iconSize: 20,
                          onPressed: () {},
                          icon: Icon(Icons.thumb_up_outlined,
                              color: Colors.grey[500]
                              //_likeStatus ? Colors.green[700] : Colors.grey[500],
                              ),
                          tooltip: "Like this post",
                        ),
                        Text(
                          "Like",
                          style: TextStyle(fontSize: 14, color: Colors.grey[500]
                              //_likeStatus ? Colors.green[700]: Colors.grey[500]
                              ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          iconSize: 20,
                          onPressed: () {},
                          icon: Icon(Icons.thumb_down_outlined,
                              color: Colors.grey[500]
                              //_likeStatus ? Colors.green[700] : Colors.grey[500],
                              ),
                          tooltip: "Like this post",
                        ),
                        Text(
                          "Dislike",
                          style: TextStyle(fontSize: 14, color: Colors.grey[500]
                              //_likeStatus ? Colors.green[700]: Colors.grey[500]
                              ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}
