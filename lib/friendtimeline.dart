import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group9/profile/page/other_profile.dart';
import 'package:intl/intl.dart';
import 'maininterface.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');
String? documentid;
String temp1 = "";
bool refresh = false;
Map<String, dynamic>? data1;

class FriendTimeline extends StatefulWidget {
  final String userid;
  const FriendTimeline({Key? key, required this.userid}) : super(key: key);

  @override
  _FriendTimelineState createState() =>
      _FriendTimelineState(userid: this.userid);
}

class _FriendTimelineState extends State<FriendTimeline> {
  String userid;
  _FriendTimelineState({required this.userid});
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
    documentid = userid;
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
                              .where('userid', isEqualTo: documentid)
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
                                data1 = document.data() as Map<String, dynamic>;
                                return Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 75,
                                      backgroundImage:
                                          NetworkImage(data1!['dpUrl']),
                                    ),
                                    Text(
                                      data1!['username'],
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
                        height: 5,
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        ProfilePage2(userid: documentid!)));
                          },
                          child: Text(
                            "View Profile",
                            style: TextStyle(color: Colors.blueAccent),
                          )),
                      SizedBox(
                        height: 22,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder(
                              stream: users
                                  .where('userid', isEqualTo: documentid)
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
                                    data1 =
                                        document.data() as Map<String, dynamic>;
                                    return PostFeed(
                                        data1!['dpUrl'], data1!['username']);
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
            data1 = document.data() as Map<String, dynamic>;
            d = DateTime.parse((data1!['time'].toDate()).toString());
            date = convertToAgo(d);
            return Column(children: [
              if (data1!['userID'] == documentid)
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
                            document.id, documentid!, context),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            child: Text(
                          data1!['caption'],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            child: data1!['imageUrl'] != temp1
                                ? SizedBox(
                                    width: double.infinity,
                                    height: 200,
                                    child: FittedBox(
                                        fit: BoxFit.fill,
                                        child:
                                            Image.network(data1!['imageUrl'])))
                                : null),
                      ],
                    ),
                  ),
                )
              else
                SizedBox()
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
    ],
  );
}

// Widget LikeandDislike() {
//   return Container(
//     width: double.infinity,
//     height: 40,
//     decoration: BoxDecoration(
//         border: Border(
//             top: BorderSide(
//               color: Colors.grey.shade500,
//             ),
//             bottom: BorderSide(
//               color: Colors.grey.shade500,
//             ))),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         Row(
//           children: [
//             IconButton(
//               iconSize: 20,
//               onPressed: () {},
//               icon: Icon(Icons.thumb_up_outlined, color: Colors.grey[500]
//                   //_likeStatus ? Colors.green[700] : Colors.grey[500],
//                   ),
//               tooltip: "Like this post",
//             ),
//             Text(
//               "Like",
//               style: TextStyle(fontSize: 14, color: Colors.grey[500]
//                   //_likeStatus ? Colors.green[700]: Colors.grey[500]
//                   ),
//             )
//           ],
//         ),
//         Row(
//           children: [
//             IconButton(
//               iconSize: 20,
//               onPressed: () {},
//               icon: Icon(Icons.thumb_down_outlined, color: Colors.grey[500]
//                   //_likeStatus ? Colors.green[700] : Colors.grey[500],
//                   ),
//               tooltip: "Like this post",
//             ),
//             Text(
//               "Dislike",
//               style: TextStyle(fontSize: 14, color: Colors.grey[500]
//                   //_likeStatus ? Colors.green[700]: Colors.grey[500]
//                   ),
//             )
//           ],
//         ),
//       ],
//     ),
//   );
// }
