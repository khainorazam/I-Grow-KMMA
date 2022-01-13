// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_group9/profile/user/user_data.dart';
// import 'package:flutter_group9/profile/widget/appbar_widget.dart';
// import 'package:path_provider/path_provider.dart';

// import 'package:path/path.dart';
// //import 'package:flutter_user_profile/widgets/appbar_widget.dart';
// import 'package:image_picker/image_picker.dart';

// class EditImagePage extends StatefulWidget {
//   const EditImagePage({Key? key}) : super(key: key);

//   @override
//   _EditImagePageState createState() => _EditImagePageState();
// }

// String? documentId;

// class _EditImagePageState extends State<EditImagePage> {
// //  var user = UserData.myUser;

//   String userID = "";
//   String _dpUrl = "";
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//   late File _imageFile;

//   ///NOTE: Only supported on Android & iOS
//   ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
//   final picker = ImagePicker();

//   Future pickImage() async {
//     final pickedFile = await picker.getImage(source: ImageSource.camera);

//     setState(() {
//       _imageFile = File(pickedFile!.path);
//     });
//   }

//   Future uploadImageToFirebase(BuildContext context) async {
//     String fileName = basename(_imageFile.path);
//     StorageReference firebaseStorageRef =
//         FirebaseStorage.instance.ref().child('uploads/$fileName');
//     StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
//     StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//     taskSnapshot.ref.getDownloadURL().then(
//           (value) => print("Done: $value"),
//         );
//   }
//   @override
//   Widget build(BuildContext context) {
//     getCurrentUser();
//     userID = documentId!;

//     var firebaseUser = FirebaseAuth.instance.currentUser;
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(userID)
//         .get()
//         .then((value) {
//       _dpUrl = value.data()!["dpUrl"];
//     });
//     return Scaffold(
//       appBar: buildAppBar(context),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           SizedBox(
//               width: 330,
//               child: const Text(
//                 "Upload a photo of yourself:",
//                 style: TextStyle(
//                   fontSize: 23,
//                   fontWeight: FontWeight.bold,
//                 ),
//               )),
//           Padding(
//               padding: EdgeInsets.only(top: 20),
//               child: SizedBox(
//                   width: 330,
//                   child: GestureDetector(
//                     onTap: () async {
//                       final image = await ImagePicker()
//                           .pickImage(source: ImageSource.gallery);

//                       if (image == null) return;

//                       final location = await getApplicationDocumentsDirectory();
//                       final name = basename(image.path);
//                       final imageFile = File('${location.path}/$name');
//                       final newImage =
//                           await File(image.path).copy(imageFile.path);
//                       setState(
//                           () => users = _dpUrl as CollectionReference<Object?>);
                          
//                     },
//                     child: Image.network(_dpUrl),
//                   ))),
//           Padding(
//               padding: EdgeInsets.only(top: 40),
//               child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: SizedBox(
//                     width: 330,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: const Text(
//                         'Update',
//                         style: TextStyle(fontSize: 15),
//                       ),
//                     ),
//                   )))
//         ],
//       ),
//     );
//   }
// }

// void getCurrentUser() async {
//   final User? user = FirebaseAuth.instance.currentUser;
//   final uid = user!.uid;
//   documentId = uid;
// }
