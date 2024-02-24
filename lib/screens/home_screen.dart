import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softec_app/router/router.dart';
import 'package:softec_app/screens/video_calling/CallPage.dart';
import 'package:softec_app/screens/video_calling/HomePage.dart';
import 'package:softec_app/screens/video_calling/agora_manager.dart';
import 'package:softec_app/screens/video_calling/quickstart.dart';
import 'package:softec_app/widgets/core/bottom_bar/bottom_bar.dart';
import 'package:softec_app/widgets/design/buttons/app_button.dart';
import 'package:softec_app/widgets/design/input/app_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isBroadcaster = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Method'),
      ),
      bottomNavigationBar: const BottomBar(),
      body: Column(
        children: [
          Switch(
            value: isBroadcaster,
            onChanged: (value) {
              setState(() {
                isBroadcaster = value;
              });
            },
          ),
          AppButton(
            label: 'Tester',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SDKQuickstartScreen(
                    selectedProduct: ProductName.broadcastStreaming,
                    isBroadcaster: true,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
