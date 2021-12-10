import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//image picker
class CameraWidget extends StatefulWidget {
  @override
  State createState() {
    // TODO: implement createState
    return CameraWidgetState();
  }
}

class CameraWidgetState extends State {
  File? imageFile;
  String? url;
  bool _isLoading = false;
  //CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _submitForm(BuildContext context) async {
    try {
      if (imageFile == null) {
        Text("Please pick an image");
      } else {
        setState(() {
          _isLoading = true;
        });
        final ref = FirebaseStorage.instance.ref().child(imageFile!.path);
        await ref.putFile(imageFile!);
        url = await ref.getDownloadURL();
        final User? user = FirebaseAuth.instance.currentUser;
        final _uid = user!.uid;
        //user.updateProfile(photoURL: url, displayName: _fullName);
        user.reload();
        await FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id': _uid,
          'imageUrl': url,
          'createdAt': Timestamp.now(),
        });
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      }
    } catch (error) {
      Text("Error");
      print('error occured ${error}');
      // } finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      // }
    }
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    final pickedImageFile = File(pickedFile!.path);
    setState(() {
      imageFile = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedFile!.path);
    setState(() {
      imageFile = pickedImageFile;
    });
    Navigator.pop(context);
  }
//   void _pickVideo() async {
//     final pickedFile = await ImagePicker().getVideo(source: ImageSource.camera);
//     final pickedImageFile = File(pickedFile!.path);
//     _videoPlayerController = VideoPlayerController.file(pickedImageFile)..initialize().then((_) {
//       setState(() { });
//       _videoPlayerController.play();
//     });
// }

  void _remove(BuildContext context) {
    setState(() {
      imageFile = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Image Camera"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                textColor: Colors.white,
                color: Colors.pink,
                onPressed: () {
                  _showChoiceDialog(context);
                },
                child: Text("Choose Image"),
              ),
              MaterialButton(
                textColor: Colors.white,
                color: Colors.pink,
                onPressed: () {
                  _submitForm(context);
                },
                child: Text("Select Image"),
              ),
              MaterialButton(
                textColor: Colors.white,
                color: Colors.pink,
                onPressed: () {
                  _remove(context);
                },
                child: Text("Remove Image"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
