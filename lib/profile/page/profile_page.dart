// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_group9/profile/page/edit_description.dart';
// import 'package:flutter_group9/profile/page/edit_email.dart';
// import 'package:flutter_group9/profile/page/edit_image.dart';
// import 'package:flutter_group9/profile/page/edit_name.dart';
// import 'package:flutter_group9/profile/page/edit_phone.dart';
// import '../user/user.dart';
// import 'package:flutter_group9/profile/widgets/display_image.dart';
// import '../user/user_data.dart';

// // This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// String? documentId;

// class _ProfilePageState extends State<ProfilePage> {
//   String userID = "";
//   String name = "";
//   String email = "";
//   String phone = "";
//   String location = "";
//   String about = "";
//   String status = "";
//   String dpUrl = "";

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference sharing =
//         FirebaseFirestore.instance.collection('users');
//     //to get current user ID
//     getCurrentUser();
//     userID = documentId!;

//     var firebaseUser = FirebaseAuth.instance.currentUser;
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(userID)
//         .get()
//         .then((value) {
//       email = value.data()!["email"];
//       name = value.data()!["username"];
//       phone = value.data()!["phone"];
//       location = value.data()!["location"];
//       status = value.data()!["status"];
//       about = value.data()!["about"];
//       dpUrl = value.data()!["about"];
//     });

//     return Scaffold(
//       body: Column(
//         children: [
//           AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             toolbarHeight: 10,
//           ),
//           Center(
//               child: Padding(
//                   padding: EdgeInsets.only(bottom: 20),
//                   child: Text(
//                     'Edit Profile',
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.w700,
//                       color: Color.fromRGBO(64, 105, 225, 1),
//                     ),
//                   ))),
//           InkWell(
//               onTap: () {
//                 navigateSecondPage(EditImagePage());
//               },
//               child: DisplayImage(
//                 imagePath: user.image,
//                 onPressed: () {},
//               )),
//           buildUserInfoDisplay(name, 'Name', EditNameFormPage()),
//           buildUserInfoDisplay(phone, 'Phone', EditPhoneFormPage()),
//           buildUserInfoDisplay(email, 'Email', EditEmailFormPage()),
//           Expanded(
//             child: buildAbout(user),
//             flex: 4,
//           )
//         ],
//       ),
//     );
//   }

//   // Widget builds the display item with the proper formatting to display the user's info
//   Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
//       Padding(
//           padding: EdgeInsets.only(bottom: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.grey,
//                 ),
//               ),
//               SizedBox(
//                 height: 1,
//               ),
//               Container(
//                   width: 350,
//                   height: 40,
//                   decoration: BoxDecoration(
//                       border: Border(
//                           bottom: BorderSide(
//                     color: Colors.grey,
//                     width: 1,
//                   ))),
//                   child: Row(children: [
//                     Expanded(
//                         child: TextButton(
//                             onPressed: () {
//                               navigateSecondPage(editPage);
//                             },
//                             child: Text(
//                               getValue,
//                               style: TextStyle(fontSize: 16, height: 1.4),
//                             ))),
//                     Icon(
//                       Icons.keyboard_arrow_right,
//                       color: Colors.grey,
//                       size: 40.0,
//                     )
//                   ]))
//             ],
//           ));

//   // Widget builds the About Me Section
//   Widget buildAbout(User user) => Padding(
//       padding: EdgeInsets.only(bottom: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Tell Us About Yourself',
//             style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey,
//             ),
//           ),
//           const SizedBox(height: 1),
//           Container(
//               width: 350,
//               height: 200,
//               decoration: BoxDecoration(
//                   border: Border(
//                       bottom: BorderSide(
//                 color: Colors.grey,
//                 width: 1,
//               ))),
//               child: Row(children: [
//                 Expanded(
//                     child: TextButton(
//                         onPressed: () {
//                           navigateSecondPage(EditDescriptionFormPage());
//                         },
//                         child: Padding(
//                             padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
//                             child: Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   user.aboutMeDescription,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     height: 1.4,
//                                   ),
//                                 ))))),
//                 Icon(
//                   Icons.keyboard_arrow_right,
//                   color: Colors.grey,
//                   size: 40.0,
//                 )
//               ]))
//         ],
//       ));

//   // Refrshes the Page after updating user info.
//   FutureOr onGoBack(dynamic value) {
//     setState(() {});
//   }

//   // Handles navigation and prompts refresh.
//   void navigateSecondPage(Widget editForm) {
//     Route route = MaterialPageRoute(builder: (context) => editForm);
//     Navigator.push(context, route).then(onGoBack);
//   }
// }

// void getCurrentUser() async {
//   final User? user = FirebaseAuth.instance.currentUser;
//   final uid = user!.uid;
//   documentId = uid;
// }
