import 'package:flutter/material.dart';
import 'package:flutter_group9/viewgroup.dart';
import 'package:flutter_group9/widget/custom_page_route.dart';
import 'package:flutter_group9/widget/searchservice.dart';

class Groups extends StatefulWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GroupsState();
  }
}

class GroupsState extends State<Groups> with SingleTickerProviderStateMixin {
  //Start of expanded FAB 
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _buttonColor;
  late Animation<double> _animationIcon;
  late Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animationIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(begin: Colors.green[700], end: Colors.red).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.00, 1.00, curve: Curves.linear)));
    _translateButton = Tween<double>(begin: _fabHeight, end: -14.0).animate(
      CurvedAnimation(parent: _animationController, curve: Interval(0.0,0.75, curve: _curve))
    );
    super.initState();
  }
  
  @override
  void dispose() {

    _animationController.dispose();
    super.dispose();
  }
  
  //Widgets
  Widget buttonAdd(){
    return Container(
      child: FloatingActionButton(
        heroTag: "btn1",
        backgroundColor: Colors.green[700],
        onPressed: (){print("button add clicked");},
        tooltip: "Add new group",
        child: Icon(Icons.add),
      )
    );
  }

  Widget buttonSearch(){
    return Container(
      child: FloatingActionButton(
        heroTag: "btn2",
        backgroundColor: Colors.green[700],
        onPressed: (){showSearch(context: context, delegate: CustomSearchDelegate(),);},
        tooltip: "Search groups",
        child: Icon(Icons.search_outlined),
      )
    );
  }
  
  Widget buttonToggle(){
    return Container(
      child: FloatingActionButton(
        heroTag: "btn3",
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: "Toggle",
        child: AnimatedIcon(icon: AnimatedIcons.menu_close,progress: _animationIcon,),
      )
    );
  }
  
  animate(){
    if(!isOpened)
      _animationController.forward();
    else
      _animationController.reverse();
    isOpened = !isOpened;
  }
  //End of expanded FAB

  @override
  Widget build(BuildContext context) {
    //array start here
    final List<String> groupPic = [
      "assets/onion.jpg",
      "assets/carrot.jpg",
      "assets/cabbage.jpg",
      "assets/chili.jpg",
      "assets/spinach.jpg",
      "assets/mushroom.jfif",
      "assets/pumpkin.jfif",
      "assets/brinjal.png",
    ];
    final List<String> groupName = [
      "Group Bawang",
      "Group Lobak Merah",
      "Group Kobis",
      "Group Cili",
      "Group Bayam",
      "Group Cendawan",
      "Group Labu",
      "Group Terung",
    ];
    final List<String> groupNoti = [
      "1 New Post",
      "2 New Post",
      "4 New Post",
      "No New Post",
      "3 New Post",
      "3 New Post",
      "5 New Post",
      "6 New Post",
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.lightGreen[100]),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(45),
                    child: const Text(
                      "Groups",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: groupName.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: GroupBox(
                              '${groupPic[index]}',
                              '${groupName[index]}',
                              '${groupNoti[index]}',
                              context),
                        );
                      },
                    ),
                    //group 1
                    // GroupBox("assets/onion.jpg", "Group Bawang", "1 New Post"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
                0.0, _translateButton.value * 2.0, 0.0),
            child: buttonAdd(),
          ),
           Transform(
            transform: Matrix4.translationValues(
                0.0, _translateButton.value, 0.0),
            child: buttonSearch(),
          ),
          buttonToggle()
           
        ],
      ),

      // FloatingActionButton(
      //   onPressed: () {
      //     // Navigator.push(
      //     //   context,
      //     //   CustomPageRoute(
      //     //     child: SearchGroup(),
      //     //     direction: AxisDirection.up,
      //     //   ),
      //     // );
      //     showSearch(context: context, delegate: CustomSearchDelegate(),);
      //   },
      //   child: const Icon(Icons.explore),
      //   backgroundColor: Colors.green[700],
      //   tooltip: "Explore Other Groups",
      // ),
    );
  }
}

Widget GroupBox(
    String groupPic, String groupName, String groupNoti, BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 60.0,
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CustomPageRoute(
                        child: const ViewGroup(),
                        direction: AxisDirection.left));
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey.shade500),
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.green.shade700),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(groupPic),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                groupName,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                child: Text(
                              groupNoti,
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
        SizedBox(height: 8),
      ],
    ),
  );
}
