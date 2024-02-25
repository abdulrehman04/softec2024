import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/screens/profile/profileState.dart';

class ProfileReviews extends StatelessWidget {
  const ProfileReviews({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileState controller = Provider.of<ProfileState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews and ratings'),
      ),
      body: (controller.userData.ratings ?? []).isEmpty
          ? const Center(
              child: Text('No ratings yet'),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: (controller.userData.ratings ?? []).map((e) {
                    return Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 2,
                          color: Colors.grey[900]!,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(
                              e.name,
                              style: AppText.h3b,
                            ),
                            trailing: SizedBox(
                              width: 50,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    e.rating.toString(),
                                    style: AppText.h2,
                                  ),
                                  5.horizontalSpace,
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow[800],
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              e.review,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          10.verticalSpace,
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
    );
  }
}
