import 'dart:math';

import 'package:flutter/material.dart';
import 'package:psychesail/components/crud.dart';
import 'package:psychesail/components/text.dart';

Widget communityscroll(sizeWidth,sizeHeight,constr,title,arr) {
  return Wrap(
         spacing: 20,
         runSpacing: 20,
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
                                                SizedBox(
                                                  height: sizeHeight * 0.27,
                                                  child: ListView.separated(
                                                    reverse: false,
                                                                                                scrollDirection: Axis.horizontal,
                                                                                                shrinkWrap: true,
                                                                                                itemCount: arr.length,
                                                                                                itemBuilder: (context,index) {
                                                                                                  return communityContainer(sizeWidth, sizeHeight, constr, arr[arr.length -1 - index].id, arr[arr.length -1 - index]['description']);
                                                                                                },
                                                                                                separatorBuilder : ((context, index) => SizedBox(
                                                                                                  width : min(sizeWidth * 0.05, 30)
                                                                                                )
                                                                                              ),
                                                                                              
                                                ),
                                                )
                                              ],
                                            );
}