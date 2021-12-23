import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_group9/widget/custom_title.dart';

class GroupSuggestion extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    
    return GroupSuggestionState();
  }


}

class GroupSuggestionState extends State<GroupSuggestion>{

  final List<String> groupPic = [
      "assets/onion.jpg",
      "assets/onion.jpg",
      "assets/onion.jpg",
      
    ];
    final List<String> groupName = [
      "Geng Bawang Wangsa Maju",
      "Rakan Niaga Bawang Cheras",
      "Onion Association Of Gombak",
     
    ];
    final List<String> groupMemberCount = [
      "100 members",
      "79 members",
      "150 members",
     
    ];
 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: () { Navigator.pop(context); },
          color: Colors.green[700],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: <Widget>[

                CustomTitle("Only For You !"),
                const SizedBox(height: 22,),
                Padding(
                  padding: const EdgeInsets.only(right:8.0,left:8.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 90,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50), 
                            color: Colors.purple[700],
                            ),
                          padding: EdgeInsets.all(8),
                          child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(MdiIcons.tag,color:Colors.white,size:20),
                              SizedBox(width: 5,),
                              Text('Onion',style:TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ))
                        ),
                      ),
                      SizedBox(width:5),
                      Container(
                        
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50), 
                            color: Colors.orange[700],
                            ),
                          padding: EdgeInsets.all(8),
                          child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(MdiIcons.tag,color:Colors.white,size:20),
                              SizedBox(width: 5,),
                              Text('Kuala Lumpur',style:TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ))
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22,),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: groupName.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: SuggestedGroupBox(
                          '${groupPic[index]}',
                          '${groupName[index]}',
                          '${groupMemberCount[index]}',
                          context
                          ),
                    );
                  },
                  )

                // Padding(
                //   padding: const EdgeInsets.all(8),
                //   child: SizedBox(
                //     width: MediaQuery.of(context).size.width,
                //     child: ElevatedButton(
                //       onPressed: (){}, 
                //       child: Padding(
                //         padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                //         child: Row(
                               
                //                 mainAxisAlignment:MainAxisAlignment.start,
                //                 children: <Widget>[

                //                  SizedBox(width:8),
                //                  CircleAvatar(
                //                    backgroundImage: AssetImage(groupPic[1]),
                //                   ),
                //                   SizedBox(width: 12,),
                                  
                //                   Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,    
                //                     children: <Widget>[

                //                     Text(groupName[1],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                //                     Text(groupMemberCount[1]),

                //                   ],)

                //               ],),
                //       ),
                //       style: ButtonStyle(
                //         backgroundColor:
                //           MaterialStateProperty.all<Color>(Colors.grey.shade500),
                //       overlayColor:
                //           MaterialStateProperty.all<Color>(Colors.green.shade700),
                //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //           RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(18.0),
                //       ))),
                //       ),
                //   ),
                // )
                

              ],),)
          ),

        ],
      ),


    );

  }


}

Widget SuggestedGroupBox (String groupPic, String groupName, String groupMemberCount, BuildContext context ){

  return Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: (){}, 
                      child: Padding(
                        padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                        child: Row(
                               
                                mainAxisAlignment:MainAxisAlignment.start,
                                children: <Widget>[

                                 SizedBox(width:8),
                                 CircleAvatar(
                                   backgroundImage: AssetImage(groupPic),
                                  ),
                                  SizedBox(width: 12,),
                                  
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,    
                                    children: <Widget>[

                                    Text(groupName,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                                    Text(groupMemberCount),

                                  ],)

                              ],),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey.shade500),
                      overlayColor:
                          MaterialStateProperty.all<Color>(Colors.green.shade700),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                      ),
                  ),
                );
}