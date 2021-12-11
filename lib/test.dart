import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddSharing extends StatelessWidget {
  String caption = "Sorry";
  var user = FirebaseAuth.instance.currentUser;

  //AddSharing(this.caption, this.user);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users =
        FirebaseFirestore.instance.collection('sharing');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'caption': caption, // "Sorry"
            'userID': user!.uid, // Current User ID
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              color: Colors.lightGreen.shade100,
              child: ElevatedButton(
                onPressed: addUser,
                child: Text(
                  "Add User",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
