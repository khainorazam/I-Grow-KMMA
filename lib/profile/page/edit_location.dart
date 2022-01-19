import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../../maininterface.dart';
import 'package:flutter_group9/profile/widget/appbar_widget.dart';

// This class handles the Page to edit the About Me Section of the User Profile.
class EditLocationFormPage extends StatefulWidget {
  @override
  _EditLocationFormPageState createState() => _EditLocationFormPageState();
}

String? documentId;

class _EditLocationFormPageState extends State<EditLocationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final locationController = TextEditingController();

  String userID = "";
  String _location = "";

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  void updateUserValue(String location) {
    _location = location;
  }

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
      _location = value.data()!["location"];
    });
    return Scaffold(
        appBar: buildAppBar(context),
        body: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                    width: 350,
                    child: const Text(
                      "Where do you live?",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                        height: 100,
                        width: 350,
                        child: TextFormField(
                          // Handles Form Validation
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length > 200) {
                              return 'Please describe yourself but keep it under 200 characters.';
                            }
                            return null;
                          },
                          controller: locationController,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                              alignLabelWithHint: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 15, 10, 50),
                              hintMaxLines: 3,
                              hintText: 'Please state your new location.'),
                        ))),
                Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 350,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                updateUserValue(locationController.text);
                                //Navigator.pop(context);
                                var firebaseUser =
                                    FirebaseAuth.instance.currentUser;
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(userID)
                                    .update({'location': _location})
                                    .then((_) => print(_location))
                                    .catchError(
                                        (error) => print('Failed: $error'));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MainInterface.select(4),
                                    ));
                              }
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        )))
              ]),
        ));
  }
}

void getCurrentUser() async {
  final User? user = FirebaseAuth.instance.currentUser;
  final uid = user!.uid;
  documentId = uid;
}
