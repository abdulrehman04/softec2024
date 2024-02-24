part of 'cubit.dart';

class _ChatProvider {
  static final _firestore = FirebaseFirestore.instance;
  static const _chatCollection = 'chats';
  static const _userCollection = 'users';

  static Future<void> sendMessage(Message message) async {
    try {
      List<String> ids = [message.to, message.from];
      ids.sort();

      final chatId = ids.join('_');

      _firestore.collection(_chatCollection).doc(chatId).set({
        'lastMessage': message.content,
        'id1': ids[0],
        'id2': ids[1],
      }, SetOptions(merge: true));

      await _firestore
          .collection(_chatCollection)
          .doc(chatId)
          .collection('messages')
          .add(message.toMap());
    } catch (e) {
      debugPrint("------ Exception in ChatCubit ------");
      debugPrint(e.toString());
      throw Exception("Something went wrong while sending the message.");
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchMessages(
      Map<String, dynamic> payload) {
    try {
      final senderId = payload['senderId'] as String;
      final receiverId = payload['receiverId'] as String;

      List<String> ids = [senderId, receiverId];
      ids.sort();
      final chatId = ids.join('_');

      return _firestore
          .collection(_chatCollection)
          .doc(chatId)
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .asBroadcastStream();
    } catch (e) {
      debugPrint("------ Exception in ChatCubit ------");
      debugPrint(e.toString());
      throw Exception("Something went wrong while fetching the chats.");
    }
  }

  static Future<List<ChatMeta>> fetchChats(String userId) async {
    try {
      final chats = await _firestore
          .collection(_chatCollection)
          .where('id1', isEqualTo: userId)
          .get();

      final chats2 = await _firestore
          .collection(_chatCollection)
          .where('id2', isEqualTo: userId)
          .get();

      final allChats = [...chats.docs, ...chats2.docs];

      final List<Map<String, dynamic>> json =
          allChats.map((e) => e.data()).toList();
      for (var i = 0; i < json.length; i++) {
        final chat = json[i];

        /// Getting receiver as an object, bcz any user can be receiver.
        /// Check if the current user is the receiver or the sender, and then fetch the IDs
        /// accordingly
        final receiverUid = chat['id1'] == userId ? chat['id2'] : chat['id1'];
        final receiver = await _getReceiver(receiverUid);

        json[i]['receiver'] = receiver;

        final ids = [userId, receiverUid];

        /// Sorting the IDs because when the chat sessions are created IDs are sorted at that time
        /// as well, so to keep the sync
        ids.sort();

        final chatId = ids.join('_');
        json[i]['chatId'] = chatId;
      }

      final chatsMeta = json.map((e) => ChatMeta.fromMap(e)).toList();
      return chatsMeta;
    } catch (e) {
      debugPrint("------ Exception in ChatCubit ------");
      debugPrint(e.toString());
      throw Exception("Something went wrong while fetching the chats.");
    }
  }

  static Future<AuthData?> _getReceiver(String uid) async {
    try {
      final receiver =
          await _firestore.collection(_userCollection).doc(uid).get();

      final raw = receiver.data();
      final user = AuthData.fromMap(raw!);
      return user;
    } catch (e) {
      debugPrint("------ Exception in ChatCubit ------");
      debugPrint(e.toString());
      throw Exception("Something went wrong while fetching the chats.");
    }
  }

  static Future<void> deleteChat(String chatId) async {
    try {
      final ref = _firestore.collection(_chatCollection);
      await ref.doc(chatId).delete();
    } catch (e) {
      debugPrint("------ Exception in ChatCubit ------");
      debugPrint(e.toString());
      throw Exception("Can't delete chat");
    }
  }
}
