part of 'cubit.dart';

class ChatState extends Equatable {
  final SendMessageState sendMessage;
  final FetchMessagesState fetchMessages;
  final FetchChatsState fetchChats;
  final DeleteChatState deleteChat;

  const ChatState({
    required this.sendMessage,
    required this.fetchMessages,
    required this.fetchChats,
    required this.deleteChat,
  });

  @override
  List<Object> get props => [
        sendMessage,
        fetchMessages,
        fetchChats,
        deleteChat,
      ];

  ChatState copyWith({
    SendMessageState? sendMessage,
    FetchMessagesState? fetchMessages,
    FetchChatsState? fetchChats,
    DeleteChatState? deleteChat,
  }) {
    return ChatState(
      sendMessage: sendMessage ?? this.sendMessage,
      fetchMessages: fetchMessages ?? this.fetchMessages,
      fetchChats: fetchChats ?? this.fetchChats,
      deleteChat: deleteChat ?? this.deleteChat,
    );
  }
}

class ChatDefault extends ChatState {
  const ChatDefault()
      : super(
          sendMessage: const SendMessageDefault(),
          fetchMessages: const FetchMessagesDefault(),
          fetchChats: const FetchChatsDefault(),
          deleteChat: const DeleteChatDefault(),
        );
}
