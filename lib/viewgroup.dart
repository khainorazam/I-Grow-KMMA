import 'package:flutter/material.dart';
import 'package:flutter_group9/group.dart';
import 'package:flutter_group9/maininterface.dart';
import 'package:flutter_group9/widget/custom_page_route.dart';

void main() {
  runApp(ViewGroup());
}

class ViewGroup extends StatefulWidget {
  const ViewGroup({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ViewGroupState();
  }
}

class ViewGroupState extends State<ViewGroup> {
  List<Color> colors = <Color>[
    Colors.green.shade700,
    Colors.red.shade700,
  ];
  //variable declaration
  var likeStatus = false;
  var membersCount = 1;
  var currentColorIndex = 0;
  var currentOverlayIndex = 1;
  var joinStatus = false;
  var buttonText = "Join";
  var isPostDisabled = true;
  //update FAB disable or enable
  void updateIsPostDisabled(bool status) {
    if (status == true) {
      isPostDisabled = false;
    } else if (status == false) {
      isPostDisabled = true;
    }
  }
  //update like status
  void updateLikeStatus(){

    if(likeStatus==false){

      setState(() {
        likeStatus=true;
      });
      
    }
    else if(likeStatus==true){
      
      setState(() {
        likeStatus=false;      
      });
      

    }
  }
  //update join button color
  void updateColor() {
    if (currentColorIndex == 0) {
      currentColorIndex = 1;
      currentOverlayIndex = 0;
    } else if (currentColorIndex == 1) {
      currentColorIndex = 0;
      currentOverlayIndex = 1;
    }
  }

  //alert dialog
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please confirm'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Would you like to leave this group?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                updateStatus();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //update member count after join button pressed
  void updateMembersNum(bool status) {
    if (status == false) {
      membersCount--;
    } else if (status == true) {
      membersCount++;
    }
  }

  //implement updateStatus fx and alertDialog
  void verifyAction() {
    if (joinStatus == false) {
      updateStatus();
    } else if (joinStatus == true) {
      _showMyDialog();
    }
  }

