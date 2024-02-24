part of '../cubit.dart';

@immutable
class SendMessageState extends Equatable {
  static bool match(ChatState a, ChatState b) => a.sendMessage != b.sendMessage;

  final String? error;

  const SendMessageState({
    this.error,
  });

  @override
  List<Object> get props => [];
}

@immutable
class SendMessageDefault extends SendMessageState {
  const SendMessageDefault() : super();
}

@immutable
class SendMessageLoading extends SendMessageState {
  const SendMessageLoading() : super();
}

@immutable
class SendMessageSuccess extends SendMessageState {
  const SendMessageSuccess() : super();
}

@immutable
class SendMessageFailed extends SendMessageState {
  const SendMessageFailed({String? error}) : super(error: error);
}
