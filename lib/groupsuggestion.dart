import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_group9/widget/custom_title.dart';

Map<String, dynamic>? userMap;
Map<String, dynamic>? groupMap;
String? userId;
String plantKey = "Onion";
String locKey = "Kelantan";

class GroupSuggestion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GroupSuggestionState();
  }
}

class GroupSuggestionState extends State<GroupSuggestion> {
 

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.green[700],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CustomTitle("Only For You !"),
                const SizedBox(
                  height: 22,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('userid', isEqualTo: userId)
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
                            userMap = document.data() as Map<String, dynamic>;

                            return Row(children: <Widget>[
                              Container(
                                width: 90,
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.purple[700],
                                    ),
                                    padding: EdgeInsets.all(8),
                                    child: Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(MdiIcons.tag,
                                            color: Colors.white, size: 20),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(userMap!['plantKey'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ],
                                    ))),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.orange[700],
                                    ),
                                    padding: EdgeInsets.all(8),
                                    child: Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(MdiIcons.tag,
                                            color: Colors.white, size: 20),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(userMap!['locKey'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ],
                                    ))),
                              ),
                            ]);
                          }).toList(),
                        );
                      }),
                ),
                const SizedBox(
                  height: 22,
                ),

                SuggestedGroupBox(),

                // ListView.builder(
                //   physics: NeverScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   itemCount: groupName.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     return Container(
                //       child: SuggestedGroupBox(
                //           '${groupPic[index]}',
                //           '${groupName[index]}',
                //           '${groupMemberCount[index]}',
                //           context),
                //     );
                //   },
                // )
              ],
            ),
          )),
        ],
      ),
    );
  }
}

Widget SuggestedGroupBox() {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('groups')
          .where('groupKey', isEqualTo: plantKey)
          .where('locKey', isEqualTo: locKey)
          .where('userId',isEqualTo: "")
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
            groupMap = document.data() as Map<String, dynamic>;

            return Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 8),
                        CircleAvatar(
                          backgroundImage: NetworkImage(groupMap!['dpUrl']),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              groupMap!['groupName'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            Text("${groupMap!['membersCount']} members"),
                          ],
                        )
                      ],
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.grey.shade500),
                      overlayColor: MaterialStateProperty.all<Color>(
                          Colors.green.shade700),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                ),
              ),
            );
          }).toList(),
        );
      });
}

void getCurrentUser() async {
  final User? user = FirebaseAuth.instance.currentUser;
  final uid = user!.uid;
  userId = uid;
}
