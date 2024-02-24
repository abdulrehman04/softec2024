part of '../chat.dart';

class _ChatCard extends StatelessWidget {
  final String lastMessage;
  final AuthData user;
  final String chatId;
  const _ChatCard(
      {required this.chatId, required this.user, required this.lastMessage});

  @override
  Widget build(BuildContext context) {
    // final screenState = _ScreenState.s(context);
    // final chatCubit = ChatCubit.c(context);

    return InkWell(
      // onTap: () => AppRoutes.conversation.push(
      //   context,
      //   arguments: {'user': user},
      // ),
      // onLongPress: () async {
      //   final value = await showModalBottomSheet<bool?>(
      //     context: context,
      //     backgroundColor: Colors.transparent,
      //     builder: (_) => ListenableProvider.value(
      //       value: screenState,
      //       child: const _DeleteModal(),
      //     ),
      //   );

      //   if (value != null && value) {
      //     chatCubit.deleteChat(chatId);
      //   }
      // },
      child: Padding(
        padding: Space.all(),
        child: Row(
          children: [
            // CircleAvatar(
            //   radius: 25,
            //   backgroundImage: NetworkImage(user.photoUrl),
            // ),
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
