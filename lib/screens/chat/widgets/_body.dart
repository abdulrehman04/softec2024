part of '../chat.dart';

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    super.initState();
    final authCubit = Provider.of<AuthService>(context, listen: false);
    final chatCubit = ChatCubit.c(context);
    final user = authCubit.authData;
    chatCubit.fetchChats(user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = Provider.of<AuthService>(context);
    final chatCubit = ChatCubit.c(context, true);
    final user = authCubit.authData!;

    final screenState = _ScreenState.s(context, true);

    List<ChatMeta> list = [];

    return SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await chatCubit.fetchChats(user.uid);
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Messages'),
            ),
            body: Padding(
              padding: Space.all(),
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state.fetchChats is FetchChatsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
          
                  if (state.fetchChats is FetchChatsSuccess) {
                    list = screenState.hasSearched
                        ? screenState.filtered
                        : state.fetchChats.data ?? [];
          
                    if (list.isEmpty && !screenState.hasSearched) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Iconsax.messages,
                            size: 15,
                            color: Colors.grey,
                          ),
                          Space.y2!,
                          Padding(
                            padding: Space.all(),
                            child: Text(
                              'To start messaging people who have Hotspot, tap the button below and get started.',
                              style: AppText.b2!.cl(AppTheme.c.primary!),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Space.y2!,
                          AppButton(
                            width: 150,
                            label: 'Get Started',
                            onPressed: () {
                              
                            },
                          ),
                        ],
                      );
                    }
          
                    return Column(
                      children: [
                        AppTextField(
                          name: 'search',
                          prefixIcon: const Icon(
                            Iconsax.search_normal_1,
                          ),
                          hint: 'Search...',
                          onChanged: (query) {
                            if (query != null) {
                              screenState.search(query, list);
                            }
                          },
                        ),
                        Space.y2!,
                        Expanded(
                          child: ListView.builder(
                            padding: Space.z,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final chat = list[index];
          
                              return _ChatCard(
                                chatId: chat.chatId,
                                user: chat.receiver,
                                lastMessage: chat.lastMessage,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
          
                  return Center(
                    child: Text(
                      "Looks Like an error occured, please try again later",
                      style: AppText.b2!.cl(AppTheme.c.primary!),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
  }
}
