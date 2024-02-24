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
import 'package:softec_app/widgets/core/bottom_bar/bottom_bar.dart';
import 'package:softec_app/widgets/design/buttons/app_button.dart';
import 'package:softec_app/widgets/design/input/app_text_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileState controller = Provider.of<ProfileState>(context);
    controller.init(context, Provider.of<AuthService>(context).authData!);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      bottomNavigationBar: const BottomBar(),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FormBuilder(
            child: Column(
              children: [
                SizedBox(
                  width: 150.w,
                  height: 150.h,
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.updateProfilePicture(context);
                        },
                        child: controller.userData.profilePicture == ''
                            ? Container(
                                height: 150.h,
                                width: 150.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[900],
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 80,
                                ),
                              )
                            : CircleAvatar(
                                radius: 70,
                                backgroundImage: NetworkImage(
                                  controller.userData.profilePicture,
                                ),
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
    );
  }
}
