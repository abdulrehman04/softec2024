import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    this.image = '',
    required this.name,
    required this.post,
    required this.title,
  });

  final String name, image, post, title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(name),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Text(title),
        ),
        Image.network(post)
      ],
    );
  }
}
