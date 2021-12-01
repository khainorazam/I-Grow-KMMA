import 'package:flutter/material.dart';
import 'package:flutter_group9/maininterface.dart';

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
  "https://images.unsplash.com/photo-1502920313556-c0bbbcd00403?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=967&q=80",
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
  return Container(
    margin: EdgeInsets.only(bottom: 20.0),
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.white,
    ),
    child: Column(
      children: [
        PhysicalModel(
          color: Colors.transparent,
          shadowColor: Colors.green,
          elevation: 20,
          child: Container(
            width: 380,
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
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(avatarUrl)),
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
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[500]
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
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[500]
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
    ),
  );
}
