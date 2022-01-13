import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  //final DateTime _now = DateTime.now();
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('messages')
      .orderBy('time') // tak jadi taktau la kenapa geram
      .snapshots();

  bool isFromMe = true;

  String? loggedInEmail = FirebaseAuth.instance.currentUser?.email;
  Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    //DateTime _now = DateTime.now();
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return Flexible(
          child: ListView(
            padding: EdgeInsets.all(10.0),
            scrollDirection: Axis.vertical,
            //shrinkWrap: true,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              data = document.data() as Map<String, dynamic>;
              String email = data?['sender'];
              String message = data?['text'];
              //= DateTime now = data?['time'];
              isFromMe = loggedInEmail == email;
              return Column(
                crossAxisAlignment: isFromMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: isFromMe
                          ? Radius.circular(20.0)
                          : Radius.circular(0.0),
                      bottomLeft: Radius.circular(20.0),
                      topRight: isFromMe
                          ? Radius.circular(0.0)
                          : Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    )),
                    margin: EdgeInsets.all(5.0),
                    color: isFromMe ? Colors.lightBlue : Colors.blueGrey,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            email,
                            style: const TextStyle(
                              color: Colors.lightGreenAccent,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
