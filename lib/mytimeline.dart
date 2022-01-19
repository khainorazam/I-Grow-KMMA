import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group9/editpost.dart';
import 'package:flutter_group9/maininterface.dart';
import 'package:intl/intl.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');
String? documentId = FirebaseAuth.instance.currentUser?.uid;
String temp = "";
bool refresh = false;
Map<String, dynamic>? data;

class MyTimeline extends StatefulWidget {
  const MyTimeline({Key? key}) : super(key: key);
  @override
  _MyTimelineState createState() => _MyTimelineState();
}

class _MyTimelineState extends State<MyTimeline> {
  @override
  void initState() {
    super.initState();
    documentId = FirebaseAuth.instance.currentUser?.uid;
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
      body: !_isLoadingFeed
          ? RefreshIndicator(
              onRefresh: () => _setupFeed(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 22,
                      ),
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
                                data = document.data() as Map<String, dynamic>;
                                return Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 75,
                                      backgroundImage:
                                          NetworkImage(data!['dpUrl']),
                                    ),
                                    Text(
                                      data!['username'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            );
                          }),
                      SizedBox(
                        height: 22,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                    data =
                                        document.data() as Map<String, dynamic>;
                                    return PostFeed(
                                        data!['dpUrl'], data!['username']);
                                  }).toList(),
                                );
                              }),
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
    );
  }
}

Widget PostFeed(String? avatarUrl, String userName) {
  DateTime d;
  String date;
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
            d = DateTime.parse((data!['time'].toDate()).toString());
            date = convertToAgo(d);

            return Column(children: [
              if (data!['userID'] == documentId)
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
                        AvatarandUsername(avatarUrl, userName, date,
                            document.id, documentId!, context),
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
                      ],
                    ),
                  ),
                )
            ]);
          }).toList(),
        );
      });
}

String convertToAgo(DateTime input) {
  Duration diff = DateTime.now().difference(input);

  if (diff.inDays >= 1) {
    return '${diff.inDays} day(s) ago';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours} hour(s) ago';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} minute(s) ago';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds} second(s) ago';
  } else {
    return 'just now';
  }
}

Widget AvatarandUsername(String? avatarUrl, String userName, String date,
    String ID, String userID, BuildContext context) {
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
      Expanded(
        flex: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              color: Colors.purple.shade600,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text(
                            "Choose option",
                            style: TextStyle(color: Colors.blue),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Divider(
                                  height: 1,
                                  color: Colors.blue,
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.of(ctx).pop();
                                    deletePost(ID, context);
                                  },
                                  title: Text("Delete Post"),
                                ),
                                Divider(
                                  height: 1,
                                  color: Colors.blue,
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.of(ctx).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => EditPost(
                                          docID: ID,
                                        ),
                                      ),
                                    );
                                  },
                                  title: Text("Edit Post"),
                                ),
                              ],
                            ),
                          ),
                        ));
              },
            ),
          ],
        ),
      )
    ],
  );
}

Future<void> deletePost(String ID, BuildContext context) async {
  CollectionReference sharing =
      FirebaseFirestore.instance.collection('sharing');
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text(
              "Confirm Delete",
              style: TextStyle(color: Colors.red),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.red,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(ctx).pop();
                      sharing
                          .doc(ID)
                          .delete()
                          .then((value) => print("Sharing Deleted"))
                          .catchError((error) =>
                              print("Failed to delete user: $error"));
                    },
                    title: Text(
                      "Yes",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ));
}
