import 'package:flutter/material.dart';
import 'package:flutter_group9/chats/chatbox.dart';
import 'package:flutter_group9/newpost.dart';
import 'package:flutter_group9/mytimeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'maininterface.dart';
import 'widget/custom_post.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');
String? documentId = FirebaseAuth.instance.currentUser?.uid;

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    super.initState();
    _setupFeed();
  }

  _setupFeed() async {
    setState(() => _isLoadingFeed = true);

    setState(() {
      build(context);
      //PostFeed();
      _isLoadingFeed = false;
    });
  }

  bool _isLoadingFeed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade100,
      body: !_isLoadingFeed
          ? RefreshIndicator(
              onRefresh: () => _setupFeed(),
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
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
                              StreamBuilder(
                                  stream: users
                                      .where('userid', isEqualTo: documentId)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Something went wrong');
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text("Loading");
                                    }

                                    return ListView(
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      children: snapshot.data!.docs
                                          .map((DocumentSnapshot document) {
                                        data = document.data()
                                            as Map<String, dynamic>;

                                        return Row(
                                          children: <Widget>[
                                            FittedBox(
                                              fit: BoxFit.contain,
                                              child: CircleAvatar(
                                                radius: 25.0,
                                                backgroundImage: NetworkImage(
                                                    data!['dpUrl']),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data!['username'],
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 30.0,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    );
                                  }),
                              SizedBox(
                                height: 5.0,
                              ),
                              Divider(
                                color: Color(0xFF505050),
                                thickness: 1.5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  actionButton(
                                      Icons.assignment_ind_rounded,
                                      "MyTimeline",
                                      Color(0xFFF23E5C),
                                      "MyTimeline"),
                                  actionButton(
                                      Icons.mail_outline_rounded,
                                      "Messages",
                                      Color(0xFF2962FF),
                                      "Messages"),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder<QuerySnapshot>(
                              stream: users
                                  .where('userid', isEqualTo: documentId)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text("Loading");
                                }
                                return ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    data =
                                        document.data() as Map<String, dynamic>;

                                    List<String> strArr =
                                        List.from(data!['friend_uid']);
                                    strArr.add(documentId!);
                                    return PostFeed(strArr);
                                  }).toList(),
                                );
                              })
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
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

Widget PostFeed(List userid) {
  DateTime d;
  String postID;
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('sharing')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            data = document.data() as Map<String, dynamic>;
            d = data!['time'].toDate();
            postID = document.id;
            return Column(children: [
              for (int i = 0; i < userid.length; i++)
                if (data!['userID'] != userid[i])
                  SizedBox()
                else
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
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .where('userid', isEqualTo: userid[i])
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot2) {
                                if (snapshot2.hasError) {
                                  return Text('Something went wrong');
                                }

                                if (snapshot2.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text("Loading");
                                }

                                return ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  children: snapshot2.data!.docs
                                      .map((DocumentSnapshot document) {
                                    data =
                                        document.data() as Map<String, dynamic>;
                                    return AvatarandUsername(
                                        data!['dpUrl'],
                                        data!['username'],
                                        d.toString(),
                                        postID,
                                        context);
                                  }).toList(),
                                );
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              child: Text(
                            data!['caption'],
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              child: data!['imageUrl'] != temp
                                  ? SizedBox(
                                      width: double.infinity,
                                      height: 200,
                                      child: FittedBox(
                                          fit: BoxFit.fill,
                                          child:
                                              Image.network(data!['imageUrl'])))
                                  : null),
                          SizedBox(
                            height: 10,
                          ),
                          LikeandDislike()
                        ],
                      ),
                    ),
                  )
            ]);
          }).toList(),
        );
      });
}

Widget AvatarandUsername(String? avatarUrl, String userName, String date,
    String ID, BuildContext context) {
  return Row(
    children: <Widget>[
      FittedBox(
        fit: BoxFit.contain,
        child: CircleAvatar(backgroundImage: NetworkImage(avatarUrl!)),
      ),
      SizedBox(
        width: 8.0,
      ),
      Expanded(
        flex: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(userName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(
              date,
              style: TextStyle(color: Colors.grey[600]),
            )
          ],
        ),
      ),
    ],
  );
}

Widget LikeandDislike() {
  return Container(
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
              icon: Icon(Icons.thumb_up_outlined, color: Colors.grey[500]
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
              icon: Icon(Icons.thumb_down_outlined, color: Colors.grey[500]
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
  );
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
          }
          if (nextPage == "Messages") {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatScreen()));
          }
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
