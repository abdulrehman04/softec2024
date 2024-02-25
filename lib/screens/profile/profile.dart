import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/router/router.dart';
import 'package:softec_app/screens/login/login.dart';
import 'package:softec_app/screens/profile/profileState.dart';
import 'package:softec_app/screens/profile/profile_reviews.dart';
import 'package:softec_app/screens/profile/report_a_problem.dart';
import 'package:softec_app/screens/profile/widgets/usertype_row.dart';
import 'package:softec_app/services/auth.dart';
import 'package:softec_app/widgets/core/bottom_bar/bottom_bar.dart';
import 'package:softec_app/widgets/design/buttons/app_button.dart';
import 'package:softec_app/widgets/design/input/app_text_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileState controller = Provider.of<ProfileState>(context);
    controller.init(context, Provider.of<AuthService>(context).authData!);
    final authP = Provider.of<AuthService>(context, listen: true);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
              authP.logout();
              authP.reset();
              controller.reset();
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      bottomNavigationBar: const BottomBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FormBuilder(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              width: 100.w,
                              height: 100.h,
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.updateProfilePicture(context);
                                    },
                                    child:
                                        controller.userData.profilePicture == ''
                                            ? Container(
                                                height: 80.h,
                                                width: 80.w,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey[900],
                                                ),
                                                child: const Icon(
                                                  Icons.person,
                                                  size: 50,
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: 70,
                                                backgroundImage: NetworkImage(
                                                  controller
                                                      .userData.profilePicture,
                                                ),
                                              ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: controller.isLoading
                                        ? const CircularProgressIndicator()
                                        : Container(),
                                  ),
                                  controller.userData.postCount > 10
                                      ? Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  String badge = controller
                                                                  .userData
                                                                  .postCount >
                                                              10 &&
                                                          controller.userData
                                                                  .postCount <
                                                              150
                                                      ? 'Bronze'
                                                      : controller.userData
                                                                      .postCount >
                                                                  150 &&
                                                              controller
                                                                      .userData
                                                                      .postCount <
                                                                  500
                                                          ? 'Silver'
                                                          : 'Gold';

                                                  Color color = controller
                                                                  .userData
                                                                  .postCount >
                                                              10 &&
                                                          controller.userData
                                                                  .postCount <
                                                              150
                                                      ? Colors.brown
                                                      : controller.userData
                                                                      .postCount >
                                                                  150 &&
                                                              controller
                                                                      .userData
                                                                      .postCount <
                                                                  500
                                                          ? Colors.grey
                                                          : Colors.yellow[700]!;

                                                  int nextLevel =
                                                      (badge == 'Bronze')
                                                          ? 150
                                                          : (badge == 'Silver')
                                                              ? 500
                                                              : 3000;

                                                  return AlertDialog(
                                                    title:
                                                        Text('Badge details'),
                                                    content: Container(
                                                      height: 200,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Column(
                                                        children: [
                                                          Icon(
                                                            Icons.shield,
                                                            size: 80,
                                                            color: color,
                                                          ),
                                                          25.verticalSpace,
                                                          Text(
                                                            'You currently have $badge badge. ${badge == 'Gold' ? '' : 'Make $nextLevel posts to achieve the next badge'}',
                                                            maxLines: 3,
                                                            softWrap: true,
                                                            style: AppText.h2,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Icon(
                                              Icons.shield,
                                              color: controller.userData
                                                              .postCount >
                                                          10 &&
                                                      controller.userData
                                                              .postCount <
                                                          150
                                                  ? Colors.brown
                                                  : controller.userData
                                                                  .postCount >
                                                              150 &&
                                                          controller.userData
                                                                  .postCount <
                                                              500
                                                      ? Colors.grey
                                                      : Colors.yellow[700],
                                              size: 35,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            5.verticalSpace,
                            Text(
                              controller.userData.fullname,
                              style: AppText.h2!.copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      25.horizontalSpace,
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Text(
                              '${controller.userData.followers.length} Follower   |   ${controller.userData.ratings!.length} Ratings',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                            // 5.verticalSpace,
                            Divider(
                              color: AppTheme.c.primary,
                            ),
                            5.verticalSpace,
                          ],
                        ),
                      )
                    ],
                  ),
                  45.verticalSpace,
                  UserTypeRow(
                    isProfessional: controller.userData.isProfessional,
                  ),
                  15.verticalSpace,
                  AppTextField(
                    name: 'name',
                    label: 'Name',
                    controller: TextEditingController(
                      text: controller.userData.fullname,
                    ),
                  ),
                  10.verticalSpace,
                  AppTextField(
                    name: 'email',
                    label: 'Email',
                    controller: TextEditingController(
                      text: controller.userData.email,
                    ),
                  ),
                  10.verticalSpace,
                  AppTextField(
                    name: 'domain',
                    label: 'Domain',
                    controller: TextEditingController(
                      text: controller.userData.domain,
                    ),
                  ),
                  10.verticalSpace,
                  AppTextField(
                    name: 'focus',
                    label: 'Focus',
                    controller: TextEditingController(
                      text: controller.userData.focus,
                    ),
                  ),
                  25.verticalSpace,
                  AppButton(
                    label: 'View all Reviews',
                    onPressed: () {
                      AppRouter.push(context, ProfileReviews());
                    },
                    buttonType: ButtonType.borderedSecondary,
                  ),
                  25.verticalSpace,
                  Divider(),
                  25.verticalSpace,
                  AppButton(
                    label: 'Report a problem',
                    onPressed: () {
                      AppRouter.push(context, ReportAProblem());
                    },
                    buttonType: ButtonType.secondary,
                  )
                  // ListTile(
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12)),
                  //   tileColor: AppTheme.c.primary,
                  //   title: const Text('View ratings'),
                  //   subtitle: Text(
                  //       '${(controller.userData.ratings ?? []).length.toString()} ratings'),
                  //   trailing: const Icon(
                  //     Icons.navigate_next,
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
