// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_group9/maininterface.dart';
import 'package:flutter_group9/widget/custom_page_route.dart';
import 'package:flutter_group9/widget/searchservice.dart';   //import package berkenaan

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

  final searchController = TextEditingController();

 


  @override
  Widget build(BuildContext context){
  //put logic here

    return MaterialApp(   
      debugShowCheckedModeBanner: false,              
    //put widget here
    home: Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(

        // title: TextField(
        //   controller: searchController,
        //   decoration: InputDecoration(
        //     contentPadding: EdgeInsets.only(top:8,bottom:8,left:18,right:18),
        //     hintText: "Search group",
        //     hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
        //     // border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Color(0xFF9E9E9E))),
        //     focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)),borderSide: BorderSide(color: Color(0xFF388E3C), width:2)),
        //     enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)), borderSide: BorderSide(color: Color(0xFF9E9E9E))),
        //     isDense: true,
        //     fillColor: Color(0xFFEEEEEE),
        //     filled: true,
            
            
        //     ),
            
        // ),
        elevation: 1,
        backgroundColor: Colors.lightGreen[100],
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);}, 
          icon: Icon(Icons.clear), 
          color: Colors.green.shade700, 
          tooltip: "Cancel", ),
        
        actions: [

          IconButton(
          icon: Icon(Icons.search_outlined, color:Colors.green[700]), 
          onPressed: (){
            showSearch(context: context, delegate: CustomSearchDelegate(),);
          },
          )

        ],
        

      ),
      body: Container(
        // color: Colors.lightGreen[100],
        // child: Column(children: <Widget>[

        //   Padding(
        //     padding: EdgeInsets.all(22.0),
        //     child: Material(
        //       elevation: 20.0,
        //       shadowColor: Colors.green,
        //       child: Container(
        //         height: 500,
        //         width: double.infinity,
        //         child: ListView.builder(
        //           itemCount: groupName.length,
        //           itemBuilder: (BuildContext context, int index){

        //             return ListTile(
        //               title: Text("${groupName[index]}"),

        //             );
        //           }
        //           )
        //       ),
          
          
        //     ),
        //   ),


        // ],)

      )


    ),

    );
  }


}

// class CustomSearchDelegate extends SearchDelegate{

//    List<String> searchTerms = [
//       "Group Bawang",
//       "Group Lobak Merah",
//       "Group Kobis",
//     ];

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.cancel), 
//         onPressed: () { 
//           query = "";
//          },
//         ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: (){
//         close(context,null);
//       },
//       icon: Icon(Icons.arrow_back_ios)
//       );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     List <String> matchQuery = [];
//     for(var groupName in searchTerms){
//       if(groupName.toLowerCase().contains(query.toLowerCase())){
//         matchQuery.add(groupName);
//       }
//     } 
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context,index){
//         var result = matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       }
//       );   
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//   List <String> matchQuery = [];
//     for(var groupName in searchTerms){
//       if(groupName.toLowerCase().contains(query.toLowerCase())){
//         matchQuery.add(groupName);
//       }
//     } 
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context,index){
//         var result = matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       }
//       );
//   }


// }