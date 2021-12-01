import 'package:flutter/material.dart';
import 'package:flutter_group9/login.dart';
import 'package:flutter_group9/editprof.dart';
import 'maininterface.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  // final _formKey = GlobalKey<FormState>();
  // String? name;
  // String? email;
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.lightGreen.shade100,
              width: double.infinity,
              child: const Center(
                child: Text(
                  "My Profile",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              //padding: (EdgeInsets.only(top: 50, left: 35, right: 35))
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(100, 0, 50, 100),
                      child: ListTile(
                        leading: Icon(
                          Icons.account_circle,
                          size: 150,
                          color: Color.fromARGB(169, 169, 169, 169),
                        ),
                      ),
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12)),
                      title: Text(
                        'Name: ',
                        style: TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic),
                      ),
                      tileColor: Colors.white,
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12)),
                      title: Text(
                        'Email: ',
                        style: TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic),
                      ),
                      tileColor: Colors.white,
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12)),
                      title: Text(
                        'Username: ',
                        style: TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic),
                      ),
                      tileColor: Colors.white,
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12)),
                      title: Text(
                        'Date of birth: ',
                        style: TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic),
                      ),
                      tileColor: Colors.white,
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12)),
                      title: Text(
                        'Age: ',
                        style: TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic),
                      ),
                      tileColor: Colors.white,
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12)),
                      title: Text(
                        'Location: ',
                        style: TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic),
                      ),
                      tileColor: Colors.white,
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12)),
                      title: Text(
                        'Occupation: ',
                        style: TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic),
                      ),
                      tileColor: Colors.white,
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12)),
                      title: Text(
                        'About: ',
                        style: TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic),
                      ),
                      tileColor: Colors.white,
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12)),
                      title: Text(
                        'Gender: ',
                        style: TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic),
                      ),
                      tileColor: Colors.white,
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12)),
                      title: Text(
                        'Status: ',
                        style: TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic),
                      ),
                      tileColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.lightGreen.shade100,
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                    },
                    color: const Color(0xFF8BC34A),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black54),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text(
                      "Edit Profile",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
