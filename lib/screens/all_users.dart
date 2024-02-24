import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/router/router.dart';
import 'package:softec_app/screens/conversation/conversation.dart';
import 'package:softec_app/services/auth.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthService>(context, listen: false);
    authProvider.fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Find Users'),
        ),
        body: authService.allUsers == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: authService.allUsers!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(authService.allUsers![index].fullname),
                    subtitle: Text(authService.allUsers![index].email),
                    onTap: () {
                      AppRouter.push(
                        context,
                        ConversationScreen(
                          receiver: authService.allUsers![index],
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
