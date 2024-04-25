import 'dart:math';

import 'package:flutter/material.dart';
import 'package:psychesail/components/crud.dart';
import 'package:psychesail/components/text.dart';

Widget communityscroll(sizeWidth,sizeHeight,constr,title,arr) {
  return Wrap(
         spacing: 20,
         runSpacing: min(20,sizeWidth * 0.0006),
                                              children: [
                                                
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(title, 
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: sizeWidth * sizeHeight * 0.000067,
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                    ),
                                                     Text("See All", 
                                                     style : TextStyle(
                                                      color: Colors.black
                                                     )
                                                     ),
                                                  ],
                                                ),
                                                SizedBox(height: sizeHeight * 0.01,),
                                                SizedBox(
                                                  height: sizeHeight * 0.27,
                                                  child: ListView.separated(
                                                    reverse: false,
                                                                                                scrollDirection: Axis.horizontal,
                                                                                                shrinkWrap: true,
                                                                                                itemCount: arr.length,
                                                                                                itemBuilder: (context,index) {
                                                                                                  return communityContainer(sizeWidth, sizeHeight, constr, arr[arr.length - 1 - index].id, arr[arr.length -1 - index]['description'],arr[arr.length-1 -index]['url']);
                                                                                                },
                                                                                                separatorBuilder : ((context, index) => SizedBox(
                                                                                                  width : min(sizeWidth * 0.05, 30),
                                                                                                )
                                                                                              ),
                                                                                              
                                                ),
                                                )
                                              ],
                                            );
}

Widget activityscroll(sizeWidth,sizeHeight,constr,title,arr) {
  return Wrap(
         spacing: 20,
         runSpacing: min(20,sizeWidth * 0.0006),
                                              children: [
                                                
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(title, 
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: sizeWidth * sizeHeight * 0.000067,
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                    ),
                                                     Text("See All", 
                                                     style : TextStyle(
                                                      color: Colors.black
                                                     )
                                                     ),
                                                  ],
                                                ),
                                                SizedBox(height: sizeHeight * 0.01,),
                                                SizedBox(
                                                  height: sizeHeight * 0.15,
                                                  child: ListView.separated(
                                                    reverse: false,
                                                                                                scrollDirection: Axis.horizontal,
                                                                                                shrinkWrap: true,
                                                                                                itemCount: arr.length,
                                                                                                itemBuilder: (context,index) {
                                                                                                  return activityContainer(sizeWidth, sizeHeight, constr, arr[arr.length - 1 - index].id,arr[arr.length - 1- index]['url']);
                                                                                                },
                                                                                                separatorBuilder : ((context, index) => SizedBox(
                                                                                                  width : min(sizeWidth * 0.05, 30),
                                                                                                )
                                                                                              ),
                                                                                              
                                                ),
                                                )
                                              ],
                                            );
}

Widget historyscroll(sizeWidth,sizeHeight,constr,title,arr,context,currentUser) {
  return Wrap(
         spacing: 20,
         runSpacing: min(20,sizeWidth * 0.0006),
                                              children: [
                                                
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(title, 
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: sizeWidth * sizeHeight * 0.000067,
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                    ),
                                                     InkWell(
                                                      onTap: () => Navigator.pushNamed(context, '/progress',arguments : {
                                                        'currentuser' : currentUser,
                                                        'historycollection' : arr
                                                      }),
                                                       child: Text("See All", 
                                                       style : TextStyle(
                                                        color: Colors.black
                                                       )
                                                       ),
                                                     ),
                                                  ],
                                                ),

                                                Container(
                                                  constraints: BoxConstraints(
maxHeight: sizeHeight * 0.2,
                                                  ),
                                                  
                                                  child: ListView.separated(
                                                    reverse: false,
                                                                                                scrollDirection: Axis.horizontal,
                                                                                                shrinkWrap: true,
                                                                                                itemCount: arr.length,
                                                                                                itemBuilder: (context,index) {
                                                                                                  return historyContainer(sizeWidth, sizeHeight, constr, arr[index][0],arr[index][1]);
                                                                                                },
                                                                                                separatorBuilder : ((context, index) => SizedBox(
                                                                                                  width : min(sizeWidth * 0.05, 30),
                                                                                                )
                                                                                              ),
                                                                                              
                                                ),
                                                )
                                              ],
                                            );
}

