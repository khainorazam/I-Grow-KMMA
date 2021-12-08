// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_group9/viewgroup.dart';

class ViewGroupMember extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

     final List<String> memberPic = [
      "assets/Daus.jpg",
      "assets/Guy1.jfif"
    ];
    final List<String> memberName = [
      "Firdaus Hishamudin",
      "Haikal Iman",
    ];
    final List<String> memberStatus = [
      "member",
      "admin",
    ];

    return Scaffold(
      backgroundColor: Colors.lightGreen[100],

      appBar: AppBar(
        title: Text("Group Members"),
        backgroundColor: Colors.green[700],
        automaticallyImplyLeading: true,
        leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop( context);
              },
            ),
      ),

      body: Column(
        children: <Widget>[
          Expanded(
            child:SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  
                  children: <Widget>[
                    SizedBox(height: 24,),

                  //list name start here
                   ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: memberName.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: ViewMemberBox(
                            '${memberPic[index]}',
                            '${memberName[index]}',
                            '${memberStatus[index]}',
                            context
                            ),
                      );
                    },
                  ),




                  // Container(
                  //   child: Column(
                  //     children: [
                  //       Container(
                  //         width: MediaQuery.of(context).size.width,
                  //         margin: EdgeInsets.only(left: 16,right: 16),
                  //         // decoration: BoxDecoration(border: Border.all(color: Colors.black),),
                  //         child: ElevatedButton(
                  //           onPressed: (){}, 
                  //           child: Row(
                             
                  //             mainAxisAlignment:MainAxisAlignment.start,
                  //             children: <Widget>[

                  //              SizedBox(width:8),
                  //              CircleAvatar(
                  //                backgroundImage: AssetImage("assets/Daus.jpg"),
                  //               ),
                  //               SizedBox(width: 12,),
                                
                  //               Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,    
                  //                 children: <Widget>[

                  //                 Text("Firdaus Hishamudin",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                  //                 Text("member")

                  //               ],)

                  //           ],),
                  //           style: ButtonStyle(
                  //             padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8)),
                  //             backgroundColor:MaterialStateProperty.all<Color>(Colors.grey.shade500),
                  //             overlayColor: MaterialStateProperty.all<Color>( Colors.green.shade700),
                  //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(18.0),
                  //                         ))),
                  //           ),
                  //       ),
                  //       SizedBox(height: 8,),
                  //     ],
                  //   ),
                  // ),
                    
                    //list name ends here


                ],),
              ),
            )

          ),

      ],)




    );
    
  }


}

Widget ViewMemberBox(String memberImg, String memberName, String memberStatus, BuildContext context) {

  return  Container(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 16,right: 16),
                          // decoration: BoxDecoration(border: Border.all(color: Colors.black),),
                          child: ElevatedButton(
                            onPressed: (){}, 
                            child: Row(
                             
                              mainAxisAlignment:MainAxisAlignment.start,
                              children: <Widget>[

                               SizedBox(width:8),
                               CircleAvatar(
                                 backgroundImage: AssetImage(memberImg),
                                ),
                                SizedBox(width: 12,),
                                
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,    
                                  children: <Widget>[

                                  Text(memberName,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                                  Text(memberStatus),

                                ],)

                            ],),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8)),
                              backgroundColor:MaterialStateProperty.all<Color>(Colors.grey.shade500),
                              overlayColor: MaterialStateProperty.all<Color>( Colors.green.shade700),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                                          ))),
                            ),
                        ),
                        SizedBox(height: 8,),
                      ],
                    ),
                  );


}