import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdscsol/bloc/bloc_bloc.dart';
import 'package:gdscsol/components/chat_service.dart';
import 'package:gdscsol/model/botchatmessagemodel.dart';
import 'package:gdscsol/model/textfield.dart';

import 'components/crud.dart';
import 'components/text.dart';
import 'model/message.dart';

class MonkeyBotChatRoom extends StatefulWidget {
  const MonkeyBotChatRoom({
    super.key,
  });

  @override
  State<MonkeyBotChatRoom> createState() => _MonkeyBotChatRoomState();
}

class _MonkeyBotChatRoomState extends State<MonkeyBotChatRoom> {
  final TextEditingController _messageController = TextEditingController();
  final BlocBloc chatbloc = BlocBloc();

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var receiveremail;
  var receiverid;
  var currentid;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final size = MediaQuery.of(context).size;

    // Access individual parameters
    receiveremail = args?['receiveremail'] ?? '';
    receiverid = "monkeybot";
    currentid = args?['currentid'] ?? '';
    print(receiverid);
    print(receiveremail);
    print(currentid);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
          title: Text(receiverid),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: size.width / 50),
                child: IconButton(
                    onPressed: () {
                      print("Pressed call button");
                    },
                    icon: Icon(Icons.call),
                    color: Colors.black))
          ],
        ),
        body: BlocConsumer<BlocBloc, BlocState>(
            bloc: chatbloc,
            listener: (context, state) {},
            builder: (context, state) {
              List<BotChatMessageModel> messages =
                  chatbloc.messages;
              switch (messages.isNotEmpty) {
                case true:
                  return Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color:(currentid=='monkeybot')? Colors.grey:Color.fromRGBO(32, 160, 144, 100),
                                    ),
                                    child:
                                        Text(style: TextStyle(color:(currentid=='monkeybot')? Colors.black:Colors.white, fontSize: 17),
                                            messages[index].parts.first.text),

                                );
                              }),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          height: 120,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                    controller: _messageController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                              )),
                              const SizedBox(
                                width: 12,
                              ),
                              InkWell(
                                onTap: () async{
                                  if(_messageController.text.isNotEmpty) {
                                    print(_messageController.text);
                                    print( ChatGenerateNewTextMessageEvent(inputMessage: _messageController.text));
                                    print(await chatbloc.chatGenerateNewTextMessageEvent(ChatGenerateNewTextMessageEvent(inputMessage: _messageController.text)));

                                  }
                                },
                                child : CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.black,
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),)
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                default:
                  return Column(
              children: [
                Expanded(child: Container(
                  color: Colors.white,
                ), ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    height: 120,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(100),
                                      borderSide:
                                      BorderSide(color: Colors.black))),
                            )),
                        const SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: () async{
                            if(_messageController.text.isNotEmpty) {
                              print(_messageController.text);
                              print( ChatGenerateNewTextMessageEvent(inputMessage: _messageController.text));
                              print(await chatbloc.chatGenerateNewTextMessageEvent(ChatGenerateNewTextMessageEvent(inputMessage: _messageController.text)));
// print(chatbloc.messages.length);
                              _messageController.clear();
                            }
                          },
                          child : CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),)
                      ],
                    ),
                  )
                  ]);
              }
            }));

    // }
    //     )
    // );
  }

// build message list
//   Widget _buildMessageList(){
//     return StreamBuilder(stream: getmessages(receiverid,currentid), builder: (context,snapshot){
//       if(snapshot.hasError){
//         return Text('Error${snapshot.error}');
//       }
//       if(snapshot.connectionState == ConnectionState.waiting){
//         return const Text('Loading...');
//       }
//       return ListView(
//         children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
//       );
//     });
//   }
//   // build message item
//   Widget  _buildMessageItem(DocumentSnapshot document) {
//     Map<String, dynamic> data = document.data() as Map<String, dynamic>;
//     // align sender messages => left ; receiver messages => right
//
//     var alignment = (data['senderid'] == currentid)
//         ? Alignment.centerRight
//         : Alignment.centerLeft;
//     var bgcolor = (data['senderid'] == currentid) ? Color.fromRGBO(
//         32, 160, 144, 100) : Color.fromRGBO(121, 124, 123, 100);
//     return LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints)
//         {
//           bool constr = false;
//           if (constraints.maxWidth > 600) constr = true;
//           return Container(
//             alignment: alignment,
//             child: Column(
//               crossAxisAlignment:
//               (data['senderid'] == currentid)
//                   ? CrossAxisAlignment.end
//                   : CrossAxisAlignment.start,
//               mainAxisAlignment: (data['senderid'] == currentid)
//                   ? MainAxisAlignment.end
//                   : MainAxisAlignment.start,
//               children: [
//                 // Text(data['senderid'],style: const TextStyle(backgroundColor: Colors.transparent,color: Colors.black,fontSize: 15,),),
//                 textbubble(data['message'], '${data['timestamp']
//                     .toDate()
//                     .toLocal()
//                     .hour}:' + '${data['timestamp']
//                     .toDate()
//                     .toLocal()
//                     .minute
//                     .toString()
//                     .padLeft(2, '0')}', data['senderid'], currentid, bgcolor,constr, context),
//               ],
//             ),
//           );
//
//         }
//     );
//   }
//   // build message input
  Widget _buildMessageInput(messages) {
    return Row(
      children: [
        //textfield
        Expanded(
          child: MyTextField(
            controller: _messageController,
            hinttext: 'Enter message...',
            obscureText: false,
          ),
        ),

        // send button
        InkWell(
            onTap: () async {
              print(ChatSuccessState(messages: messages).toString());
              if (_messageController.text.isNotEmpty) {
                chatbloc.add(ChatGenerateNewTextMessageEvent(
                    inputMessage: _messageController.text));

                _messageController.clear();
              }
            },
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.send,
                color: Colors.black,
              ),
            ))
      ],
    );
  }
}
//   Future<void> sendmessage(String receiverId, String message) async {
//     // get user info
//     var snap = await getData(currentid);
//     print(snap['email']);
//     print(receiverid);
//     print(receiveremail);
//     print(currentid);
//     final String currentUserId = currentid;
//     final String currentEmailId = snap['email'];
//     final timestamp = Timestamp.now();
//
//     // create a new message
//     Message newMessage = Message(
//       senderEmail: currentEmailId,
//       senderid: currentUserId,
//       receiverid: receiverid,
//       message: message,
//       timestamp: timestamp,
//     );
//     //construct chatroom id for current user id and sender id (sorted to ensure uniqueness)
//     List<String> ids = [currentUserId, receiverId];
//     ids.sort();
//     String chatroomId = ids.join("_");
//
//     //add new message to database
//     await _firestore
//         .collection('chat_rooms')
//         .doc(chatroomId)
//         .collection('messages')
//         .add(newMessage.toMap());
//   }
// //
// //   // GET MESSAGES
// //   Stream<QuerySnapshot> getmessages(String userId, String otheruserId) {
// //     List<String> ids= [userId, otheruserId];
// //     ids.sort();
// //     String chatroomid =  ids.join("_");
// //     return _firestore.collection('chat_rooms').doc(chatroomid).collection('messages').orderBy('timestamp', descending: false).snapshots();
// //   }
// }
