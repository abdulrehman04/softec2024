import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/router/router.dart';
import 'package:softec_app/screens/chats.dart';
import 'package:softec_app/screens/posts/widgets/post_item.dart';
import 'package:softec_app/widgets/core/bottom_bar/bottom_bar.dart';

part '_state.dart';

class Posts extends StatelessWidget {
  const Posts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Method'),
        actions: [
          IconButton(
            onPressed: () {
              AppRouter.push(context, const ChatsScreen());
            },
            icon: const Icon(Icons.telegram),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.chat,
          size: 30,
          color: AppTheme.c.primary,
        ),
      ),
      bottomNavigationBar: const BottomBar(),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const PostItem(
            name: 'Shafeqqq',
            post:
                'https://www.hellolittlebirdiestore.com.au/cdn/shop/files/mushie-fabric-dummy-clip-blush-hello-little-birdie-2.jpg?v=1687173428',
            title:
                'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.',
          );
        },
      ),
    );
  }
}
