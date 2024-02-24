part of '../chat.dart';

class _ChatCard extends StatelessWidget {
  final String lastMessage;
  final AuthData user;
  final String chatId;
  const _ChatCard(
      {required this.chatId, required this.user, required this.lastMessage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRouter.push(context, ConversationScreen(receiver: user));
      },
      child: Padding(
        padding: Space.all(),
        child: Row(
          children: [
            Space.x2!,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullname,
                    style: AppText.b2b,
                  ),
                  Space.y2!,
                  Text(
                    lastMessage,
                    style: AppText.l1!.copyWith(color: AppTheme.c.grey, overflow: TextOverflow.ellipsis),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
