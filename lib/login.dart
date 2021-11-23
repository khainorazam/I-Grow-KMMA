import 'dart:convert';
import "package:flutter/material.dart";
import 'package:flutter_group9/maininterface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'network_utils/api.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  LoginPage createState() => LoginPage();
}

class LoginPage extends State<Login> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _showMsg(msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // some code to undo change
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.lightGreen.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/igrowicon.png',
          fit: BoxFit.contain,
          height: 70,
          width: 250,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 20,
          color: Colors.black,
        ),
      ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: const <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Login to your account",
                        style:
                            TextStyle(fontSize: 15, color: Colors.lightGreen),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.email,
                            color: const Color(0xFF8BC34A),
                          ),
                          title: TextFormField(
                            decoration: const InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none),
                            keyboardType: TextInputType.emailAddress,
                            validator: (emailValue) {
                              if (emailValue!.isEmpty) {
                                return 'Please enter your email!';
                              }
                              email = emailValue;
                              return null;
                            },
                          ),
                          tileColor: Colors.white,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.lock,
                            color: const Color(0xFF8BC34A),
                          ),
                          title: TextFormField(
                            decoration: const InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none),
                            obscureText: true,
                            validator: (pswdValue) {
                              if (pswdValue!.isEmpty) {
                                return 'Please enter your password!';
                              }
                              password = pswdValue;
                              return null;
                            },
                          ),
                          tileColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainInterface()));
                      },
                      color: const Color(0xFF8BC34A),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black54),
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          )),
    );
  }

  String? _myDataState;

  String? user;

  Future<void> _loads() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      String? _curState = 'Loading';

      setState(() {
        _myDataState = _curState;
      });

      _curState = await _login();
      setState(() {
        _myDataState = _curState;
      });
    }
  }

  Future _login() async {
    var data = {'email': email, 'password': password};
    var res = await Network()
        .authData(data, '/login')
        .timeout(const Duration(seconds: 5), onTimeout: () => 'Timeout');
    // var res = await Network().authData(data, '/login');
    if (res != 'Timeout') {
      var body = json.decode(res.body);
      res = 'Loaded';
      if (body['success']) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', json.encode(body['token']));
        localStorage.setString('user', json.encode(body['user']));
        user = jsonDecode(localStorage.getString('user').toString());
      }
    }
    res = 'Loaded';
    return res;
  }
}
//hi