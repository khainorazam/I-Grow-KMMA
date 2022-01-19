import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group9/profile/widget/appbar_widget.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart';
//import 'package:flutter_user_profile/widgets/appbar_widget.dart';
import 'package:image_picker/image_picker.dart';

class EditImagePage extends StatefulWidget {
  const EditImagePage({Key? key}) : super(key: key);

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

String? documentId;
String _dpUrl = "";
String userID = "";
String imageUrl = "";
bool image = false;

class _EditImagePageState extends State<EditImagePage> {
//  var user = UserData.myUser;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  File? imageFile;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();
  bool _isLoading = false;
  //final myController = TextEditingController();
  String? documentId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    userID = documentId!;

    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .get()
        .then((value) {
      _dpUrl = value.data()!["dpUrl"];
    });

    Future<void> addSharing() async {
      try {
        if (imageFile != null) {
          setState(() {
            _isLoading = true;
          });
          final ref = FirebaseStorage.instance.ref().child(imageFile!.path);
          await ref.putFile(imageFile!);
          imageUrl = await ref.getDownloadURL();
        }
      } catch (error) {
        Text("Error");
        print('error occured ${error}');
      }
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'imageUrl': imageUrl,
          })
          .then((value) => print("Sharing Added"))
          .catchError((error) => print("Failed to add sharing: $error"));
    }

    void _openCamImage(BuildContext context) async {
      final pickedFile =
          await ImagePicker().getImage(source: ImageSource.camera);
      final pickedImageFile = File(pickedFile!.path);
      setState(() {
        imageFile = pickedImageFile;
        image = true;
      });
      //Navigator.pop(context);
    }

    void _openLibImage(BuildContext context) async {
      final pickedFile =
          await ImagePicker().getImage(source: ImageSource.gallery);
      final pickedImageFile = File(pickedFile!.path);
      setState(() {
        imageFile = pickedImageFile;
        image = true;
      });
    }

    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              width: 330,
              child: const Text(
                "Upload a photo of yourself:",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                  width: 330,
                  child: GestureDetector(
                    onTap: () async {
                      _openLibImage(context);

                      // if (image == null) return;

                      // final location = await getApplicationDocumentsDirectory();
                      // final name = basename(image.path);
                      // final imageFile = File('${location.path}/$name');
                      // final newImage =
                      //     await File(image.path).copy(imageFile.path);
                      // setState(
                      //     () => users = _dpUrl as CollectionReference<Object?>);
                    },
                    child: Image.network(_dpUrl),
                  ))),
          Padding(
              padding: EdgeInsets.only(top: 40),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 330,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditImagePage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}

void getCurrentUser() async {
  final User? user = FirebaseAuth.instance.currentUser;
  final uid = user!.uid;
  documentId = uid;
}
