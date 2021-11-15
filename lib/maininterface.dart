import 'package:flutter/material.dart';
import 'package:flutter_group9/friend.dart';
import 'package:flutter_group9/group.dart';
import 'package:flutter_group9/profile.dart';
import 'package:flutter_group9/timline.dart';

class MainInterface extends StatelessWidget {
  const MainInterface({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.lightGreen.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Image.asset(
            'assets/igrowicon.png',
            fit: BoxFit.contain,
            height: 70,
            width: 250,
          ),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Color(0xFFDCEDC8)),
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'Groups'),
              Tab(text: 'Friends'),
              Tab(text: 'Profile'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Timeline(),
            Groups(),
            Friends(),
            Profile(),
          ],
        ),
      ),
    );
  }
}
