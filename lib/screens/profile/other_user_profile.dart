import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/models/auth_data.dart';
import 'package:softec_app/router/router.dart';
import 'package:softec_app/screens/profile/profileState.dart';
import 'package:softec_app/screens/profile/profile_reviews.dart';
import 'package:softec_app/screens/profile/widgets/usertype_row.dart';
import 'package:softec_app/services/auth.dart';
import 'package:softec_app/widgets/design/buttons/app_button.dart';
import 'package:softec_app/widgets/design/input/app_text_field.dart';

class OtherUserProfile extends StatelessWidget {
  const OtherUserProfile({super.key, required this.user});

  final AuthData user;

  @override
  Widget build(BuildContext context) {
    ProfileState controller = Provider.of<ProfileState>(context);
    controller.init(context, user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SizedBox(
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
                            width: 80.w,
                            height: 80.h,
                            child: Stack(
                              children: [
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
                                          controller.userData.profilePicture,
                                        ),
                                      ),
                                Align(
                                  alignment: Alignment.center,
                                  child: controller.isLoading
                                      ? const CircularProgressIndicator()
                                      : Container(),
                                )
                              ],
                            ),
                          ),
                          5.verticalSpace,
                          Text(
                            controller.userData.fullname,
                            style: AppText.h2,
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
                            '${controller.userData.followers.length} Follower',
                            style: const TextStyle(fontSize: 20),
                          ),
                          // 5.verticalSpace,
                          Divider(
                            color: AppTheme.c.primary,
                          ),
                          5.verticalSpace,
                          AppButton(
                            label: 'Follow',
                            onPressed: () {
                              controller.addFollower(context);
                            },
                            buttonType: ButtonType.borderedSecondary,
                            height: 35,
                          ),
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
                    AppRouter.push(context, const ProfileReviews());
                  },
                  buttonType: ButtonType.borderedSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
