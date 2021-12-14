import 'package:flutter/material.dart';

class CreateGroupPost extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    
    return CreateGroupPostState();

  }
}

class CreateGroupPostState extends State<CreateGroupPost>{
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.lightGreen[100],

      appBar: AppBar(
        centerTitle: true,
        // leadingWidth: 75,
        // actionsIconTheme: ,
        title: Text("Create post", style:TextStyle(color: Colors.green.shade700,fontSize: 15, fontWeight: FontWeight.bold)),
        elevation: 1,
        backgroundColor: Colors.lightGreen[100],
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);}, 
          icon: Icon(Icons.clear), 
          color: Colors.green.shade700, 
          tooltip: "Cancel", ),
        actions: <Widget>[
          // IconButton(onPressed: (){}, icon: Icon(Icons.post_add_outlined), color: Colors.green.shade700, tooltip: "Post", )
          OutlinedButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all(BorderSide(color: Colors.transparent)),
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.green.shade700),
            ),
          onPressed: () { },
          child: Text("Post"),
          ),


        ]

      ),
      body: Container(
        width: MediaQuery.of(context).size.width,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          
          SizedBox(height: 24,),

          PhysicalModel(
            color: Colors.transparent,
            shadowColor: Colors.green,
            elevation: 20,
            child: Container(
              width:360,
              padding: EdgeInsets.all(12.0),

              decoration: BoxDecoration(color: Colors.grey[200],borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[

                  Row(
                    children: const <Widget>[
                      FittedBox(
                        fit: BoxFit.contain,
                        child: CircleAvatar(
                        backgroundImage: AssetImage(
                        "assets/Daus.jpg")),
                      ),
                      SizedBox(width: 8,),
                      Text("Firdaus Hishamudin", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ],),

                  SizedBox(height: 8,),

                  const TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none,
                      labelText: "Have something to share?",
                      labelStyle: TextStyle(fontSize: 15),
                      // isDense: true,
                      
                    ),
                  ),
                  SizedBox(height: 60,)




                ],),
          
            ),
          ),
          SizedBox(height: 16,),


          PhysicalModel(
            color: Colors.transparent,
            shadowColor: Colors.green,
            elevation: 20,
            child: Container(
              width: 360,
              

              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Row(children: <Widget>[

                    IconButton(icon: Icon(Icons.photo_library), color: Colors.blue.shade600, onPressed: () {  },),
                    Text("Photo"),


                  ],),

                  Row(children: <Widget>[

                    IconButton(icon: Icon(Icons.camera), color: Colors.purple.shade600 ,onPressed: () {  },),
                    Text("Camera",),

                  ],),

                  Row(children: <Widget>[

                    IconButton(icon: Icon(Icons.videocam), color: Colors.red.shade600, onPressed: () {  },),
                    Text("Video"),

                  ],),

                  




                ],
              ),
              
            ),
          )
          
        ],),
      ),


    );
    

  }

}