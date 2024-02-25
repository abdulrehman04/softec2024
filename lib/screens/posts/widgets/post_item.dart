import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: image == ''
              ? const Icon(Icons.person)
              : CircleAvatar(
                  backgroundImage: NetworkImage(image),
                ),
          title: Text(name),
        ),
        title != ''
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
              )
            : SizedBox(
                height: 10.h,
              ),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: Image.network(
            post,
            fit: BoxFit.cover,
          ),
        ),
        15.verticalSpace,
      ],
    );
  }
}
