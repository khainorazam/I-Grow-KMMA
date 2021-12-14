import 'package:flutter/material.dart';

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
                    // Text("About Group",style: TextStyle(color: Colors.green[700], fontSize: 24, fontWeight: FontWeight.bold, fontFamily:,)
                    Padding(
                      padding: const EdgeInsets.only(left:18, top:20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Stack(
                          children: <Widget>[
                            // Stroked text as border.
                            Text(
                              'About Us !',
                              style: TextStyle(
                                fontSize: 40,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 6
                                  ..color = Colors.green[700]!,
                              ),
                            ),
                            // Solid text as fill.
                            Text(
                              'About Us !',
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.lightGreen[100],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

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

                           
                            Text("Location",style: TextStyle(color: Colors.grey[800],fontSize: 22,fontWeight: FontWeight.bold,)),
                            SizedBox(height: 8,),
                            SizedBox(width: double.infinity, height: 3, child: Container(color: Colors.lightGreen,),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                IconButton(onPressed: (){}, icon: Icon(Icons.pin_drop), color: Colors.red,),
                                Text(location,style: TextStyle(color: Colors.grey[700]),),
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
