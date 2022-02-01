import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group9/friendtimeline.dart';
import 'package:flutter_group9/login.dart';
import 'package:flutter_group9/mytimeline.dart';
import 'package:flutter_group9/profile.dart';
import 'package:flutter_group9/searchfriends.dart';
import 'package:flutter_group9/widget/custom_page_route.dart';

class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FriendsState();
  }
}

class FriendsState extends State<Friends> {
  List<Color> _colors = <Color>[
    Colors.red.shade600,
    Colors.green.shade600,
  ];
  //variable declaration
  var _currentColorIndex = 0;
  var _currentOverlayIndex = 1;
  var friendStatus = true;
  var _buttonText = "Remove Friend";

  //update join button color
  void updateColor() {
    if (_currentColorIndex == 0) {
      _currentColorIndex = 1;
      _currentOverlayIndex = 0;
    } else if (_currentColorIndex == 1) {
      _currentColorIndex = 0;
      _currentOverlayIndex = 1;
    }
  }

  void deleteFriendReq() {
    _showDeleteFriendReqDialog();
  }

  Future<void> _showDeleteFriendReqDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Friend Request'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Would you like to delete this friend request?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                // updateStatus();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //Confirm Remove Dialog
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Friend Removal'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Would you like to remove this friend?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                updateStatus();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void removeFriend() {
    if (friendStatus == false) {
      updateStatus();
    } else if (friendStatus == true) {
      _showMyDialog();
    }
  }

  //update join status
  void updateStatus() {
    if (friendStatus == true) {
      setState(() {
        friendStatus = false;
        updateColor();
        // updateMembersNum(_joinStatus);
        // updateIsPostDisabled(_joinStatus);
        // hasBeenPressed = true;
      });
      _buttonText = "Add Friend";
      print("status : $friendStatus");
    } else if (friendStatus == false) {
      // _showMyDialog();
      setState(() {
        friendStatus = true;
        updateColor();
        // updateMembersNum(_joinStatus);
        // updateIsPostDisabled(_joinStatus);
        // hasBeenPressed = false;
      });
      _buttonText = "Remove Friend";
      print("status : $friendStatus");
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> friendPic = [
      "assets/womenprofilepic.jpg",
      "assets/azam.jpg",
      "assets/menprofilepic.png",
      "assets/womenprofilepic.jpg",
      "assets/spinach.jpg",
      "assets/mushroom.jfif",
      "assets/pumpkin.jfif",
      "assets/brinjal.png",
    ];

    String? user = FirebaseAuth.instance.currentUser?.uid;

    final Stream<QuerySnapshot> friend = FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: user)
        // .orderBy('id')
        .snapshots();

    final Stream<QuerySnapshot> alluser =
        FirebaseFirestore.instance.collection('users').snapshots();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.lightGreen.shade100),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(30),
                    child: const Text(
                      'Friends',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: const Text(
                              "Friend Requests",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: alluser,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading");
                              }

                              var data = snapshot.requireData;

                              return ListView.builder(
                                itemCount: data.size,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return StreamBuilder(
                                    stream: friend,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot>
                                            snapshot2) {
                                      if (snapshot2.hasError) {
                                        return Text("something is wrong");
                                      }
                                      if (snapshot2.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (data.docs[index]['userid'] == user) {
                                        return SizedBox.shrink();
                                      }

                                      var added = snapshot2.data!.docChanges[0]
                                          .doc['request_uid'];
                                      // snapshot2.data!.docChanges[0].doc['pending_uid'];
                                      bool check = added
                                          .contains(data.docs[index]['userid']);

                                      print(added);
                                      print(data.docs[index]['userid']);
                                      print(check);
                                      if (!check) {
                                        return SizedBox.shrink();
                                      } else {
                                        return FriendRequestBox(
                                            index,
                                            data.docs[index]['dpUrl'],
                                            data.docs[index]['username'],
                                            data.docs[index]['userid'],
                                            context);
                                      }
                                    },
                                  );
                                },
                              );
                            })
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: const Text(
                              "My Friends",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: alluser,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading");
                              }

                              var data = snapshot.requireData;

                              return ListView.builder(
                                itemCount: data.size,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return StreamBuilder(
                                    stream: friend,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot>
                                            snapshot2) {
                                      if (snapshot2.hasError) {
                                        return Text("something is wrong");
                                      }
                                      if (snapshot2.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (data.docs[index]['userid'] == user) {
                                        return SizedBox.shrink();
                                      }

                                      var added = snapshot2.data!.docChanges[0]
                                          .doc['friend_uid'];
                                      // snapshot2.data!.docChanges[0].doc['pending_uid'];
                                      bool check = added
                                          .contains(data.docs[index]['userid']);

                                      print(added);
                                      print(data.docs[index]['userid']);
                                      print(check);
                                      if (!check) {
                                        return SizedBox.shrink();
                                      } else {
                                        return FriendBox(
                                            index,
                                            data.docs[index]['dpUrl'],
                                            data.docs[index]['username'],
                                            data.docs[index]['userid'],
                                            context);
                                      }
                                    },
                                  );
                                },
                              );
                            })
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: const Text(
                              "Friend Suggestions",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: alluser,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading");
                              }

                              var data = snapshot.requireData;

                              return ListView.builder(
                                itemCount: data.size,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return StreamBuilder(
                                    stream: friend,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot>
                                            snapshot2) {
                                      if (snapshot2.hasError) {
                                        return Text("something is wrong");
                                      }
                                      if (snapshot2.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (data.docs[index]['userid'] == user) {
                                        return SizedBox.shrink();
                                      }

                                      var added = snapshot2
                                          .data!.docChanges[0].doc['sugg_uid'];
                                      // var notfriends = !added;
                                      // snapshot2.data!.docChanges[0].doc['pending_uid'];
                                      bool check = added
                                          .contains(data.docs[index]['userid']);

                                      print(added);
                                      print(data.docs[index]['userid']);
                                      print(check);
                                      if (!check) {
                                        return SizedBox.shrink();
                                      } else {
                                        return FriendSuggestionBox(
                                            index,
                                            data.docs[index]['dpUrl'],
                                            data.docs[index]['username'],
                                            data.docs[index]['userid'],
                                            context);
                                      }
                                    },
                                  );
                                },
                              );
                            })
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: const Text(
                              "Pending Requests",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: alluser,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading");
                              }

                              var data = snapshot.requireData;

                              return ListView.builder(
                                itemCount: data.size,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return StreamBuilder(
                                    stream: friend,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot>
                                            snapshot2) {
                                      if (snapshot2.hasError) {
                                        return Text("something is wrong");
                                      }
                                      if (snapshot2.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (data.docs[index]['userid'] == user) {
                                        return SizedBox.shrink();
                                      }

                                      var added = snapshot2.data!.docChanges[0]
                                          .doc['pending_uid'];
                                      // snapshot2.data!.docChanges[0].doc['pending_uid'];
                                      bool check = added
                                          .contains(data.docs[index]['userid']);

                                      print(added);
                                      print(data.docs[index]['userid']);
                                      print(check);
                                      if (!check) {
                                        return SizedBox.shrink();
                                      } else {
                                        return FriendPendingBox(
                                            index,
                                            data.docs[index]['dpUrl'],
                                            data.docs[index]['username'],
                                            data.docs[index]['userid'],
                                            context);
                                      }
                                    },
                                  );
                                },
                              );
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showSearch(
      //       context: context,
      //       delegate: SearchFriends(),
      //     );
      //   },
      //   child: const Icon(Icons.search),
      //   backgroundColor: Colors.green[700],
      //   tooltip: "Search Friends",
      // ),
    );
  }
}

