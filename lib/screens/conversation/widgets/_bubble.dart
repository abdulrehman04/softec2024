part of '../conversation.dart';

class _Bubble extends StatelessWidget {
  final Message message;
  final bool isUser;
  const _Bubble({
    required this.isUser,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: 120.w,
          ),
          margin: Space.all(),
          padding: Space.all(),
          decoration: BoxDecoration(
            color: isUser ? AppTheme.c.primary : Colors.grey[400],
            borderRadius: isUser
                ? const BorderRadius.only(
                    topRight: Radius.circular(6),
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(6),
                    topLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message.content,
                style: AppText.b2!.cl(isUser ? Colors.white : Colors.black),
              ),
              Space.y2!,
              Text(
                DateFormat('hh:mm:aa').format(message.createdAt),
                style: AppText.l1!
                    .cl(isUser ? Colors.white.withAlpha(150) : Colors.grey),
              )
            ],
          ),
        ),
      ],
    );
  }
}
