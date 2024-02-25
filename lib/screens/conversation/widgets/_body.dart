part of '../conversation.dart';

class _Body extends StatefulWidget {
  final AuthData receiver;
  const _Body({required this.receiver});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    super.initState();
    final chatCubit = ChatCubit.c(context);
    final authCubit = Provider.of<AuthService>(context, listen: false);
    final sender = authCubit.authData!;

    chatCubit.fetchMessages(sender.uid, widget.receiver.uid);
    chatCubit.fetchChats(sender.uid);
  }

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);
    final chatCubit = ChatCubit.c(context, true);
    final authCubit = Provider.of<AuthService>(context);
    final sender = authCubit.authData!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.receiver.fullname),
        ),
        body: Padding(
          padding: Space.all(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Space.y2!,
              BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state.fetchMessages is FetchMessagesLoading) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state.fetchMessages is FetchMessagesSuccess) {
                    final messages = state.fetchMessages.data!;
                    return messages.isEmpty
                        ? Expanded(
                            child: Center(
                              child: Text(
                                'No messages yet, write one now!',
                                style: AppText.b2,
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              reverse: true,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                return _Bubble(
                                  isUser: message.from == sender.uid,
                                  message: message,
                                );
                              },
                            ),
                          );
                  } else {
                    return const Expanded(
                      child: Center(
                        child: Text('Failed to load messages'),
                      ),
                    );
                  }
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: FormBuilder(
                      key: screenState.formKey,
                      child: const AppTextField(
                        name: _FormKeys.message,
                        hint: 'Write a message....',
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                  ),
                  Space.x2!,
                  IconButton(
                      onPressed: () {
                        final form = screenState.formKey.currentState!;
                        form.save();
                        final value = form.value;
                        final msg = value[_FormKeys.message] as String?;

                        if (msg == null || msg.isEmpty) return;
                        final message = Message(
                          to: widget.receiver.uid,
                          from: sender.uid,
                          content: msg,
                          createdAt: DateTime.now(),
                        );

                        chatCubit.sendMessage(message);

                        NotificationBase().sendPushMessage(
                          widget.receiver.uid,
                          widget.receiver.deviceToken ?? '',
                          '${sender.fullname} sent you a message!',
                          msg,
                        );

                        screenState.resetForm();
                      },
                      icon: const Icon(Icons.telegram))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
