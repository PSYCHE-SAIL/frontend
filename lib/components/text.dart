import 'package:flutter/material.dart';
import 'package:gdscsol/components/button.dart';

Widget HigthlightText(fontsize, minheight, txt) {
  return Container(
    constraints: BoxConstraints(
      minHeight: minheight,
    ),
    alignment: Alignment.center,
    child: Center(
      child: Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: fontsize,
            fontFamily: 'ABeeZee',
            color: Colors.white.withOpacity(0.6),
            fontStyle: FontStyle.italic),
        overflow: TextOverflow.fade,
      ),
    ),
  );
}

Widget greyText(fontsize, minheight, txt) {
  return Center(
    child: Text(
      txt,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: fontsize,
          fontFamily: 'ABeeZee',
          color: Colors.grey,
          fontStyle: FontStyle.italic),
      overflow: TextOverflow.fade,
    ),
  );
}

Widget divider(constr, greaterwidth, lesswidth, col) {
  return Row(children: [
    Expanded(
      child: new Container(
          margin: EdgeInsets.symmetric(
              horizontal: constr ? greaterwidth : lesswidth),
          child: Divider(
            color: col,
            height: 36,
            thickness: 0.25,
          )),
    ),
    Text("OR",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: col,
          fontSize: 14,
          fontStyle: FontStyle.italic,
          fontFamily: 'ABeeZee',
          fontWeight: FontWeight.w400,
        )),
    Expanded(
      child: new Container(
          margin: EdgeInsets.symmetric(
              horizontal: constr ? greaterwidth : lesswidth),
          child: Divider(
            color: col,
            height: 36,
            thickness: 0.25,
          )),
    ),
  ]);
}

Widget dividervertical(constr, greaterwidth, lesswidth, col) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          color: Colors.grey,
          height: greaterwidth,
          width: 1,
        ),
      ),
      Text("OR",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: col,
            fontSize: 14,
            fontStyle: FontStyle.italic,
            fontFamily: 'ABeeZee',
            fontWeight: FontWeight.w400,
          )),
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          color: Colors.grey,
          height: greaterwidth,
          width: 1,
        ),
      ),
    ],
  );
}

InputDecoration logininput(txt, example) {
  return InputDecoration(
      border: UnderlineInputBorder(),
      labelText: txt,
      labelStyle: TextStyle(
          fontStyle: FontStyle.italic,
          fontFamily: 'ABeeZee',
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(35, 154, 139, 75)),
      helperText: example);
}

Widget textbubble(
    message, timestamp, receiverid, currentid, bgcolor, condition, context) {
  bool constr = (receiverid == currentid);
  final size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment:
          (constr) ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment:
          (constr) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
            child: Padding(
                padding: EdgeInsets.all(9.0),
                child: (constr)
                    ? Container()
                    : circleButton(condition, size.width / 150,
                        size.height / 90, "assets/idea.png"))),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: bgcolor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment:
                  (constr) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: TextStyle(
                      color: (constr) ? Colors.white : Colors.black,
                      fontSize: 17),
                ),
                SizedBox(height: 4),
                Text(
                  timestamp,
                  style: TextStyle(color: Colors.black45, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget homechatbubble(
    constr, sizeWidth, sizeHeight, user, context, currentUserId) {
  return Column(children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              print(user['id']);
              print(user['email']);
              print(currentUserId);
              if(user['id'].toString() == 'monkeybot') {
                Navigator.pushNamed(context, '/monkeybot', arguments: {
                  'receiveremail': user['email'],
                  'receiverid': user['id'],
                  'currentid': currentUserId,
                });
              }
              else{
  Navigator.pushNamed(context, '/chatroom', arguments: {
  'receiveremail': user['email'],
  'receiverid': user['id'],
  'currentid': currentUserId,
  });
  }
              }
  ,
            child: Text(
              user['id'].toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: constr ? sizeWidth / 40 : sizeWidth / 20,
                fontStyle: FontStyle.italic,
                fontFamily: 'ABeeZee',
              ),
            ),
          )
        ],
      ),
    ),
    // Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(4.0),
    //         child: Column(
    //           children: [
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               children: [
    //                 Text(
    //                   "2 min",
    //                   style: TextStyle(
    //                     color: Colors.grey,
    //                     fontStyle: FontStyle.italic,
    //                     fontFamily: 'ABeeZee',
    //                   ),
    //                 ),
    //                 CircleAvatar(
    //                     maxRadius: constr ? sizeWidth / 65 : sizeWidth / 40,
    //                     backgroundColor: Colors.red,
    //                     child: Text(
    //                       "3",
    //                       style: TextStyle(
    //                         fontSize: sizeWidth / 50,
    //                       ),
    //                     )),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(4.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: [
    //             Text(
    //               "2 min",
    //               style: TextStyle(
    //                 color: Colors.grey,
    //                 fontStyle: FontStyle.italic,
    //                 fontFamily: 'ABeeZee',
    //               ),
    //             ),
    //             CircleAvatar(
    //                 maxRadius: constr ? sizeWidth / 65 : sizeWidth / 40,
    //                 backgroundColor: Colors.red,
    //                 child: Text(
    //                   "3",
    //                   style: TextStyle(fontSize: sizeWidth / 50),
    //                 )),
    //           ],
    //         ),
    //       ),
    //     ])
  ]);
}