// Future<List> listBoxFunction() {
//   List<String> friendName = [];
//   FirebaseFirestore.instance
//       .collection('testfriend')
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     querySnapshot.docs.forEach((doc) {
//       print(doc['friendName']);
//       friendName.add(doc['friendName']);
//     });
//   });

//   return Future.value(friendName);
// }

// Future<List> listBoxVariable = listBoxFunction();

Widget FriendBox(int num, String friendPic, String friendName, String userID,
    BuildContext context) {
  List<Color> _colors = <Color>[
    Colors.red.shade600,
    Colors.green.shade600,
  ];
  //variable declaration 
  var _currentColorIndex = 0;
  var _currentOverlayIndex = 1;
  var friendStatus = true;
  var _buttonText = "Remove Friend";

  //update join button color
  void updateColor() {
    if (_currentColorIndex == 0) {
      _currentColorIndex = 1;
      _currentOverlayIndex = 0;
    } else if (_currentColorIndex == 1) {
      _currentColorIndex = 0;
      _currentOverlayIndex = 1;
    }
  }

  void updateStatus() {
    if (friendStatus == true) {
      friendStatus = false;
      updateColor();
      // updateMembersNum(_joinStatus);
      // updateIsPostDisabled(_joinStatus);
      // hasBeenPressed = true;

      _buttonText = "Add Friend";
      print("status : $friendStatus");
    } else if (friendStatus == false) {
      // _showMyDialog();

      friendStatus = true;
      updateColor();
      // updateMembersNum(_joinStatus);
      // updateIsPostDisabled(_joinStatus);
      // hasBeenPressed = false;

      _buttonText = "Remove Friend";
      print("status : $friendStatus");
    }
  }

  String? user = FirebaseAuth.instance.currentUser?.uid;

  final Stream<QuerySnapshot> friend = FirebaseFirestore.instance
      .collection('users')
      .where('userid', isEqualTo: user)
      // .orderBy('id')
      .snapshots();

  final Stream<QuerySnapshot> alluser =
      FirebaseFirestore.instance.collection('users').snapshots();

//Confirm Remove Dialog
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StreamBuilder<QuerySnapshot>(
            stream: alluser,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              var data = snapshot.requireData;

              return StreamBuilder(
                  stream: friend,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot2) {
                    if (snapshot2.hasError) {
                      return Text("something is wrong");
                    }
                    if (snapshot2.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return AlertDialog(
                      title: Text('Friend Removal'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Text('Would you like to remove this friend?'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Confirm'),
                          onPressed: () {
                            snapshot.data!.docs[num].reference.update({
                              'friend_uid': FieldValue.arrayRemove([user]),
                            });
                            snapshot2.data!.docs[0].reference.update({
                              'friend_uid': FieldValue.arrayRemove(
                                  [snapshot.data!.docs[num]['userid']]),
                            });
                            // deleteFriend(num);
                            Navigator.of(context).pop();
                            // snapshot.data!.docs[index].reference.update({
                            //   'friend_uid': FieldValue.arrayRemove([user]),
                            // })
                            // snapshot2.data!.docs[0].reference.update({
                            //   'friend_uid': FieldValue.arrayRemove(
                            //       [snapshot.data!.docs[index]['userid']]),
                            // })
                          },
                        ),
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            });
      },
    );
  }

  void removeFriend() {
    if (friendStatus == false) {
      updateStatus();
    } else if (friendStatus == true) {
      _showMyDialog();
    }
  }

  //update join status

  return PhysicalModel(
    color: Colors.transparent,
    shadowColor: Colors.green,
    elevation: 20,
    child: Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 60.0,
            child: ElevatedButton(
                onPressed: () {
                  print(userID);
                  if (userID == documentId) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyTimeline()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FriendTimeline(userid: userID)));
                  }
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(friendPic),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Text(
                                    friendName,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            _colors[_currentColorIndex]),
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                            _colors[_currentOverlayIndex]),
                                  ),
                                  onPressed: removeFriend,
                                  child: Text(
                                    _buttonText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(height: 8),
        ],
      ),
    ),
  );
}

