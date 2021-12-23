import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget{

  String title = "";
  CustomTitle(this.title);
  
  @override
  Widget build(BuildContext context) {
    
    return  Padding(
                      padding: const EdgeInsets.only(left:18, top:20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Stack(
                          children: <Widget>[
                            // Stroked text as border.
                            Text(
                              title,
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
                              title,
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.lightGreen[100],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
  }


}