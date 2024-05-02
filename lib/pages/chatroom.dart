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
  // final ChatService _chatService = ChatService();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  var  receiveremail ;
  var  receiverid ;
  var  currentid ;

  void _sendMessage() async{
    if(_messageController.text.isNotEmpty){
      await sendmessage(receiverid, _messageController.text,currentid);
       updateChat(receiverid, currentid, _messageController.text);
    
      _messageController.clear();
    }
     

  }
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
final size = MediaQuery.of(context).size;
    // Access individual parameters
     receiveremail =  args?['receiveremail'] ?? '';
     receiverid = args?['receiverid'] ?? '';
     currentid = args?['currentid'] ?? '';
 print(receiverid);
 print(receiveremail);
 print(currentid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        titleTextStyle: TextStyle(color: Colors.black, fontSize:20),
        title: Text(receiverid),
        actions: [
          Padding(padding: EdgeInsets.only(right: size.width/50),
          child :
          IconButton(onPressed: () { Navigator.pushNamed(context, '/video',
  arguments: {'currentid': currentid, 'senderid' : receiverid}
                      );}, icon: Icon(Icons.call), color: Colors.black))
        ],
      ),
      body: Container (
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      child :Column(
        children: [
          // messages
          Expanded(
            child: _buildMessageList(receiverid,currentid),
          ),
          _buildMessageInput(),
        ],
      ),
    )
    );
  }
// build message list
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
  // build message item
  Widget  _buildMessageItem(DocumentSnapshot document,currentid) {
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
  // build message input
  Widget _buildMessageInput() {
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
        IconButton(onPressed: _sendMessage, icon:const Icon(Icons.arrow_upward, size: 40,),)
      ],
    );
  }


  // GET MESSAGES
  
}