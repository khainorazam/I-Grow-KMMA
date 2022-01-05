import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
                        PhysicalModel(
                          color: Colors.transparent,
                          shadowColor: Colors.green,
                          elevation: 20,
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 60.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      CustomPageRoute(
                                          child: const Profile(),
                                          direction: AxisDirection.left));
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
                                      child: const CircleAvatar(
                                        backgroundImage:
                                            AssetImage("assets/baam.jpg"),
                                      ),
                                    ),
                                    Expanded(
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
                                                child: const Text(
                                                  'Idham Anur',
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
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons
                                                            .check_circle_outline,
                                                        color:
                                                            Colors.green[600],
                                                      )),
                                                  IconButton(
                                                      iconSize: 35.0,
                                                      onPressed:
                                                          deleteFriendReq,
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
                        )
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
                        FutureBuilder(
                            future: listBoxVariable,
                            builder: (BuildContext context,
                                AsyncSnapshot<List> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      child: FriendBox('${friendPic[index]}',
                                          '${snapshot.data![index]}', context),
                                    );
                                  },
                                );
                              }

                              return Text("Loading");
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: SearchFriends(),
          );
        },
        child: const Icon(Icons.search),
        backgroundColor: Colors.green[700],
        tooltip: "Search Friends",
      ),
    );
  }
}

Future<List> listBoxFunction() {
  List<String> friendName = [];
  FirebaseFirestore.instance
      .collection('testfriend')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      print(doc['friendName']);
      friendName.add(doc['friendName']);
    });
  });

  return Future.value(friendName);
}

Future<List> listBoxVariable = listBoxFunction();

Widget FriendBox(String friendPic, String friendName, BuildContext context) {
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
                  Navigator.push(
                      context,
                      CustomPageRoute(
                          child: const MyTimeline(),
                          direction: AxisDirection.left));
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
                        backgroundImage: AssetImage(friendPic),
                      ),
                    ),
                    Expanded(
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
