import 'package:flutter/material.dart';
import 'package:flutter_group9/widget/custom_title.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AboutGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AboutGroupState();
  }
}

class AboutGroupState extends State<AboutGroup> {

  var description = "This group is created solely on teaching everything about onion.";
  var location = "Kuala Lumpur";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.green[700],
        ),
        // title: Text("About Group"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[

                    CustomTitle("About Us !"),
                    // Text("About Group",style: TextStyle(color: Colors.green[700], fontSize: 24, fontWeight: FontWeight.bold, fontFamily:,)
                    // Padding(
                    //   padding: const EdgeInsets.only(left:18, top:20),
                    //   child: Align(
                    //     alignment: Alignment.topLeft,
                    //     child: Stack(
                    //       children: <Widget>[
                    //         // Stroked text as border.
                    //         Text(
                    //           'About Us !',
                    //           style: TextStyle(
                    //             fontSize: 40,
                    //             foreground: Paint()
                    //               ..style = PaintingStyle.stroke
                    //               ..strokeWidth = 6
                    //               ..color = Colors.green[700]!,
                    //           ),
                    //         ),
                    //         // Solid text as fill.
                    //         Text(
                    //           'About Us !',
                    //           style: TextStyle(
                    //             fontSize: 40,
                    //             color: Colors.lightGreen[100],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    SizedBox(height: 22,),

                    Padding(
                      padding: const EdgeInsets.all(18.0),

                      child: Material(

                        elevation: 20.0,
                        shadowColor: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(

                          width: double.infinity,
                          padding: EdgeInsets.all(18.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.grey[200]),
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                            Text("Description",style: TextStyle(color: Colors.grey[800],fontSize: 22,fontWeight: FontWeight.bold,)),
                            SizedBox(height: 8,),
                            SizedBox(width: double.infinity, height: 3, child: Container(color: Colors.lightGreen,),),
                            SizedBox(height: 18,),
                            Text(description,style: TextStyle(color: Colors.grey[700]),),
                            
                            

                          ],)


                        )
                      ),
                    ),

                     Padding(
                      padding: const EdgeInsets.all(18.0),

                      child: Material(

                        elevation: 20.0,
                        shadowColor: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(

                          width: double.infinity,
                          padding: EdgeInsets.all(18.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.grey[200]),
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                           
                            Text("Related Tags",style: TextStyle(color: Colors.grey[800],fontSize: 22,fontWeight: FontWeight.bold,)),
                            SizedBox(height: 8,),
                            SizedBox(width: double.infinity, height: 3, child: Container(color: Colors.lightGreen,),),
                            SizedBox(height: 18,),
                            Row(
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

                          ],)


                        )
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
