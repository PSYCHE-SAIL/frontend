
import 'package:flutter/material.dart';

Widget HigthlightText(fontsize,minheight,txt) {
  return Container(
                      constraints: BoxConstraints(
                        minHeight: minheight,
                      ),
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(txt,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fontsize,
                          fontFamily: 'ABeeZee',
                          color: Colors.white.withOpacity(0.6),
                          fontStyle: FontStyle.italic
                        
                        ),
                        overflow: TextOverflow.fade,),
                      ),
                    );
}

Widget greyText(fontsize,minheight,txt) {
  return Container(
    decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
              ),
                      constraints: BoxConstraints(
                        minHeight: minheight,
                      ),
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(txt,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fontsize,
                          fontFamily: 'ABeeZee',
                          color: Colors.grey,
                          fontStyle: FontStyle.italic
                        
                        ),
                        overflow: TextOverflow.fade,),
                      ),
                    );
}

Widget divider(constr,greaterwidth,lesswidth,col) {
  return Row(children: [
                      Expanded(
                        child: new Container(
                            margin:  EdgeInsets.symmetric( horizontal: constr ? greaterwidth:lesswidth),
                            child: Divider(
                              color: col,
                              height: 36,
                              thickness: 0.25,
                            )),
                      ),
                      Text("OR", textAlign: TextAlign.center,
            style: TextStyle(
            color: col,
            fontSize: 14,
            fontStyle: FontStyle.italic,
            fontFamily: 'ABeeZee',
            fontWeight: FontWeight.w400,
            
            )),
                      Expanded(
                        child: new Container(
                            margin: EdgeInsets.symmetric( horizontal: constr ? greaterwidth:lesswidth),
                            child: Divider(
                              color: col,
                              height: 36,
                              thickness: 0.25,
                            )),
                      ),
                    ]);
}
