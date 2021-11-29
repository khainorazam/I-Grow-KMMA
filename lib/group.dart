import 'package:flutter/material.dart';
import 'package:flutter_group9/viewgroup.dart';

class Groups extends StatelessWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.lightGreen[100] ),
        child: Column(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(border: Border.all(color: Colors.red, width:1.0)),
            child: Column(children: <Widget>[
              Container(
                margin: const EdgeInsets.all(45),
                // decoration: BoxDecoration(border: Border.all(color: Colors.blue, width:1.0)),
                child: const Text("My Groups", style: TextStyle(color: Colors.black87, fontSize: 35, fontWeight: FontWeight.bold,),),
              ),
              // Container(
              //   margin: EdgeInsets.only(left:10, right:10),
              //   decoration: BoxDecoration(border: Border.all(color: Colors.green, width:1.0)),
              //   child: Row(children: <Widget>[
              //     Expanded(
              //       flex:1,
              //       child: Container(),
              //       ),
              //     IconButton(
              //       onPressed: (){},
              //       icon: Icon(Icons.add_circle_outline_rounded, color: Colors.green[900],),
              //       tooltip: "Add A Post",
              //       splashColor: Colors.lime,
              //       ),
              //       IconButton(
              //       onPressed: (){},
              //       icon: Icon(Icons.search_outlined, color: Colors.green[900],),
              //       tooltip: "Search Groups",
              //       splashColor: Colors.lime,
              //       )
              //   ],),
              // )
            ],),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(                            //group 1
                    margin:const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 60.0,
                      child: ElevatedButton(
                        onPressed: (){
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => const ViewGroup()
                               )
                              );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade500),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.green.shade700),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            ))
                          ),      
                        
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin:const EdgeInsets.only(right:10),
                              child: const CircleAvatar(
                                backgroundImage: AssetImage("assets/onion.jpg"),
                              ),
                            ),
                            
                            Expanded(
                              
                              child: Container(
                                padding: const EdgeInsets.only(top:8.0),
                                // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        // margin: EdgeInsets.all(5.0),
                                        //  padding: EdgeInsets.only(top:10.0),
                                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                        child: const Text("Group Bawang", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                    Align(
                                      alignment:Alignment.centerLeft,
                                      child: Container(
                                        //  margin: const EdgeInsets.only(right:35.0),
                                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                        child: const Text("1 New Post",)
                                        ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
          
                          ],
                        ) 
                        ),
                    ),
                  ),

                  Container(                            //group 2
                    margin:const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 60.0,
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade500),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.green.shade700),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            ))
                          ),      
                        
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin:const EdgeInsets.only(right:10),
                              child: const CircleAvatar(
                                backgroundImage: AssetImage("assets/carrot.jpg"),
                              ),
                            ),
                            
                            Expanded(
                              
                              child: Container(
                                padding: const EdgeInsets.only(top:8.0),
                                // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        // margin: EdgeInsets.all(5.0),
                                        //  padding: EdgeInsets.only(top:10.0),
                                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                        child: const Text("Group Lobak Merah", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                    Align(
                                      alignment:Alignment.centerLeft,
                                      child: Container(
                                        //  margin: const EdgeInsets.only(right:35.0),
                                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                        child: const Text("1 New Post",)
                                        ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
          
                          ],
                        ) 
                        ),
                    ),
                  ),

                  Container(                            //group 3
                    margin:const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 60.0,
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade500),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.green.shade700),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            ))
                          ),      
                        
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin:const EdgeInsets.only(right:10),
                              child: const CircleAvatar(
                                backgroundImage: AssetImage("assets/cabbage.jpg"),
                              ),
                            ),
                            
                            Expanded(
                              
                              child: Container(
                                padding: const EdgeInsets.only(top:8.0),
                                // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        // margin: EdgeInsets.all(5.0),
                                        //  padding: EdgeInsets.only(top:10.0),
                                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                        child: const Text("Group Kobis", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                    Align(
                                      alignment:Alignment.centerLeft,
                                      child: Container(
                                        //  margin: const EdgeInsets.only(right:35.0),
                                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                        child: const Text("1 New Post",)
                                        ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
          
                          ],
                        ) 
                        ),
                    ),
                  ),

                  Container(                            //group 4
                    margin:const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 60.0,
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade500),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.green.shade700),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            ))
                          ),      
                        
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin:const EdgeInsets.only(right:10),
                              child: const CircleAvatar(
                                backgroundImage: AssetImage("assets/chili.jpg"),
                              ),
                            ),
                            
                            Expanded(
                              
                              child: Container(
                                padding: const EdgeInsets.only(top:8.0),
                                // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        // margin: EdgeInsets.all(5.0),
                                        //  padding: EdgeInsets.only(top:10.0),
                                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                        child: const Text("Group Cili", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                    Align(
                                      alignment:Alignment.centerLeft,
                                      child: Container(
                                        //  margin: const EdgeInsets.only(right:35.0),
                                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                        child: const Text("1 New Post",)
                                        ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
          
                          ],
                        ) 
                        ),
                    ),
                  ),

                  Container(                            //group 5
                    margin:const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 60.0,
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade500),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.green.shade700),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            ))
                          ),      
                        
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin:const EdgeInsets.only(right:10),
                              child: const CircleAvatar(
                                backgroundImage: AssetImage("assets/spinach.jpg"),
                              ),
                            ),
                            
                            Expanded(
                              
                              child: Container(
                                padding: const EdgeInsets.only(top:8.0),
                                // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        // margin: EdgeInsets.all(5.0),
                                        //  padding: EdgeInsets.only(top:10.0),
                                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                        child: const Text("Group Bayam", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                    Align(
                                      alignment:Alignment.centerLeft,
                                      child: Container(
                                        //  margin: const EdgeInsets.only(right:35.0),
                                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                        child: const Text("1 New Post",)
                                        ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
          
                          ],
                        ) 
                        ),
                    ),
                  ),

                   Container(                            //group 6
                    margin:const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 60.0,
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade500),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.green.shade700),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            ))
                          ),      
                        
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin:const EdgeInsets.only(right:10),
                              child: const CircleAvatar(
                                backgroundImage: AssetImage("assets/mushroom.jfif"),
                              ),
                            ),
                            
                            Expanded(
                              
                              child: Container(
                                padding: const EdgeInsets.only(top:8.0),
                                // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        // margin: EdgeInsets.all(5.0),
                                        //  padding: EdgeInsets.only(top:10.0),
                                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                        child: const Text("Group Cendawan", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                    Align(
                                      alignment:Alignment.centerLeft,
                                      child: Container(
                                        //  margin: const EdgeInsets.only(right:35.0),
                                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                        child: const Text("1 New Post",)
                                        ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
          
                          ],
                        ) 
                        ),
                    ),
                  ),

                   Container(                            //group 7
                    margin:const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 60.0,
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade500),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.green.shade700),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            ))
                          ),      
                        
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin:const EdgeInsets.only(right:10),
                              child: const CircleAvatar(
                                backgroundImage: AssetImage("assets/pumpkin.jfif"),
                              ),
                            ),
                            
                            Expanded(
                              
                              child: Container(
                                padding: const EdgeInsets.only(top:8.0),
                                // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        // margin: EdgeInsets.all(5.0),
                                        //  padding: EdgeInsets.only(top:10.0),
                                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                        child: const Text("Group Labu", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                    Align(
                                      alignment:Alignment.centerLeft,
                                      child: Container(
                                        //  margin: const EdgeInsets.only(right:35.0),
                                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                        child: const Text("1 New Post",)
                                        ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
          
                          ],
                        ) 
                        ),
                    ),
                  ),

                  Container(                            //group 8
                    margin:const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 60.0,
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade500),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.green.shade700),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            ))
                          ),      
                        
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin:const EdgeInsets.only(right:10),
                              child: const CircleAvatar(
                                backgroundImage: AssetImage("assets/brinjal.png"),
                              ),
                            ),
                            
                            Expanded(
                              
                              child: Container(
                                padding: const EdgeInsets.only(top:8.0),
                                // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        // margin: EdgeInsets.all(5.0),
                                        //  padding: EdgeInsets.only(top:10.0),
                                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                        child: const Text("Group Terung", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                    Align(
                                      alignment:Alignment.centerLeft,
                                      child: Container(
                                        //  margin: const EdgeInsets.only(right:35.0),
                                        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                        child: const Text("1 New Post",)
                                        ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
          
                          ],
                        ) 
                        ),
                    ),
                  ),
                 
                  
                  
                 
                   
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
                ],
              ),
              ),
          ),
        ],),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){}, child: const Icon(Icons.explore),
        backgroundColor: Colors.green[700],
        tooltip: "Explore Other Groups",
        ) ,
    );
  }
}
