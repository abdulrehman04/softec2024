part of '../chat.dart';

class _DeleteChatListener extends StatelessWidget {
  const _DeleteChatListener();

  @override
  Widget build(BuildContext context) {
    final chatCubit = ChatCubit.c(context);
    final authService = Provider.of<AuthService>(context);
    final user = authService.authData;

    return BlocConsumer<ChatCubit, ChatState>(
      listenWhen: DeleteChatState.match,
      listener: (context, state) {
        if (state.deleteChat is DeleteChatFailed) {
          final message = state.deleteChat.error!;
          SnackBars.failure(context, message);
        } else if (state.deleteChat is DeleteChatSuccess) {
          chatCubit.fetchChats(user!.uid);
          SnackBars.success(context, 'Chat has been deleted successfully!');
        }
      },
      builder: (context, state) {
        final loading = state.deleteChat is DeleteChatLoading;
        if (loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
