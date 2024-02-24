part of '../cubit.dart';

class FetchChatsState extends Equatable {

  static bool match(ChatState a, ChatState b) => a.fetchChats != b.fetchChats;

  final List<ChatMeta>? data;
  final String? error;
  
  const FetchChatsState({
    this.data,
    this.error,
  });

  @override
  List<Object?> get props => [data, error];
}

class FetchChatsDefault extends FetchChatsState {
  const FetchChatsDefault() : super();
}

class FetchChatsLoading extends FetchChatsState {
  const FetchChatsLoading() : super();
}

class FetchChatsSuccess extends FetchChatsState {
  const FetchChatsSuccess({List<ChatMeta>? data}) : super(data: data);
}

class FetchChatsFailed extends FetchChatsState {
  const FetchChatsFailed({String? error}) : super(error: error);
}