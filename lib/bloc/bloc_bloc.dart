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
List<BotChatMessageModel> messages = [] ;
FutureOr<void> chatGenerateNewTextMessageEvent(ChatGenerateNewTextMessageEvent event, Emitter<BlocState> emit)async{
      messages.add(BotChatMessageModel(role: "user", parts: [ChatPartModel(text: event.inputMessage)]));
      emit(ChatSuccessState(messages: messages));
      await ChatRepo.chatTextGenerationRepo(messages);
};
// ignore: invalid_use_of_visible_for_testing_member

  }
}
