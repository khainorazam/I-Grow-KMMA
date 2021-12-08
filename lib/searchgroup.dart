import 'package:flutter/material.dart';
import 'package:flutter_group9/maininterface.dart';
import 'package:flutter_group9/widget/custom_page_route.dart';   //import package berkenaan

void main(){                              //declare main
  runApp(SearchGroup());
}

class SearchGroup extends StatefulWidget{   //declare class as child Stateful widget

  @override
  State<StatefulWidget> createState(){
    return _SearchGroupState();
  }
}

class _SearchGroupState extends State<SearchGroup>{   //declare class as child state

  @override
  Widget build(BuildContext context){
  //put logic here

    return MaterialApp(                     
    //put widget here
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context
              );
          },
          ),
        title: Text("Search Group Page", style: TextStyle(fontWeight: FontWeight.bold),),

      ),
      body: Container(
        color: Colors.lightGreen[100],

      )


    ),

    );
  }


}