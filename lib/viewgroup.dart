import 'package:flutter/material.dart';
import 'package:flutter_group9/group.dart';
import 'package:flutter_group9/maininterface.dart';

void main() {
  runApp(ViewGroup());
}

class ViewGroup extends StatefulWidget {
  const ViewGroup({Key? key}) : super(key: key); //MyApp utk widget
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ViewGroupState();
  }
}

class ViewGroupState extends State<ViewGroup> {
  var joinStatus = false;
  var buttonText = "Join";

  void updateStatus() {
    if (joinStatus == false) {
      setState(() {
        joinStatus = true;
      });
      buttonText = "Joined";
      print("status : $joinStatus");
    } else if (joinStatus == true) {
      setState(() {
        joinStatus = false;
      });
      buttonText = "Join";
      print("status : $joinStatus");
    }

    // setState((){
    //   joinStatus = true;
    // });
    // print("status : $joinStatus");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[700],
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainInterface.select(1),
                  ));
            },
          ),
          title: Text("Group Page"),
        ),
        body: Container(
            color: Colors.lightGreen[100],
            child: Center(
              child: SizedBox(
                width: 100.0,
                child: ElevatedButton(
                  onPressed: updateStatus,
                  child: Text(
                    buttonText,
                    style: TextStyle(color: Colors.white70),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.grey.shade500),
                      overlayColor: MaterialStateProperty.all<Color>(
                          Colors.green.shade700),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                ),
              ),
            )),
      ),
    );
  }
}
