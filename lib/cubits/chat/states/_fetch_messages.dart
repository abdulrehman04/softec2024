part of '../cubit.dart';

class FetchMessagesState extends Equatable {

  static bool match(ChatState a, ChatState b) => a.fetchMessages != b.fetchMessages;

  final List<Message>? data;
  final String? error;
  
  const FetchMessagesState({
    this.data,
    this.error,
  });

  @override
  List<Object?> get props => [data, error];
}

class FetchMessagesDefault extends FetchMessagesState {
  const FetchMessagesDefault() : super();
}

class FetchMessagesLoading extends FetchMessagesState {
  const FetchMessagesLoading() : super();
}

class FetchMessagesSuccess extends FetchMessagesState {
  const FetchMessagesSuccess({List<Message>? data}) : super(data: data);
}

class FetchMessagesFailed extends FetchMessagesState {
  const FetchMessagesFailed({String? error}) : super(error: error);
}
