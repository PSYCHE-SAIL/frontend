import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gdscsol/model/botchatmessagemodel.dart';
import 'package:meta/meta.dart';
import 'package:gdscsol/repo/chatrepo.dart';
part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  BlocBloc() : super(ChatSuccessState(messages: [])) {
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
