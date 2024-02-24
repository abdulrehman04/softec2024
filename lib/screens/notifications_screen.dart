import 'package:flutter/material.dart';
import 'package:softec_app/widgets/core/bottom_bar/bottom_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
            bottomNavigationBar: const BottomBar(),
      body: const Center(
        child: Text('Notifications Screen'),
      ),
    );
  }
}