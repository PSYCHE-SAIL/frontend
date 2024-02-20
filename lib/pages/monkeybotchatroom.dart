import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psychesail/bloc/chat_bloc.dart';
import 'package:psychesail/bloc/chat_state.dart';
import 'package:psychesail/model/botchatmessagemodel.dart';
import 'package:psychesail/model/textField.dart';

import 'package:psychesail/components/crud.dart';
import 'package:psychesail/components/text.dart';
import 'package:psychesail/model/message.dart';

class MonkeyBotChatRoom extends StatefulWidget {
  const MonkeyBotChatRoom({
    super.key,
  });

  @override
  State<MonkeyBotChatRoom> createState() => _MonkeyBotChatRoomState();
}

class _MonkeyBotChatRoomState extends State<MonkeyBotChatRoom> {
  final TextEditingController _messageController = TextEditingController();
  final ChatBloc chatbloc = ChatBloc();

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var lastmessage;
  var receiverid;
    bool endchat = false;
  var currentid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    endchat = false;

  }
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final size = MediaQuery.of(context).size;
 double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    // Access individual parameters
    lastmessage = args?['lastmessage'] ?? '';
    receiverid = 'Serenity';
    currentid = args?['currentid'] ?? '';
    print(receiverid);
    print(lastmessage);
    print(currentid);
  
    dynamic sendMessage(messages) async{
    if(_messageController.text.isNotEmpty){
      await sendmessage(receiverid, _messageController.text,currentid);
       updateChat(currentid, receiverid, messages[messages.length - 1].parts.first.text);
    
      _messageController.clear();
      return;
    }
    return;
    }
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
        body: BlocConsumer<ChatBloc, ChatState>(
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
                                return !(index%8 == 7) ? Container(
                                  margin: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color:(messages[index].role == "user")? Color.fromRGBO(32, 160, 144, 100) :Colors.grey,
                                    ),
                                    child:
                                        Text(style: TextStyle(color:(messages[index].role == "user")? Colors.white:Colors.black, fontSize: 17),
                                            messages[index].parts.first.text),
                                ) : Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                                        padding: const EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color:(messages[index].role == "user")? Color.fromRGBO(32, 160, 144, 100) :Colors.grey,
                                        ),
                                        child:
                                            Text(style: TextStyle(color:(messages[index].role == "user")? Colors.white:Colors.black, fontSize: 17),
                                                messages[index].parts.first.text),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                      InkWell(
                                        onTap: ()=>{
                                          setState(() {
                                            endchat = true;
                                          }),
                                        },
                                        child: Container(
                                          width: sizeWidth/3,
                                          height: sizeHeight/25,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: Colors.grey,
                                          ),
                                          child: Center(child: Text("End chat")),
                                        ),
                                      ),
                                      Container(
                                        width: sizeWidth/3,
                                        height: sizeHeight/25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.grey,
                                        ),
                                        child: Center(child: Text("Suggest Places")),
                                      )
                                    ],)
                                  ],
                                );
                                
                              }),
                        ),
                        if(endchat)Container(
                           margin: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      
                                    ),
                          child: Center(child: Text("I hope i was hopefull in making this situation better for you.\nCome back whenever you need help.\nHave a great day.",
                          style: TextStyle(
                            color: Colors.black
                          ),
                          textAlign: TextAlign.center,
                          ))),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          height: 120,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                    style: TextStyle(color: Colors.black),
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
                              !endchat ? InkWell(
                                onTap: () async{
                                  if(_messageController.text.isNotEmpty) {
                                    print(_messageController.text);
                                    print( ChatGenerateNewTextMessageEvent(inputMessage: _messageController.text));
                                    print(await chatbloc.chatGenerateNewTextMessageEvent(ChatGenerateNewTextMessageEvent(inputMessage: _messageController.text)));
                                    await sendMessage(messages);
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
                              ),) : CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.black,
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                                                            )
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
        await sendMessage(messages);
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

Widget _buildMessageList(receiverid,currentid){
    return StreamBuilder(stream: getmessages(receiverid,currentid), builder: (context,snapshot){
      if(snapshot.hasError){
        return Text('Error${snapshot.error}');
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Text('Loading...');
      }
      return ListView(
        children: snapshot.data!.docs.map((document) => _buildMessageItem(document,currentid)).toList(),
      );
    });
  }

  Widget  _buildMessageItem(DocumentSnapshot document, currentid) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    // align sender messages => left ; receiver messages => right

    var alignment = (data['senderid'] == currentid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    var bgcolor = (data['senderid'] == currentid) ? Color.fromRGBO(
        32, 160, 144, 100) : Color.fromRGBO(121, 124, 123, 100);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints)
    {
      bool constr = false;
      if (constraints.maxWidth > 600) constr = true;
      return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
          (data['senderid'] == currentid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderid'] == currentid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            // Text(data['senderid'],style: const TextStyle(backgroundColor: Colors.transparent,color: Colors.black,fontSize: 15,),),
            textbubble(data['message'], '${data['timestamp']
                .toDate()
                .toLocal()
                .hour}:' + '${data['timestamp']
                .toDate()
                .toLocal()
                .minute
                .toString()
                .padLeft(2, '0')}', data['senderid'], currentid, bgcolor,constr, context),
          ],
        ),
      );

    }
    );
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