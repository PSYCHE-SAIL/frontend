import 'package:flutter/material.dart';

Widget circleButton(constr,greaterwidth,lesswidth,imagestring) {
  return Container(
        child: Padding(

      padding: EdgeInsets.all(constr ? greaterwidth : lesswidth),
      child: Image.asset(imagestring,fit: BoxFit.cover,),
  ),decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.transparent,

    border: Border.all(
      color: Colors.grey,
      width: 1.0,
    ),
  ),);
}

Widget bottomButton(constr,greaterwidth,lesswidth,txt,col,txtcol) {
  return Container(
    decoration: BoxDecoration(
        color: col,
        borderRadius: BorderRadius.all(Radius.circular(20))
    ),

    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(txt,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: constr ? greaterwidth : lesswidth,
            fontStyle: FontStyle.italic,
            fontFamily: 'ABeeZee',
            color: txtcol
        ),
        overflow: TextOverflow.fade,),
    ),
  );
}

