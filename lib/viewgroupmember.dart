// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group9/viewgroup.dart';
import 'package:flutter_group9/widget/custom_title.dart';

class ViewGroupMember extends StatefulWidget {
  final String docId3;
  const ViewGroupMember({Key? key, required this.docId3}) : super(key: key);
  @override
  ViewGroupMemberState createState() =>
      ViewGroupMemberState(docId3: this.docId3);
}

class ViewGroupMemberState extends State<ViewGroupMember> {
  String docId3;
  ViewGroupMemberState({required this.docId3});

  @override
  Widget build(BuildContext context) {
    // final List<String> memberPic = ["assets/Daus.jpg", "assets/Guy1.jfif"];
    // final List<String> memberName = [
    //   "Firdaus Hishamudin",
    //   "Haikal Iman",
    // ];
    // final List<String> memberStatus = [
    //   "member",
    //   "admin",
    // ];

    return Scaffold(
        backgroundColor: Colors.lightGreen[100],
        appBar: AppBar(
          // title: Text("Group Members"),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          elevation: 0.0,
          leading: IconButton(
            color: Colors.green[700],
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CustomTitle("Our Big Family !"),

                  SizedBox(
                    height: 22,
                  ),

                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('groups')
                          .doc(docId3)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }

                        var GroupsMap = snapshot.data;

                        List<String> userArr = [];
                        userArr = List.from(GroupsMap!['userId']);

                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userArr.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(userArr[index])
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Something went wrong');
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text("Loading");
                                    }

                                    var userMap = snapshot.data;

                                    return ViewMemberBox(userMap!['dpUrl'],
                                        userMap['username'], context);
                                    // }).toList());
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      })

                  //list name start here
                  // ListView.builder(
                  //   physics: NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   itemCount: memberName.length,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return Container(
                  //       child: ViewMemberBox(
                  //           '${memberPic[index]}',
                  //           '${memberName[index]}',
                  //           '${memberStatus[index]}',
                  //           context),
                  //     );
                  //   },
                  // ),
                ],
              ),
            )),
          ],
        ));
  }
}

Widget ViewMemberBox(
    String memberImg, String memberName, BuildContext context) {
  return Container(
    child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 16, right: 16),
          // decoration: BoxDecoration(border: Border.all(color: Colors.black),),
          child: ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 8),
                CircleAvatar(
                  backgroundImage: NetworkImage(memberImg),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      memberName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ],
                )
              ],
            ),
            style: ButtonStyle(
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.grey.shade500),
                overlayColor:
                    MaterialStateProperty.all<Color>(Colors.green.shade700),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
          ),
        ),
        SizedBox(
          height: 18,
        ),
      ],
    ),
  );
}
