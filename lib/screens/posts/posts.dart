import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/models/auth_data.dart';
import 'package:softec_app/models/post_model.dart';
import 'package:softec_app/repositories/posts_repo.dart';
import 'package:softec_app/router/router.dart';
import 'package:softec_app/screens/chat/chat.dart';
import 'package:softec_app/screens/pose_analysis_screen.dart';
import 'package:softec_app/screens/posts/create_post/create_post.dart';
import 'package:softec_app/screens/posts/widgets/post_item.dart';
import 'package:softec_app/screens/video_calling/agora_manager.dart';
import 'package:softec_app/screens/video_calling/livestreaming.dart';
import 'package:softec_app/services/auth.dart';
import 'package:softec_app/services/image_picker.dart';
import 'package:softec_app/widgets/core/bottom_bar/bottom_bar.dart';
import 'package:softec_app/widgets/core/snackbar/custom_snackbar.dart';

part 'widgets/_body.dart';
part '_state.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  void initState() {
    super.initState();
    PostState controller = Provider.of<PostState>(context, listen: false);
    if (controller.posts.isEmpty) {
      controller.fetchAllPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const _Body();
  }
}
