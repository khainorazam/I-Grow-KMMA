import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_group9/profile/widget/appbar_widget.dart';
import 'package:flutter_group9/profile/widget/profile_widget.dart';

class ProfilePage2 extends StatefulWidget {
  const ProfilePage2({Key? key}) : super(key: key);

  @override
  _ProfilePageState2 createState() => _ProfilePageState2();
}

CollectionReference users = FirebaseFirestore.instance.collection('users');
String? documentId;

class _ProfilePageState2 extends State<ProfilePage2> {
  String userID = "";
  String name = "";
  String email = "";
  String phone = "";
  String location = "";
  String about = "";
  String status = "";
  String dpUrl = "";

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    //to get current user ID
    String? documentId = FirebaseAuth.instance.currentUser?.uid;
    userID = documentId!;

    var user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .get()
        .then((value) {
      email = value.data()!["email"];
      name = value.data()!["username"];
      location = value.data()!["location"];
      phone = value.data()!["phone"];
      status = value.data()!["status"];
      dpUrl = value.data()!["dpUrl"];
      about = value.data()!["about"];
    });

    return Scaffold(
      backgroundColor: Colors.lightGreen.shade100,
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: dpUrl,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 24),
          buildNumber(),
          // const SizedBox(height: 24),
          // buildLocation(),
          const SizedBox(height: 24),
          buildStatus(),

          // const SizedBox(height: 24),
          // Center(child: buildUpgradeButton())
          const SizedBox(height: 48),
          buildAbout(),
        ],
      ),
    );
  }

  Widget buildName() => Column(
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
          )
        ],
      );

  Widget buildAbout() => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              about,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  height: 1.4,
                  color: Colors.black),
            ),
          ],
        ),
      );

  // Widget buildLocation() => Container(
  //       padding: EdgeInsets.symmetric(horizontal: 48),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Location',
  //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(height: 16),
  //           Text(
  //             location,
  //             style: TextStyle(fontSize: 16, height: 1.4),
  //           ),
  //         ],
  //       ),
  //     );

  Widget buildStatus() => Container(
        padding: EdgeInsets.symmetric(horizontal: 48, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              status,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  height: 1.4,
                  color: Colors.black),
            ),
          ],
        ),
      );

  Widget buildNumber() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, Icons.location_pin, location),
        ],
      );
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, IconData icon, String value) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5),
            Icon(
              Icons.location_pin,
              color: Colors.black,
              size: 30.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            Text(
              value,
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
            ),
          ],
        ),
      );
}