  //update join status
  void updateStatus() {
    if (joinStatus == false) {
      setState(() {
        joinStatus = true;
        updateColor();
        updateMembersNum(joinStatus);
        updateIsPostDisabled(joinStatus);
        // hasBeenPressed = true;
      });
      buttonText = "Leave";
      print("status : $joinStatus");
    } else if (joinStatus == true) {
      // _showMyDialog();
      setState(() {
        joinStatus = false;
        updateColor();
        updateMembersNum(joinStatus);
        updateIsPostDisabled(joinStatus);
        // hasBeenPressed = false;
      });
      buttonText = "Join";
      print("status : $joinStatus");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[700],
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainInterface.select(1),
                    ));
              },
            ),
            title: const Text(
              "Group Page",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.lightGreen[100],
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 22,
                          ),
                                                                                  //Gambar bawang  
                          
                          
                          PhysicalModel(                                       
                            color: Colors.black,
                            shadowColor: Colors.green,
                            elevation: 10,
                            shape: BoxShape.circle,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                //  boxShadow: [BoxShadow(
                                //    color: Colors.grey,
                                //    spreadRadius: 3,
                                //    blurRadius: 10,
                                //    offset: Offset(0.0, 3.0)
                                //  )],
                              ),
                              child: const FittedBox(
                                child: CircleAvatar(
                                  radius: 75,
                                  backgroundImage:
                                      AssetImage("assets/onion.jpg"),
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          SizedBox(height: 22,),

                          
                                                                                              //start of group title
                          Column(
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.topCenter,
                                children: <Widget>[
                                  PhysicalModel(
                                    color: Colors.black,
                                    shadowColor: Colors.green,
                                    elevation: 20,
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Container(
                                      width: 360,
                                      height: 145,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF0E3311)
                                            .withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(
                                        left: 24.0, right: 24.0),
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10.0),
                                      //  boxShadow: const [BoxShadow(
                                      //    blurRadius: 10,
                                      //    color: Colors.grey,
                                      //    spreadRadius: 3,
                                      //    offset: Offset(0.0, 3.0))],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Group Bawang",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.info_outline_rounded,
                                                color: Colors.green[700],
                                              ),
                                              tooltip: "About Group",
                                            )
                                          ],
                                        ),
                                        Align(
                                          child: Text(
                                            "${membersCount} members",
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              SizedBox(
                                                width: 150,
                                                child: ElevatedButton(
                                                  onPressed: verifyAction,
                                                  child: Text(
                                                    buttonText,
                                                    style: TextStyle(
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(colors[
                                                                  currentColorIndex]),
                                                      overlayColor:
                                                          MaterialStateProperty
                                                              .all<Color>(colors[
                                                                  currentOverlayIndex]),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                      ))),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 150,
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    "Show Members",
                                                    style: TextStyle(
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Colors
                                                                  .grey
                                                                  .shade500),
                                                      overlayColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Colors
                                                                  .green
                                                                  .shade700),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                      ))),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),

                                                                                           //start of post
                          Column(
                            children: [
                              PhysicalModel(
                                color: Colors.transparent,
                                shadowColor: Colors.green,
                                elevation: 20,
                                child: Container(
                                  width: 360,
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    "assets/Daus.jpg")),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("Firdaus Hishamudin",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                "1h",
                                                style: TextStyle(
                                                    color: Colors.grey[600]),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Jom tanam bawang dirumah!",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 200,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.asset(
                                              "assets/BawangPost1.jpg"),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                                                   
                                      Container(                                        //like comment share

                                        width: double.infinity,
                                        height: 40,
                                        decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade500,), bottom: BorderSide(color: Colors.grey.shade500,))),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                                                          
                                          Row(
                                            children: [
                                              IconButton(
                                                  iconSize: 20,
                                                  onPressed: updateLikeStatus,
                                                  icon: Icon(
                                                    Icons.thumb_up_outlined,
                                                    color: likeStatus? Colors.green[700]:Colors.grey[500],
                                                  ),
                                                  tooltip: "Like this post",
                                                ),
                                              Text("Like",style: TextStyle(fontSize: 14,color: likeStatus? Colors.green[700] : Colors.grey[500]),)
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              IconButton(
                                                  iconSize: 20,
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.comment_outlined,
                                                    color: Colors.grey[500],
                                                  ),
                                                  tooltip: "Comment this post",
                                                ),
                                              Text("Comment",style: TextStyle(fontSize: 14,color: Colors.grey[500]),)
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              IconButton(
                                                  iconSize: 20,
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.share_outlined,
                                                    color: Colors.grey[500],
                                                  ),
                                                  tooltip: "Share this post",
                                                ),
                                              Text("Share",style: TextStyle(fontSize: 14,color: Colors.grey[500]),)
                                            ],
                                          ),
                                          


                                        ],),


                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),

                           Column(                                          //second post
                            children: [
                              PhysicalModel(
                                color: Colors.transparent,
                                shadowColor: Colors.green,
                                elevation: 20,
                                child: Container(
                                  width: 360,
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    "assets/Guy1.jfif")),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("Amirul Aiman",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                "2d",
                                                style: TextStyle(
                                                    color: Colors.grey[600]),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Tips menyimpan bawang",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 200,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.asset(
                                              "assets/SimpanBawangPost2.jfif"),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                                                   
                                      Container(                                        //like comment share

                                        width: double.infinity,
                                        height: 40,
                                        decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade500,), bottom: BorderSide(color: Colors.grey.shade500,))),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                                                          
                                          Row(
                                            children: [
                                              IconButton(
                                                  iconSize: 20,
                                                  onPressed: updateLikeStatus,
                                                  icon: Icon(
                                                    Icons.thumb_up_outlined,
                                                    color: likeStatus? Colors.green[700]:Colors.grey[500],
                                                  ),
                                                  tooltip: "Like this post",
                                                ),
                                              Text("Like",style: TextStyle(fontSize: 14,color: likeStatus? Colors.green[700] : Colors.grey[500]),)
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              IconButton(
                                                  iconSize: 20,
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.comment_outlined,
                                                    color: Colors.grey[500],
                                                  ),
                                                  tooltip: "Comment this post",
                                                ),
                                              Text("Comment",style: TextStyle(fontSize: 14,color: Colors.grey[500]),)
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              IconButton(
                                                  iconSize: 20,
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.share_outlined,
                                                    color: Colors.grey[500],
                                                  ),
                                                  tooltip: "Share this post",
                                                ),
                                              Text("Share",style: TextStyle(fontSize: 14,color: Colors.grey[500]),)
                                            ],
                                          ),
                                          


                                        ],),


                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),

                          
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          floatingActionButton: FloatingActionButton(
            onPressed:
                isPostDisabled ? null : () => print("Go to create post page"),
            child: Icon(
              Icons.add_outlined,
              color: isPostDisabled ? Colors.transparent : Colors.white70,
            ),
            elevation: isPostDisabled ? 0 : 6,
            backgroundColor:
                isPostDisabled ? Colors.transparent : Colors.green[700],
            tooltip: isPostDisabled ? null : "Add Post",
          )),
    );
  }
}
