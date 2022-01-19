import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group9/maininterface.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class NewPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewPostState();
  }
}

//field for users
String? documentId;
String username = "";
String dpUrl = "";
//field for sharing
String userID = "";
bool image = false;
String imageUrl = "";
DateTime now = DateTime.now();

//define collection ref
CollectionReference users = FirebaseFirestore.instance.collection('users');

class NewPostState extends State<NewPost> {
  File? imageFile;
  bool _isLoading = false;
  final myController = TextEditingController();
  String? documentId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    CollectionReference sharing =
        FirebaseFirestore.instance.collection('sharing');
    //to get current user ID
    userID = documentId!;

    //store data to db
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
      return sharing
          .add({
            'userID': userID,
            'caption': myController.text,
            'imageUrl': imageUrl,
            'time': now,
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

    void _remove(BuildContext context) {
      setState(() {
        imageFile = null;
        image = false;
        imageUrl = "";
      });
    }

    return Scaffold(
        backgroundColor: Colors.lightGreen[100],
        appBar: AppBar(
            centerTitle: true,
            // leadingWidth: 75,
            // actionsIconTheme: ,
            title: Text("Create post",
                style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            elevation: 1,
            backgroundColor: Colors.lightGreen[100],
            automaticallyImplyLeading: true,
            leading: IconButton(
              onPressed: () {
                _remove(context);
                Navigator.pop(context);
              },
              icon: Icon(Icons.clear),
              color: Colors.green.shade700,
              tooltip: "Post",
            ),
            actions: <Widget>[
              // IconButton(onPressed: (){}, icon: Icon(Icons.post_add_outlined), color: Colors.green.shade700, tooltip: "Post", )
              OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      BorderSide(color: Colors.transparent)),
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.green.shade700),
                ),
                onPressed: () {
                  if (myController.text.isNotEmpty || image) {
                    addSharing();
                    _remove(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainInterface.select(0),
                        ));
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Post is Empty",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                textAlign: TextAlign.center),
                          );
                        });
                  }
                },
                child: Text("Post"),
              ),
            ]),
        body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  PhysicalModel(
                    color: Colors.transparent,
                    shadowColor: Colors.green,
                    elevation: 20,
                    child: Container(
                      width: 360,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              //dp
                              FutureBuilder<DocumentSnapshot>(
                                future: users.doc(documentId).get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("Something went wrong");
                                  }

                                  if (snapshot.hasData &&
                                      !snapshot.data!.exists) {
                                    return Text("Document does not exist");
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    Map<String, dynamic> data = snapshot.data!
                                        .data() as Map<String, dynamic>;
                                    dpUrl = data['dpUrl'];
                                    return FittedBox(
                                      fit: BoxFit.contain,
                                      child: CircleAvatar(
                                          backgroundImage: NetworkImage(dpUrl)),
                                    );
                                  }
                                  return Text("loading");
                                },
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              //username
                              FutureBuilder<DocumentSnapshot>(
                                future: users.doc(documentId).get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("Something went wrong");
                                  }

                                  if (snapshot.hasData &&
                                      !snapshot.data!.exists) {
                                    return Text("Document does not exist");
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    Map<String, dynamic> data = snapshot.data!
                                        .data() as Map<String, dynamic>;
                                    username = data['username'];
                                    return Text(
                                      username,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    );
                                  }
                                  return Text("loading");
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextField(
                            controller: myController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              border: InputBorder.none,
                              labelText: "Have something to share?",
                              labelStyle: TextStyle(fontSize: 15),

                              // isDense: true,
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  PhysicalModel(
                    color: Colors.transparent,
                    shadowColor: Colors.green,
                    elevation: 20,
                    child: Container(
                      width: 360,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          //Camera
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.camera),
                                color: Colors.purple.shade600,
                                onPressed: () {
                                  _openCamImage(context);
                                },
                              ),
                              Text(
                                "Camera",
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.photo_library),
                                color: Colors.blue.shade600,
                                onPressed: () {
                                  _openLibImage(context);
                                },
                              ),
                              Text("Photo"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  PhysicalModel(
                      color: Colors.transparent,
                      shadowColor: Colors.green,
                      elevation: 20,
                      child: (imageFile == null)
                          ? (Text(""))
                          : (Container(
                              margin: EdgeInsets.only(bottom: 20.0),
                              width: 360,
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(children: [
                                SizedBox(
                                    width: double.infinity,
                                    height: 200,
                                    child: FittedBox(
                                        fit: BoxFit.fill,
                                        child:
                                            Image.file(File(imageFile!.path)))),
                                IconButton(
                                  icon: Icon(
                                    Icons.clear_rounded,
                                  ),
                                  color: Colors.red,
                                  onPressed: () {
                                    _remove(context);
                                  },
                                )
                              ]))))
                ],
              )),
        ));
  }
}
