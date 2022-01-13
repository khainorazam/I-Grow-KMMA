import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendInfo extends StatefulWidget {
  final DocumentSnapshot docid;
  FriendInfo({required this.docid});

  @override
  State<FriendInfo> createState() => FriendInfoState();
}

class FriendInfoState extends State<FriendInfo> {
  String? user = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.docid.get('username')),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      // actions
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: kPrimaryColor,
      //   icon: Icon(Icons.group_add_sharp),
      //   label: Text("Add Friend"),
      //   onPressed: () {
      //     _alert(context);
      //     // Navigator.pop(context);
      //   },
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("Name"),
                subtitle: Text(widget.docid.get('name')),
              ),
              ListTile(
                title: Text("E-mail"),
                subtitle: Text(widget.docid.get('email')),
              ),
              ListTile(
                title: Text("Age"),
                subtitle: Text(widget.docid.get('age')),
              ),
              ListTile(
                title: Text("Gender"),
                subtitle: Text(widget.docid.get('gender')),
              ),
              ListTile(
                title: Text("Marital Status"),
                subtitle: Text(widget.docid.get('maritalstatus')),
              ),
              ListTile(
                title: Text("Occupation"),
                subtitle: Text(widget.docid.get('occupation')),
              ),
              ListTile(
                title: Text("About"),
                subtitle: Text(widget.docid.get('about')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// TODO Implement this library.