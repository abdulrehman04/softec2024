import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softec_app/models/auth_data.dart';
import 'package:softec_app/models/chat/chat_meta.dart';
import 'package:softec_app/models/chat/message.dart';

part 'data_provider.dart';
part 'repository.dart';
part 'state.dart';
part 'states/_fetch_chats.dart';
part 'states/_fetch_messages.dart';
part 'states/_send_message.dart';
part 'states/_delete_chat.dart';

class ChatCubit extends Cubit<ChatState> {
  static ChatCubit c(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<ChatCubit>(context, listen: listen);

  ChatCubit() : super(const ChatDefault());

  final repo = _ChatRepository();

  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> chatstream;

  void closeChatStream() {
    chatstream.cancel();
  }

  void resetChatMessages() {
    emit(
      state.copyWith(
        fetchMessages: const FetchMessagesSuccess(data: []),
      ),
    );
  }

  Future<void> sendMessage(Message msg) async {
    emit(
      state.copyWith(
        sendMessage: const SendMessageLoading(),
      ),
    );
    try {
      await _ChatProvider.sendMessage(msg);
      emit(
        state.copyWith(
          sendMessage: const SendMessageSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          sendMessage: SendMessageFailed(error: e.toString()),
        ),
      );
    }
  }

  void fetchMessages(String senderId, String receiverId) {
    try {
      chatstream = repo.fetchMessages(senderId, receiverId).listen(
        (event) {
          List<Map<String, dynamic>> json =
              event.docs.map((e) => e.data()).toList();
          List<Message> messages = json.map((e) => Message.fromMap(e)).toList();
          emit(
            state.copyWith(
              fetchMessages: FetchMessagesSuccess(data: messages),
            ),
          );
        },
        onError: (e) {
          emit(
            state.copyWith(
              fetchMessages: FetchMessagesFailed(error: e.toString()),
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          fetchMessages: FetchMessagesFailed(error: e.toString()),
        ),
      );
    }
  }

  Future<void> fetchChats(String userId) async {
    emit(
      state.copyWith(
        fetchChats: const FetchChatsLoading(),
      ),
    );
    try {
      final data = await _ChatProvider.fetchChats(userId);
      emit(
        state.copyWith(
          fetchChats: FetchChatsSuccess(data: data),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          fetchChats: FetchChatsFailed(error: e.toString()),
        ),
      );
    }
  }

  Future<void> deleteChat(String chatId) async {
    emit(
      state.copyWith(
        deleteChat: const DeleteChatLoading(),
      ),
    );
    try {
      await _ChatProvider.deleteChat(chatId);
      emit(
        state.copyWith(
          deleteChat: const DeleteChatSuccess(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          deleteChat: DeleteChatFailed(error: e.toString()),
        ),
      );
    }
  }
}
