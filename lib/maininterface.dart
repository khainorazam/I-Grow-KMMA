import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_group9/friend.dart';
import 'package:flutter_group9/group.dart';
import 'package:flutter_group9/profile.dart';
import 'package:flutter_group9/timeline.dart';
import 'package:flutter_group9/workshop.dart';

class MainInterface extends StatelessWidget {
  MainInterface({Key? key}) : super(key: key);
  int selectedPage = 0;
  MainInterface.select(this.selectedPage);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: selectedPage,
      length: 5,
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
            labelColor: Color(0xFF33691E),
            unselectedLabelColor: Colors.black,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: Color(0xFFDCEDC8)),
            tabs: [
              Tab(
                //text: 'Home',
                icon: Icon(Icons.home_rounded),
              ),
              Tab(
                //text: 'Groups',
                icon: Icon(Icons.groups_rounded),
              ),
              Tab(
                //text: 'Friends',
                icon: Icon(Icons.people_rounded),
              ),
              Tab(
                //text: 'Profile',
                icon: Icon(Icons.build_circle_rounded),
              ),
              Tab(
                //text: 'Profile',
                icon: Icon(Icons.account_circle_rounded),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Timeline(),
            Groups(),
            Friends(),
            Workshop(),
            Profile(),
          ],
        ),
      ),
    );
  }
}
