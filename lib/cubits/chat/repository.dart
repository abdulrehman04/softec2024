part of 'cubit.dart';

class _ChatRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchMessages(
      String userId, String receiverId) {
    try {
      final payload = {'senderId': userId, 'receiverId': receiverId};
      return _ChatProvider.fetchMessages(payload);
    } catch (e) {
      rethrow;
    }
  }
}
