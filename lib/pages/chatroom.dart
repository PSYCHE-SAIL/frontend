import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/textField.dart';
import '../components/crud.dart';
import '../components/text.dart';
import '../model/message.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({
    super.key,
  });

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DatabaseReference reff = FirebaseDatabase.instance.ref("/users");

  var receiveremail;
  var receiverid;
  var currentid;
  var communityname;

  dynamic _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await sendcommunitymessage(
          _messageController.text, currentid, communityname);
      _messageController.clear();
      return true;
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    final Map<String, dynamic>? args =
    ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, dynamic>?;
    final size = MediaQuery
        .of(context)
        .size;
    // Access individual parameters
    communityname = args?['communityname'] ?? 'community';
    currentid = args?['currentid'] ?? '';
    receiverid =
        args?['receiverid'] ?? ((currentid == 'Joe') ? 'Disha' : 'Joe');

    print(receiverid);
    print(communityname);
    print(currentid);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          title: Center(child: Text(communityname)),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: size.width / 50),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/video', arguments: {
                        'currentid': currentid,
                        'senderid': 'community'
                      });
                    },
                    icon: Icon(Icons.call),
                    color: Colors.white))
          ],
        ),
        body: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/background_chatbot.png"),fit: BoxFit.cover)),
          child: Column(children: [
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                color: Colors.transparent,
                child: _buildMessageList(receiverid, currentid,sizeWidth,sizeHeight),
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(vertical : 12,
                    horizontal: 9),
                height: 120,
                color: Colors.transparent,
                child: Column(
                  children: [
                    Row(
                                      children: [
                                        _chatField(_messageController),
                                        const SizedBox(
                                          width: 9,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            _sendMessage();
                                          },
                                          child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.black,
                                                  child: Icon(
                                                    Icons.send,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                        ),
                                      ],
                                    )
                  ],
                )),
            SizedBox(),
          ]),
        ));
  }

// build message list
  Widget _buildMessageList(receiverid, currentid,sizeWidth,sizeHeight) {
    return StreamBuilder(
        stream: getcommunitymessages(currentid,communityname),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }
          final documents = snapshot.data!.docs;
          Map<Timestamp,dynamic> arr = {};
          for (var docSnapshot in documents) {
 var docDataRaw = docSnapshot.data();
 print(docDataRaw);
 
  // Accessing a sub-co // Print the data of each document in the sub-collection
  
}
          // return Placeholder(
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index){
              return _buildMessageItem(documents[index], currentid,sizeWidth,sizeHeight);
            },
          );
        });
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot document, currentid,sizeWidth,sizeHeight) {
    print("POPOPOPOO");
    print(document.data());
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderid'] == currentid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    var bgcolor = (data['senderid'] == currentid)
        ? Color.fromRGBO(32, 160, 144, 100)
        : Color.fromRGBO(121, 124, 123, 100);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          bool constr = false;
          if (constraints.maxWidth > 600) constr = true;
          return 
          Column(
            crossAxisAlignment: (data['senderid'] == currentid) ? CrossAxisAlignment.end :CrossAxisAlignment.start ,
            children: [
              
              Row(
                mainAxisAlignment: (data['senderid'] == currentid) ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: (data['senderid'] == currentid) ? CrossAxisAlignment.start :CrossAxisAlignment.end ,
                      children: [
                        Padding(
                padding: (data['senderid'] == currentid)
              ? EdgeInsets.only(
                 top: min(12, sizeWidth * 0.05),
                  right: min(sizeHeight * 0.05, 12),
                  left: sizeHeight * 0.05,
                )
              : EdgeInsets.only(
                top: min(12, sizeWidth * 0.05),
                  left: min(sizeHeight * 0.05, 12),
                  right: sizeHeight * 0.05,
                ),
                child: Text(
                    data['senderid'],
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
              ),
                        Container(
                                      margin: (data['senderid'] == currentid)
                                      ? EdgeInsets.only(
                                          right: min(sizeHeight * 0.05, 12),
                                          left: sizeHeight * 0.05,
                                        )
                                      : EdgeInsets.only(
                                          
                                          
                                          left: min(sizeHeight * 0.05, 12),
                                          right: sizeHeight * 0.05,
                                        ),
                                          padding: EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                        borderRadius: (data['senderid'] == currentid)
                                        ? BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(12),
                                          )
                                        : BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                                          ),
                        color: (data['senderid'] == currentid)
                                        ? Color.fromRGBO(32, 160, 144, 100)
                                        : Colors.grey,
                        border: Border.all(color: Colors.black),
                                          ),
                                      child: Text(
                                        data['message'],
                                        style: TextStyle(
                                          color: (data['senderid'] == currentid) ? Colors.white : Colors.black,
                                          fontSize: 17,
                                        ),
                                      ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: (data['senderid'] == currentid)
              ? EdgeInsets.only(
                 
                  right: min(sizeHeight * 0.05, 12),
                  left: sizeHeight * 0.05,
                )
              : EdgeInsets.only(
                  left: min(sizeHeight * 0.05, 12),
                  right: sizeHeight * 0.05,
                ),
                child: Text(
                    '${data['timestamp']
                          .toDate()
                          .toLocal()
                          .hour}:' +
                          '${data['timestamp']
                              .toDate()
                              .toLocal()
                              .minute
                              .toString()
                              .padLeft(2, '0')}',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
              ),
            ],
          );
          
          // Container(
          //   alignment: alignment,
          //   child: Column(
          //     crossAxisAlignment: (data['senderid'] == currentid)
          //         ? CrossAxisAlignment.end
          //         : CrossAxisAlignment.start,
          //     mainAxisAlignment: (data['senderid'] == currentid)
          //         ? MainAxisAlignment.end
          //         : MainAxisAlignment.start,
          //     children: [
          //       // Text(data['senderid'],style: const TextStyle(backgroundColor: Colors.transparent,color: Colors.black,fontSize: 15,),),
          //       textbubble(
          //           data['message'],
          //           '${data['timestamp']
          //               .toDate()
          //               .toLocal()
          //               .hour}:' +
          //               '${data['timestamp']
          //                   .toDate()
          //                   .toLocal()
          //                   .minute
          //                   .toString()
          //                   .padLeft(2, '0')}',
          //           data['senderid'],
          //           currentid,
          //           bgcolor,
          //           constr,
          //           context),
          //     ],
          //   ),
          // );
        });
  }

  // build message input
//   Widget _buildMessageInput() {
//     return Row(
//       children: [
//         //textfield
//         Expanded(
//           child: MyTextField(
//             controller: _messageController,
//             hinttext: 'Enter message...',
//             obscureText: false,
//           ),
//         ),
//
//         // send button
//         IconButton(
//           onPressed: _sendMessage,
//           icon: const Icon(
//             Icons.arrow_upward,
//             size: 40,
//           ),
//         )
//       ],
//     );
//   }
// }

  Widget _chatField(_messageController) {
  return Expanded(
    child: Theme(
      data: ThemeData(
    // Set the border color for TextField
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide(color: Colors.black), // Set border color here
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide(color: Colors.black), // Set focused border color here
      ),
    ),
  ),
      child: TextField(
        cursorColor: Colors.black,
        style: TextStyle(
          color: Colors.black,
        ),
        controller: _messageController,
        decoration: InputDecoration(
            
            filled: true,
            fillColor: Colors.transparent,
            ),
            
      ),
    ),
  );
}
}
