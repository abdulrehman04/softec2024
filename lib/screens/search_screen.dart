import 'package:flutter/material.dart';
import 'package:softec_app/widgets/core/bottom_bar/bottom_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Method'),
      ),
      bottomNavigationBar: const BottomBar(),
      body: const Center(
        child: Text('Search Screen'),
      ),
    );
  }
}
