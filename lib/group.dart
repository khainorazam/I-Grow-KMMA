import 'package:flutter/material.dart';
import 'package:flutter_group9/searchgroup.dart';
import 'package:flutter_group9/viewgroup.dart';
import 'package:flutter_group9/widget/custom_page_route.dart';

class Groups extends StatelessWidget {
  const Groups({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
                                                              //array start here
    final List<String> groupPic = [
      "assets/onion.jpg",
      "assets/carrot.jpg",
      "assets/cabbage.jpg",
      "assets/chili.jpg",
      "assets/spinach.jpg",
      "assets/mushroom.jfif",
      "assets/pumpkin.jfif",
      "assets/brinjal.png",
    ];
    final List<String> groupName = [
      "Group Bawang",
      "Group Lobak Merah",
      "Group Kobis",
      "Group Cili",
      "Group Bayam",
      "Group Cendawan",
      "Group Labu",
      "Group Terung",
    ];
    final List<String> groupNoti = [
      "1 New Post",
      "2 New Post",
      "4 New Post",
      "No New Post",
      "3 New Post",
      "3 New Post",
      "5 New Post",
      "6 New Post",
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.lightGreen[100]),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(45),
                    child: const Text(
                      "Groups",
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

                    ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: groupName.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: GroupBox(
                            '${groupPic[index]}',
                            '${groupName[index]}',
                            '${groupNoti[index]}',
                            context
                            ),
                      );
                    },
                  ),
                                                                                          //group 1
                    // GroupBox("assets/onion.jpg", "Group Bawang", "1 New Post"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CustomPageRoute(
              child: SearchGroup(),
              direction: AxisDirection.left,
            ),
          );
        },
        child: const Icon(Icons.explore),
        backgroundColor: Colors.green[700],
        tooltip: "Explore Other Groups",
      ),
    );
  }
}

Widget GroupBox (String groupPic, String groupName, String groupNoti, BuildContext context){

  return Container(
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
                                          child: const ViewGroup(),
                                          direction: AxisDirection.left));
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.grey.shade500),
                                    overlayColor: MaterialStateProperty.all<Color>(
                                        Colors.green.shade700),
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
                                        backgroundImage:
                                            AssetImage(groupPic),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                child: Text(
                                                  groupName,
                                                  style: const TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                  child:  Text(
                                                groupNoti,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(height:8),
                        ],
                      ),
                    );
}


