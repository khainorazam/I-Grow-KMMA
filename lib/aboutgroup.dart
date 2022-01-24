import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group9/widget/custom_title.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// String groupRef = "Group Kobis Maluri";

class AboutGroup extends StatefulWidget {
  final String docId2;
  const AboutGroup({Key? key, required this.docId2}) : super(key: key);
  @override
  AboutGroupState createState() => AboutGroupState(docId2: this.docId2);
}

class AboutGroupState extends State<AboutGroup> {
  String docId2;
  AboutGroupState({required this.docId2});

  @override
  Widget build(BuildContext context) {
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
        // title: Text("About Group"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CustomTitle("About Us !"),
                    const SizedBox(
                      height: 22,
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('groups')
                          .doc(docId2)
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

                        var groupMap = snapshot.data;

                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Material(
                                  elevation: 20.0,
                                  shadowColor: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(18.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.grey[200]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Description",
                                              style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            height: 3,
                                            child: Container(
                                              color: Colors.lightGreen,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 18,
                                          ),
                                          Text(
                                            groupMap!['desc'],
                                            style: TextStyle(
                                                color: Colors.grey[700]),
                                          ),
                                        ],
                                      ))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Material(
                                  elevation: 20.0,
                                  shadowColor: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(18.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.grey[200]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Related Tags",
                                              style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            height: 3,
                                            child: Container(
                                              color: Colors.lightGreen,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 18,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                // width: 90,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: Colors.purple[700],
                                                    ),
                                                    padding: EdgeInsets.all(8),
                                                    child: Center(
                                                        child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Icon(MdiIcons.tag,
                                                            color: Colors.white,
                                                            size: 20),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                            groupMap[
                                                                'groupKey'],
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white)),
                                                      ],
                                                    ))),
                                              ),
                                              const SizedBox(width: 5),
                                              Container(
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: Colors.orange[700],
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Center(
                                                        child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(MdiIcons.tag,
                                                            color: Colors.white,
                                                            size: 20),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(groupMap['locKey'],
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white)),
                                                      ],
                                                    ))),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ))),
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
