import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group9/chats/chat_message_bubble.dart';

import 'package:flutter_group9/chats/constants.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  var _controller = TextEditingController();

  String message = "";
  var now = DateTime.now();

  Future<void> addMessage() {
    return messages
        .add({
          'sender': FirebaseAuth.instance.currentUser?.email,
          'text': message,
          'time': FieldValue.serverTimestamp(),
        })
        .then((value) => print("Message Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> clearMessage() async {
    var collection = FirebaseFirestore.instance.collection('messages');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                clearMessage();
              }),
        ],
        title: Text('⚡️ Chatroom'),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ChatBubble(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _controller.clear();
                      addMessage();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
