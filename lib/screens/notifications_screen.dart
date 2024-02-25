import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/services/notifications/service.dart';
import 'package:softec_app/widgets/core/bottom_bar/bottom_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notiP = Provider.of<NotiService>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      bottomNavigationBar: const BottomBar(),
      body: notiP.isSavingNoti
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemCount: notiP.allNoti.length,
                itemBuilder: (context, index) {
                  final noti = notiP.allNoti[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(noti.title, style: AppText.h2b),
                      subtitle: Text(noti.body, style: AppText.b2),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
              ),
            ),
    );
  }
}
