import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group9/login.dart';
import 'package:flutter_group9/mytimeline.dart';
import 'package:flutter_group9/searchfriends.dart';

class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FriendsState();
  }
}

//define collection ref
CollectionReference friends = FirebaseFirestore.instance.collection('friends');

class FriendsState extends State<Friends> {
  @override
  Widget build(BuildContext context) {
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
                                onPressed: () {},
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
                                                      onPressed: () {},
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
                        PhysicalModel(
                          color: Colors.transparent,
                          shadowColor: Colors.green,
                          elevation: 20,
                          child: Container(
                            //friend 1
                            margin: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 60.0,
                              child: ElevatedButton(
                                onPressed: () {},
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
                                            AssetImage("assets/azam.jpg"),
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
                                                  'Khainor Azam',
                                                  style: TextStyle(
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
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.red),
                                                ),
                                                onPressed: () {},
                                                child: const Text(
                                                  'Remove Friend',
                                                ),
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
                        ),
                        PhysicalModel(
                          color: Colors.transparent,
                          shadowColor: Colors.green,
                          elevation: 20,
                          child: Container(
                            //friend 2
                            margin: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 60.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyTimeline()));
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
                                        backgroundImage: AssetImage(
                                            "assets/menprofilepic.png"),
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
                                                  'Ahmad Mujahid',
                                                  style: TextStyle(
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
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.red),
                                                ),
                                                onPressed: () {},
                                                child: const Text(
                                                  'Remove Friend',
                                                ),
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
                        ),
                        PhysicalModel(
                          color: Colors.transparent,
                          shadowColor: Colors.green,
                          elevation: 20,
                          child: Container(
                            //friend 3
                            margin: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 60.0,
                              child: ElevatedButton(
                                onPressed: () {},
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
                                        backgroundImage: AssetImage(
                                            "assets/womenprofilepic.jpg"),
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
                                                  'Nur Ain',
                                                  style: TextStyle(
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
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.red),
                                                ),
                                                onPressed: () {},
                                                child: const Text(
                                                  'Remove Friend',
                                                ),
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
                        ),
                        PhysicalModel(
                          color: Colors.transparent,
                          shadowColor: Colors.green,
                          elevation: 20,
                          child: Container(
                            //friend 4
                            margin: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 60.0,
                              child: ElevatedButton(
                                onPressed: () {},
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
                                        backgroundImage: AssetImage(
                                            "assets/womenprofilepic.jpg"),
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
                                                  'Yasmeen',
                                                  style: TextStyle(
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
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.red),
                                                ),
                                                onPressed: () {},
                                                child: const Text(
                                                  'Remove Friend',
                                                ),
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
                        ),
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SearchFriends()));
        },
        child: const Icon(Icons.search),
        backgroundColor: Colors.green[700],
        tooltip: "Search Friends",
      ),
    );
  }
}
