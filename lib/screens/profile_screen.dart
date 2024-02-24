import 'package:flutter/material.dart';
import 'package:softec_app/widgets/core/bottom_bar/bottom_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
            bottomNavigationBar: const BottomBar(),
      body: const Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}