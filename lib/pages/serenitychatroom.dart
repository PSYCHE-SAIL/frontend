import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class SerenityChat extends StatefulWidget {
  const SerenityChat({super.key});

  @override
  State<SerenityChat> createState() => _SerenityChatState();
}

class _SerenityChatState extends State<SerenityChat> {
  // importing gemini
  final Gemini gemini = Gemini.instance;
  // USERS
  var currentid = '';
  ChatUser currentUser = ChatUser(id: '0');
  ChatUser serenity = ChatUser(id: 'Serenity');

  // MESSAGES
  List<ChatMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    currentid = args?['currentid'] ?? '';
    currentUser = ChatUser(id: currentid, firstName: currentid);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Serenity"),
      ),
      body: _buildUI(),
    );
  }
  Widget _buildUI() {
    return DashChat(currentUser: currentUser, onSend: _sendMessage, messages: messages);
  }
  void _sendMessage(ChatMessage chatMessage) {
setState(() {
  messages = [chatMessage, ...messages];
});
try{
String userInput = chatMessage.text;
gemini.streamGenerateContent(userInput).listen((event){
ChatMessage? lastMessage = messages.firstOrNull;
if(lastMessage != null && lastMessage.user == serenity){
  lastMessage = messages.removeAt(0);
  String response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}") ?? "";
  lastMessage.text += response;

  setState(() {
    messages = [lastMessage!, ...messages];
  });
}else {
  String response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}") ?? "";
  ChatMessage message = ChatMessage(user: serenity, createdAt: DateTime.now(), text: response );
  setState(() {
    messages = [message, ...messages];
  });
}
  });

}
catch(e) {
  print(e);
}
  }
}


