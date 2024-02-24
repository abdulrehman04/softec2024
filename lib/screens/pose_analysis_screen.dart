import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/providers/analytics_provider.dart';

class PoseAnalysisScreen extends StatelessWidget {
  const PoseAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final analyticsProvider = Provider.of<AnalyticsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pose Analysis'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          analyticsProvider.pickImage();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const Text('Pose Analysis'),
          if (analyticsProvider.image != null)
            Image.file(
              File(analyticsProvider.image!.path),
            ),
        ],
      ),
    );
  }
}
