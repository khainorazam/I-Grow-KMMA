import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:flutter_group9/profile/user/user_data.dart';
import 'package:flutter_group9/profile/page/profile_page.dart';

import '../../maininterface.dart';
//import 'package:flutter_user_profile/widgets/appbar_widget.dart';

// This class handles the Page to edit the Phone Section of the User Profile.
class EditPhoneFormPage extends StatefulWidget {
  const EditPhoneFormPage({Key? key}) : super(key: key);
  @override
  EditPhoneFormPageState createState() {
    return EditPhoneFormPageState();
  }
}

String? documentId;

class EditPhoneFormPageState extends State<EditPhoneFormPage> {
  String userID = "";
  String _phone = "";

  CollectionReference sharing = FirebaseFirestore.instance.collection('users');
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  //var user = UserData.myUser;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void updateUserValue(String phone) {
    String formattedPhoneNumber = "(" +
        phone.substring(0, 3) +
        ") " +
        phone.substring(3, 6) +
        "-" +
        phone.substring(6, phone.length);
    _phone = formattedPhoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference sharing =
        FirebaseFirestore.instance.collection('users');
    final _formKey = GlobalKey<FormState>();
    final phoneController = TextEditingController();
    //var user = UserData.myUser;

    getCurrentUser();
    userID = documentId!;

    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .get()
        .then((value) {
      _phone = value.data()!["phone"];
    });
    return Scaffold(
        //appBar: buildAppBar(context),
        body: Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
                width: 320,
                child: const Text(
                  "What's Your Phone Number?",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: EdgeInsets.only(top: 40),
                child: SizedBox(
                    height: 100,
                    width: 320,
                    child: TextFormField(
                      // Handles Form Validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (isAlpha(value)) {
                          return 'Only Numbers Please';
                        } else if (value.length < 10) {
                          return 'Please enter a VALID phone number';
                        }
                        return null;
                      },
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Your Phone Number',
                      ),
                    ))),
            Padding(
                padding: EdgeInsets.only(top: 150),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 320,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate() &&
                              isNumeric(phoneController.text)) {
                            updateUserValue(phoneController.text);
                            var firebaseUser =
                                FirebaseAuth.instance.currentUser;
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(userID)
                                .update({'phone': '`' + _phone})
                                .then((_) => print(_phone))
                                .catchError((error) => print('Failed: $error'));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainInterface.select(4),
                                ));
                          }
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(fontSize: 15),
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
