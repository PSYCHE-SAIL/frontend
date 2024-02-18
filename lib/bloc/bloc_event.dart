part of 'bloc_bloc.dart';

@immutable
sealed class BlocEvent {}

class ChatGenerateNewTextMessageEvent extends BlocEvent {
  final String inputMessage;
  ChatGenerateNewTextMessageEvent({
    required this.inputMessage,
});
}