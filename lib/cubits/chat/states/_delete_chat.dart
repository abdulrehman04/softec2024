part of '../cubit.dart';

class DeleteChatState extends Equatable {
  static bool match(ChatState a, ChatState b) => a.deleteChat != b.deleteChat;

  final String? error;
  
  const DeleteChatState({
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

class DeleteChatDefault extends DeleteChatState {
  const DeleteChatDefault() : super();
}

class DeleteChatLoading extends DeleteChatState {
  const DeleteChatLoading() : super();
}

class DeleteChatSuccess extends DeleteChatState {
  const DeleteChatSuccess();
}

class DeleteChatFailed extends DeleteChatState {
  const DeleteChatFailed({String? error}) : super(error: error);
}