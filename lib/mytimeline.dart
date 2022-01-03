import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group9/maininterface.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');
String? documentId;
String username = "";
String dpUrl = "";
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
    getCurrentUser();
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
                      FutureBuilder<DocumentSnapshot>(
                        future: users.doc(documentId).get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }

                          if (snapshot.hasData && !snapshot.data!.exists) {
                            return Text("Document does not exist");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            dpUrl = data['dpUrl'];
                            return Container(
                              child: CircleAvatar(
                                radius: 75,
                                backgroundImage: NetworkImage(dpUrl),
                              ),
                            );
                          }
                          return Text("loading");
                        },
                      ),
                      FutureBuilder<DocumentSnapshot>(
                        future: users.doc(documentId).get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }

                          if (snapshot.hasData && !snapshot.data!.exists) {
                            return Text("Document does not exist");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            username = data['username'];
                            return Text(
                              username,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w900,
                              ),
                            );
                          }
                          return Text("loading");
                        },
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[PostFeed()],
                          ),
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

Widget PostFeed() {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('sharing')
          .where('userID', isEqualTo: documentId)
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

            return PhysicalModel(
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
                    AvatarandUsername(dpUrl, username, data!['time']),
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
                                    child: Image.network(data!['imageUrl'])))
                            : null),
                    SizedBox(
                      height: 10,
                    ),
                    LikeandDislike()
                  ],
                ),
              ),
            );
          }).toList(),
        );
      });
}

Widget AvatarandUsername(String avatarUrl, String userName, Timestamp date) {
  DateTime d = date.toDate();

  return Row(
    children: <Widget>[
      FittedBox(
        fit: BoxFit.contain,
        child: CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
      ),
      SizedBox(
        width: 8,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(userName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(
            d.toString(),
            style: TextStyle(color: Colors.grey[600]),
          )
        ],
      )
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

void getCurrentUser() async {
  final User? user = FirebaseAuth.instance.currentUser;
  final uid = user!.uid;
  documentId = uid;
}

// Future<List> listCaption() async {
//   List<String> caption = [];
//   await FirebaseFirestore.instance
//       .collection('sharing')
//       .where('userID', isEqualTo: documentId)
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     querySnapshot.docs.forEach((doc) {
//       caption.add(doc['caption']);
//     });
//   });

//   return Future.value(caption);
// }

// Future<List> listCaptionVar = listCaption();

// Future<List> listImage() async {
//   List<String> imageUrl = [];
//   await FirebaseFirestore.instance
//       .collection('sharing')
//       .where('userID', isEqualTo: documentId)
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     querySnapshot.docs.forEach((doc) {
//       imageUrl.add(doc['imageUrl']);
//     });
//   });

//   return Future.value(imageUrl);
// }

// Future<List> listImageVar = listImage();

// Future<List> listTime() async {
//   List<String> time = [];
//   await FirebaseFirestore.instance
//       .collection('sharing')
//       .where('userID', isEqualTo: documentId)
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     querySnapshot.docs.forEach((doc) {
//       DateTime d = doc['time'].toDate();
//       time.add(d.toString());
//     });
//   });

//   return Future.value(time);
// }

// Future<List> listTimeVar = listTime();

// Future<List> listNum() async {
//   List<String> userID = [];
//   await FirebaseFirestore.instance
//       .collection('sharing')
//       .where('userID', isEqualTo: documentId)
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     querySnapshot.docs.forEach((doc) {
//       userID.add(doc['userID']);
//     });
//   });

//   return Future.value(userID);
// }

// Future<List> listNumVar = listNum();

// FutureBuilder(
                              //     future: listNumVar,
                              //     builder: (BuildContext context,
                              //         AsyncSnapshot<List> snapshot) {
                              //       if (snapshot.connectionState ==
                              //           ConnectionState.done) {
                              //         return ListView.builder(
                              //           physics: NeverScrollableScrollPhysics(),
                              //           shrinkWrap: true,
                              //           itemCount: snapshot.data!.length,
                              //           itemBuilder:
                              //               (BuildContext context, int index) {
                              //             return Column(
                              //               children: [
                              //                 PhysicalModel(
                              //                   color: Colors.transparent,
                              //                   shadowColor: Colors.green,
                              //                   elevation: 20,
                              //                   child: Container(
                              //                     margin: EdgeInsets.only(
                              //                         bottom: 20.0),
                              //                     width: 360,
                              //                     padding: const EdgeInsets.all(
                              //                         12.0),
                              //                     decoration: BoxDecoration(
                              //                       color: Colors.grey[200],
                              //                       borderRadius:
                              //                           BorderRadius.circular(
                              //                               10.0),
                              //                     ),
                              //                     child: Column(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment.start,
                              //                       crossAxisAlignment:
                              //                           CrossAxisAlignment
                              //                               .start,
                              //                       children: <Widget>[
                              //                         FutureBuilder(
                              //                             future: listTimeVar,
                              //                             builder: (BuildContext
                              //                                     context,
                              //                                 AsyncSnapshot<
                              //                                         List>
                              //                                     snapshot) {
                              //                               if (snapshot
                              //                                       .connectionState ==
                              //                                   ConnectionState
                              //                                       .done) {
                              //                                 return AvatarandUsername(
                              //                                     dpUrl,
                              //                                     username,
                              //                                     snapshot
                              //                                         .data![
                              //                                             index]
                              //                                         .toString());
                              //                               }

                              //                               return Text(
                              //                                   "Loading");
                              //                             }),
                              //                         SizedBox(
                              //                           height: 10,
                              //                         ),
                              //                         FutureBuilder(
                              //                             future:
                              //                                 listCaptionVar,
                              //                             builder: (BuildContext
                              //                                     context,
                              //                                 AsyncSnapshot<
                              //                                         List>
                              //                                     snapshot) {
                              //                               if (snapshot
                              //                                       .connectionState ==
                              //                                   ConnectionState
                              //                                       .done) {
                              //                                 return Container(
                              //                                     child: Text(
                              //                                   snapshot.data![
                              //                                       index],
                              //                                   style:
                              //                                       TextStyle(
                              //                                     fontSize: 16,
                              //                                   ),
                              //                                 ));
                              //                               }

                              //                               return Text(
                              //                                   "Loading");
                              //                             }),
                              //                         SizedBox(
                              //                           height: 10,
                              //                         ),
                              //                         FutureBuilder(
                              //                             future: listImageVar,
                              //                             builder: (BuildContext
                              //                                     context,
                              //                                 AsyncSnapshot<
                              //                                         List>
                              //                                     snapshot) {
                              //                               if (snapshot
                              //                                       .connectionState ==
                              //                                   ConnectionState
                              //                                       .done) {
                              //                                 if (snapshot.data![
                              //                                         index] !=
                              //                                     "") {
                              //                                   return SizedBox(
                              //                                     width: double
                              //                                         .infinity,
                              //                                     height: 200,
                              //                                     child:
                              //                                         FittedBox(
                              //                                       fit: BoxFit
                              //                                           .fill,
                              //                                       child: Image.network(
                              //                                           snapshot
                              //                                               .data![index]),
                              //                                     ),
                              //                                   );
                              //                                 } else {
                              //                                   return SizedBox();
                              //                                 }
                              //                               }

                              //                               return Text(
                              //                                   "Loading");
                              //                             }),
                              //                         SizedBox(
                              //                           height: 10,
                              //                         ),
                              //                         LikeandDislike()
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ],
                              //             );
                              //           },
                              //         );
                              //       }
                              //       return Text("Loading");
                              //     }),