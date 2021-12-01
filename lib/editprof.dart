import 'package:flutter/material.dart';
import 'package:flutter_group9/data/setting.dart';
import 'package:flutter_group9/login.dart';
import 'maininterface.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfile(),
    );
  }
}

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.green[700],
        //   automaticallyImplyLeading: true,
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back_rounded),
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => MainInterface.select(1),
        //           ));
        //     },
        //   ),
        //   title: Text("Edit My Profile"),
        // ),
        backgroundColor: Colors.lightGreen.shade100,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 310),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Icon(Icons.logout_outlined,
                        size: 35, color: Colors.black87),
                  ),
                ),
                Text(
                  "My Profile",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80",
                                ))),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.green,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                buildTextField("Full Name", "Idham Anur", false),
                buildTextField("E-mail", "idhamanur@gmail.com", false),
                buildTextField("Password", "********", true),
                buildTextField("Location", "Tawau, Sabah", false),
                buildTextField("About", "Yang single-single saja bah", false),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {},
                      //color: Colors.white,
                      child: Text("CANCEL",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.black)),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      color: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Expanded(
      // padding: const EdgeInsets.only(bottom: 35.0),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        //padding: const EdgeInsets.only(bottom: 35.0),
        child: SingleChildScrollView(
          child: TextField(
            obscureText: isPasswordTextField ? showPassword : false,
            decoration: InputDecoration(
                suffixIcon: isPasswordTextField
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.grey,
                        ),
                      )
                    : null,
                contentPadding: EdgeInsets.only(bottom: 3),
                labelText: labelText,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: placeholder,
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                )),
          ),
        ),
      ),
    );
  }
}
