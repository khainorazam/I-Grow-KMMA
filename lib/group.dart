import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group9/groupsuggestion.dart';
import 'package:flutter_group9/viewgroup.dart';
import 'package:flutter_group9/widget/custom_page_route.dart';
import 'package:flutter_group9/widget/searchservice.dart';

// CollectionReference users = FirebaseFirestore.instance.collection('users');
String? documentId;
Map<String, dynamic>? data;

class Groups extends StatefulWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GroupsState();
  }
}

class GroupsState extends State<Groups> with SingleTickerProviderStateMixin {
  //Start of expanded FAB
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _buttonColor;
  late Animation<double> _animationIcon;
  late Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animationIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(begin: Colors.green[700], end: Colors.red[700])
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.00, 1.00, curve: Curves.linear)));
    _translateButton = Tween<double>(begin: _fabHeight, end: -14.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.75, curve: _curve)));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //Widgets
  Widget buttonExplore() {
    return Container(
        child: FloatingActionButton(
      heroTag: "btn1",
      backgroundColor: Colors.yellow[700],
      onPressed: () {
        Navigator.push(
            context,
            CustomPageRoute(
                child: GroupSuggestion(), direction: AxisDirection.left));
      },
      tooltip: "View group suggestion",
      child: Icon(Icons.explore),
    ));
  }

  Widget buttonSearch() {
    return Container(
        child: FloatingActionButton(
      heroTag: "btn2",
      backgroundColor: Colors.yellow[700],
      onPressed: () {
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(),
        );
      },
      tooltip: "Search groups",
      child: Icon(Icons.search_outlined),
    ));
  }

  Widget buttonToggle() {
    return Container(
        child: FloatingActionButton(
      heroTag: "btn3",
      backgroundColor: _buttonColor.value,
      onPressed: animate,
      tooltip: "Toggle",
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animationIcon,
      ),
    ));
  }

  animate() {
    if (!isOpened)
      _animationController.forward();
    else
      _animationController.reverse();
    isOpened = !isOpened;
  }
  //End of expanded FAB

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
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
                      "My Groups",
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
                  children: [
                    BoxTemplate(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
                0.0, _translateButton.value * 2.0, 0.0),
            child: buttonExplore(),
          ),
          Transform(
            transform:
                Matrix4.translationValues(0.0, _translateButton.value, 0.0),
            child: buttonSearch(),
          ),
          buttonToggle()
        ],
      ),
    );
  }
}

//snapshot method
// retrieve group name
// Future<List> listName() async {
//   List<String> groupName = [];
//   await FirebaseFirestore.instance
//       .collection('groups')
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     querySnapshot.docs.forEach((doc) {
//       print(doc['groupName']);
//       groupName.add(doc['groupName']);
//     });
//   });

//   return Future.value(groupName);
// }

// Future<List> listNameVar = listName();

// //retrieve group pic
// Future<List> listImg() async {
//   List<String> groupImg = [];
//   await FirebaseFirestore.instance
//       .collection('groups')
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     querySnapshot.docs.forEach((doc) {
//       print("dontol");
//       groupImg.add(doc['dpUrl']);
//     });
//   });

//   return Future.value(groupImg);
// }

// Future<List> listImgVar = listImg();

// //retrieve group noti
// Future<List> listNoti() async {
//   List<String> groupNoti = [];
//   await FirebaseFirestore.instance
//       .collection('groups')
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     querySnapshot.docs.forEach((doc) {
//       groupNoti.add(doc['notiCount'].toString());
//     });
//   });

//   return Future.value(groupNoti);
// }

// Future<List> listNotiVar = listNoti();

Widget BoxTemplate() {
  return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('groups').where(
                  'userId',
                  arrayContainsAny: [documentId]).snapshots(),
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
            data = document.data() as Map<String, dynamic>;

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
                                  child: ViewGroup(docId: document.id),
                                  direction: AxisDirection.left));
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.grey.shade500),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.green.shade700),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(data!['dpUrl']),
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
                                          data!['groupName'],
                                          style: const TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                          child: Text(
                                        '${data!['notiCount'].toString()} new notifications',
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            );
          }).toList(),
        );
      });
}
void getCurrentUser() async {
  final User? user = FirebaseAuth.instance.currentUser;
  final uid = user!.uid;
  documentId = uid;
}