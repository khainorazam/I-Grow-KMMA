import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group9/group.dart';
import 'package:flutter_group9/maininterface.dart';
import 'package:flutter_group9/newpost.dart';
import 'package:flutter_group9/profile/widget/appbar_widget.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart';
//import 'package:flutter_user_profile/widgets/appbar_widget.dart';
import 'package:image_picker/image_picker.dart';

class EditImagePage extends StatefulWidget {
  final String docID;
  const EditImagePage({Key? key, required this.docID}) : super(key: key);

  @override
  _EditImagePageState createState() => _EditImagePageState(docID: this.docID);
}

bool image = false;
String imageUrl = "";
String dpUrl = "";
//DateTime now = DateTime.now();
CollectionReference users = FirebaseFirestore.instance.collection('users');

class _EditImagePageState extends State<EditImagePage> {
  String docID;
  _EditImagePageState({required this.docID});
  File? imageFile;
  bool _isloading = false;
  //String dpUrl;
//  final myController = TextEditingController();

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();
  //final myController = TextEditingController();
  String? documentId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    Stream prof() async* {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(documentId)
          .get()
          .then((value) {
        dpUrl = value.data()!["dpUrl"];
        // about = value.data()!["about"];
      });
    }

    Future<void> updateImage() async {
      try {
        if (imageFile != null) {
          final ref = FirebaseStorage.instance.ref().child(imageFile!.path);
          await ref.putFile(imageFile!);
          imageUrl = await ref.getDownloadURL();
        }
      } catch (error) {
        Text("Error");
        print('error occured ${error}');
      }
      return users
          .doc(docID)
          .update({'dpUrl': imageUrl})
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
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

    void _remove(BuildContext context) {
      setState(() {
        imageFile = null;
        image = false;
        imageUrl = "";
      });
    }

    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
              width: 330,
              child: Text(
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
                    // child: const Text('Choose a picture',
                    //     style: TextStyle(fontSize: 15)),

                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Choose a picture',
                        style: TextStyle(fontSize: 15, color: Colors.blue),
                      ),
                    ),
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
                        updateImage();
                        _remove(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainInterface.select(4),
                            ));
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
