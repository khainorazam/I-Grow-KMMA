import 'package:flutter_group9/chat/user.dart';
import 'package:flutter_group9/chat/message_widget.dart';
import 'package:flutter_group9/chat/new_message_widget.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final User user;

  const ChatPage({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
            children: [
              NewMessageWidget(idUser: widget.user.idUser)
            ],
          ),
        ),
      );
}