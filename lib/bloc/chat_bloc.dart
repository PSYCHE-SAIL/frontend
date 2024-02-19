import 'dart:async';

import 'package:bloc/bloc.dart';
// import 'package:psychesail/bloc/chat_event.dart';
import 'package:psychesail/bloc/chat_state.dart';
// import 'package:psychesail/bloc/chat_event.dart';
// import 'package:psychesail/bloc/chat_event.dart';
import 'package:psychesail/model/botchatmessagemodel.dart';
import 'package:meta/meta.dart';
import 'package:psychesail/repo/chatrepo.dart';
part 'chat_event.dart';
// part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccessState(messages: [])) {
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent) {}
  }

  List<BotChatMessageModel> messages = [];

  FutureOr<dynamic> chatGenerateNewTextMessageEvent(
      ChatGenerateNewTextMessageEvent event) async {
    messages.add(BotChatMessageModel(
        role: "user", parts: [ChatPartModel(text: event.inputMessage)]));
    String generatedText  = await ChatRepo.chatTextGenerationRepo(messages);
    if(generatedText.length>0) {
      messages.add(BotChatMessageModel(role: 'model', parts: [ChatPartModel(text: generatedText)]));
    }
    return (messages);

  }
}
// ignore: invalid_use_of_visible_for_testing_member