Widget FriendRequestBox(int num, String friendPic, String friendName,
    String userID, BuildContext context) {
  List<Color> _colors = <Color>[
    Colors.red.shade600,
    Colors.green.shade600,
  ];

  String? user = FirebaseAuth.instance.currentUser?.uid;

  final Stream<QuerySnapshot> friend = FirebaseFirestore.instance
      .collection('users')
      .where('userid', isEqualTo: user)
      // .orderBy('id')
      .snapshots();

  final Stream<QuerySnapshot> alluser =
      FirebaseFirestore.instance.collection('users').snapshots();

  Future<void> _showDeleteFriendReqDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StreamBuilder<QuerySnapshot>(
            stream: alluser,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              var data = snapshot.requireData;

              return StreamBuilder(
                  stream: friend,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot2) {
                    if (snapshot2.hasError) {
                      return Text("something is wrong");
                    }
                    if (snapshot2.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return AlertDialog(
                      title: Text('Delete Friend Request'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Text(
                                'Would you like to delete this friend request?'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Confirm'),
                          onPressed: () {
                            snapshot.data!.docs[num].reference.update({
                              'pending_uid': FieldValue.arrayRemove([user]),
                            });
                            snapshot2.data!.docs[0].reference.update({
                              'request_uid': FieldValue.arrayRemove(
                                  [snapshot.data!.docs[num]['userid']]),
                            });

                            Navigator.of(context).pop();
                            // updateStatus();
                          },
                        ),
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            });
      },
    );
  }

  void deleteFriendReq() {
    _showDeleteFriendReqDialog();
  }

  return StreamBuilder<QuerySnapshot>(
      stream: alluser,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        var data = snapshot.requireData;

        return StreamBuilder(
            stream: friend,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
              if (snapshot2.hasError) {
                return Text("something is wrong");
              }
              if (snapshot2.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return PhysicalModel(
                color: Colors.transparent,
                shadowColor: Colors.green,
                elevation: 20,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 60.0,
                    child: ElevatedButton(
                      onPressed: () {
                        print(userID);
                        if (userID == documentId) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyTimeline()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      FriendTimeline(userid: userID)));
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(friendPic),
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Container(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(
                                        friendName,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      children: [
                                        IconButton(
                                            iconSize: 35.0,
                                            onPressed: () {
                                              snapshot.data!.docs[num].reference
                                                  .update({
                                                'pending_uid':
                                                    FieldValue.arrayRemove(
                                                        [user]),
                                              });
                                              snapshot.data!.docs[num].reference
                                                  .update({
                                                'friend_uid':
                                                    FieldValue.arrayUnion(
                                                        [user]),
                                              });
                                              snapshot2.data!.docs[0].reference
                                                  .update({
                                                'friend_uid':
                                                    FieldValue.arrayUnion([
                                                  snapshot.data!.docs[num]
                                                      ['userid']
                                                ]),
                                              });
                                              snapshot2.data!.docs[0].reference
                                                  .update({
                                                'request_uid':
                                                    FieldValue.arrayRemove([
                                                  snapshot.data!.docs[num]
                                                      ['userid']
                                                ]),
                                              });
                                            },
                                            icon: Icon(
                                              Icons.check_circle_outline,
                                              color: Colors.green[600],
                                            )),
                                        IconButton(
                                            iconSize: 35.0,
                                            onPressed: deleteFriendReq,
                                            icon: Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.red[600],
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      });
}

Widget FriendSuggestionBox(int num, String friendPic, String friendName,
    String userID, BuildContext context) {
  List<Color> _colors = <Color>[
    Colors.red.shade600,
    Colors.green.shade600,
  ];
  //variable declaration
  var _currentColorIndex = 1;
  var _currentOverlayIndex = 0;
  var friendStatus = true;
  var _buttonText = "Add Friend";

  //update join button color
  void updateColor() {
    if (_currentColorIndex == 0) {
      _currentColorIndex = 1;
      _currentOverlayIndex = 0;
    } else if (_currentColorIndex == 1) {
      _currentColorIndex = 0;
      _currentOverlayIndex = 1;
    }
  }

  void updateStatus() {
    if (friendStatus == true) {
      friendStatus = false;
      updateColor();
      // updateMembersNum(_joinStatus);
      // updateIsPostDisabled(_joinStatus);
      // hasBeenPressed = true;

      _buttonText = "Add Friend";
      print("status : $friendStatus");
    } else if (friendStatus == false) {
      // _showMyDialog();

      friendStatus = true;
      updateColor();
      // updateMembersNum(_joinStatus);
      // updateIsPostDisabled(_joinStatus);
      // hasBeenPressed = false;

      _buttonText = "Remove Friend";
      print("status : $friendStatus");
    }
  }

  String? user = FirebaseAuth.instance.currentUser?.uid;

  final Stream<QuerySnapshot> friend = FirebaseFirestore.instance
      .collection('users')
      .where('userid', isEqualTo: user)
      // .orderBy('id')
      .snapshots();

  final Stream<QuerySnapshot> alluser =
      FirebaseFirestore.instance.collection('users').snapshots();

//Confirm Remove Dialog
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StreamBuilder<QuerySnapshot>(
            stream: alluser,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              var data = snapshot.requireData;

              return StreamBuilder(
                  stream: friend,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot2) {
                    if (snapshot2.hasError) {
                      return Text("something is wrong");
                    }
                    if (snapshot2.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return AlertDialog(
                      title: Text('Friend Removal'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Text('Would you like to remove this friend?'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Confirm'),
                          onPressed: () {
                            snapshot.data!.docs[num].reference.update({
                              'friend_uid': FieldValue.arrayRemove([user]),
                            });
                            snapshot2.data!.docs[0].reference.update({
                              'friend_uid': FieldValue.arrayRemove(
                                  [snapshot.data!.docs[num]['userid']]),
                            });
                            // deleteFriend(num);
                            Navigator.of(context).pop();
                            // snapshot.data!.docs[index].reference.update({
                            //   'friend_uid': FieldValue.arrayRemove([user]),
                            // })
                            // snapshot2.data!.docs[0].reference.update({
                            //   'friend_uid': FieldValue.arrayRemove(
                            //       [snapshot.data!.docs[index]['userid']]),
                            // })
                          },
                        ),
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            });
      },
    );
  }

  void removeFriend() {
    if (friendStatus == false) {
      updateStatus();
    } else if (friendStatus == true) {
      _showMyDialog();
    }
  }

  //update join status

  return StreamBuilder<QuerySnapshot>(
      stream: alluser,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        var data = snapshot.requireData;

        return StreamBuilder(
            stream: friend,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
              if (snapshot2.hasError) {
                return Text("something is wrong");
              }
              if (snapshot2.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return PhysicalModel(
                color: Colors.transparent,
                shadowColor: Colors.green,
                elevation: 20,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 60.0,
                        child: ElevatedButton(
                            onPressed: () {
                              print(userID);
                              if (userID == documentId) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyTimeline()));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            FriendTimeline(userid: userID)));
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(friendPic),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: SingleChildScrollView(
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              child: Text(
                                                friendName,
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .all<Color>(_colors[
                                                            _currentColorIndex]),
                                                overlayColor: MaterialStateProperty
                                                    .all<Color>(_colors[
                                                        _currentOverlayIndex]),
                                              ),
                                              //kat sini 
                                              onPressed: () {
                                                snapshot
                                                    .data!.docs[num].reference
                                                    .update({
                                                  'request_uid':
                                                      FieldValue.arrayUnion(
                                                          [user]),
                                                });
                                                snapshot2
                                                    .data!.docs[0].reference
                                                    .update({
                                                  'pending_uid':
                                                      FieldValue.arrayUnion([
                                                    snapshot.data!.docs[num]
                                                        ['userid']
                                                  ]),
                                                });
                                                snapshot2
                                                    .data!.docs[0].reference
                                                    .update({
                                                  'sugg_uid':
                                                      FieldValue.arrayRemove([
                                                    snapshot.data!.docs[num]
                                                        ['userid']
                                                  ]),
                                                });
                                              },
                                              child: Text(
                                                _buttonText,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            });
      });
}

Widget FriendPendingBox(int num, String friendPic, String friendName,
    String userID, BuildContext context) {
  List<Color> _colors = <Color>[
    Colors.red.shade600,
    Colors.green.shade600,
  ];
  //variable declaration
  var _currentColorIndex = 0;
  var _currentOverlayIndex = 1;
  var friendStatus = true;
  var _buttonText = "Cancel Add Friend";

  //update join button color
  void updateColor() {
    if (_currentColorIndex == 0) {
      _currentColorIndex = 1;
      _currentOverlayIndex = 0;
    } else if (_currentColorIndex == 1) {
      _currentColorIndex = 0;
      _currentOverlayIndex = 1;
    }
  }

  void updateStatus() {
    if (friendStatus == true) {
      friendStatus = false;
      updateColor();
      // updateMembersNum(_joinStatus);
      // updateIsPostDisabled(_joinStatus);
      // hasBeenPressed = true;

      _buttonText = "Add Friend";
      print("status : $friendStatus");
    } else if (friendStatus == false) {
      // _showMyDialog();

      friendStatus = true;
      updateColor();
      // updateMembersNum(_joinStatus);
      // updateIsPostDisabled(_joinStatus);
      // hasBeenPressed = false;

      _buttonText = "Remove Friend";
      print("status : $friendStatus");
    }
  }

  String? user = FirebaseAuth.instance.currentUser?.uid;

  final Stream<QuerySnapshot> friend = FirebaseFirestore.instance
      .collection('users')
      .where('userid', isEqualTo: user)
      // .orderBy('id')
      .snapshots();

  final Stream<QuerySnapshot> alluser =
      FirebaseFirestore.instance.collection('users').snapshots();

//Confirm Remove Dialog
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StreamBuilder<QuerySnapshot>(
            stream: alluser,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              var data = snapshot.requireData;

              return StreamBuilder(
                  stream: friend,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot2) {
                    if (snapshot2.hasError) {
                      return Text("something is wrong");
                    }
                    if (snapshot2.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return AlertDialog(
                      title: Text('Friend Pending Request Removal'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Text('Would you like to cancel to add friend?'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Confirm'),
                          onPressed: () {
                            snapshot.data!.docs[num].reference.update({
                              'request_uid': FieldValue.arrayRemove([user]),
                            });
                            snapshot2.data!.docs[0].reference.update({
                              'pending_uid': FieldValue.arrayRemove(
                                  [snapshot.data!.docs[num]['userid']]),
                            });
                            snapshot2.data!.docs[0].reference.update({
                              'sugg_uid': FieldValue.arrayUnion(
                                  [snapshot.data!.docs[num]['userid']]),
                            });
                            // deleteFriend(num);
                            Navigator.of(context).pop();
                            // snapshot.data!.docs[index].reference.update({
                            //   'friend_uid': FieldValue.arrayRemove([user]),
                            // })
                            // snapshot2.data!.docs[0].reference.update({
                            //   'friend_uid': FieldValue.arrayRemove(
                            //       [snapshot.data!.docs[index]['userid']]),
                            // })
                          },
                        ),
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            });
      },
    );
  }

  void removeFriend() {
    if (friendStatus == false) {
      updateStatus();
    } else if (friendStatus == true) {
      _showMyDialog();
    }
  }

  //update join status

  return PhysicalModel(
    color: Colors.transparent,
    shadowColor: Colors.green,
    elevation: 20,
    child: Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 60.0,
            child: ElevatedButton(
                onPressed: () {
                  print(userID);
                  if (userID == documentId) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyTimeline()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FriendTimeline(userid: userID)));
                  }
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(friendPic),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Text(
                                    friendName,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            _colors[_currentColorIndex]),
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                            _colors[_currentOverlayIndex]),
                                  ),
                                  onPressed: removeFriend,
                                  child: Text(
                                    _buttonText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(height: 8),
        ],
      ),
    ),
  );
}
