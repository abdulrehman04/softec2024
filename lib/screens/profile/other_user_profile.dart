import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/models/auth_data.dart';
import 'package:softec_app/router/router.dart';
import 'package:softec_app/screens/conversation/conversation.dart';
import 'package:softec_app/screens/profile/profileState.dart';
import 'package:softec_app/screens/profile/widgets/usertype_row.dart';
import 'package:softec_app/services/auth.dart';
import 'package:softec_app/widgets/core/snackbar/custom_snackbar.dart';
import 'package:softec_app/widgets/design/buttons/app_button.dart';
import 'package:softec_app/widgets/design/input/app_text_field.dart';

class OtherUserProfile extends StatelessWidget {
  const OtherUserProfile({super.key, required this.user});

  final AuthData user;

  @override
  Widget build(BuildContext context) {
    ProfileState controller = Provider.of<ProfileState>(context);
    AuthData userData = Provider.of<AuthService>(context).authData!;
    controller.init(context, user);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppRouter.push(
            context,
            ConversationScreen(
              receiver: user,
            ),
          );
        },
        child: const Icon(CupertinoIcons.chat_bubble_2),
      ),
      resizeToAvoidBottomInset: false,
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
                            width: 100.w,
                            height: 100.h,
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
                                                            controller.userData
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
                                                            controller.userData
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
                                                  title: Text('Badge details'),
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
                                            color:
                                                controller.userData.postCount >
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
                          AppButton(
                            label: controller.userData.followers
                                    .contains(userData.uid)
                                ? 'Following'
                                : 'Follow',
                            onPressed: () {
                              if (controller.userData.followers
                                  .contains(userData.uid)) {
                                controller.removeFollower(context);
                              } else {
                                controller.addFollower(context);
                              }
                            },
                            buttonType: controller.userData.followers
                                    .contains(userData.uid)
                                ? ButtonType.secondary
                                : ButtonType.borderedSecondary,
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
                  enabled: false,
                  controller: TextEditingController(
                    text: controller.userData.fullname,
                  ),
                ),
                10.verticalSpace,
                AppTextField(
                  name: 'email',
                  label: 'Email',
                  enabled: false,
                  controller: TextEditingController(
                    text: controller.userData.email,
                  ),
                ),
                10.verticalSpace,
                AppTextField(
                  name: 'domain',
                  label: 'Domain',
                  enabled: false,
                  controller: TextEditingController(
                    text: controller.userData.domain,
                  ),
                ),
                10.verticalSpace,
                AppTextField(
                  name: 'focus',
                  label: 'Focus',
                  enabled: false,
                  controller: TextEditingController(
                    text: controller.userData.focus,
                  ),
                ),
                25.verticalSpace,
                AppButton(
                  label: 'Give review',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        int stars = 0;
                        TextEditingController review = TextEditingController();
                        return StatefulBuilder(
                          builder: (context, sst) {
                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SizedBox(
                                  height: 300,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Add review',
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                      15.verticalSpace,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [1, 2, 3, 4, 5].map((e) {
                                          return InkWell(
                                            onTap: () {
                                              sst(() {
                                                stars = e;
                                              });
                                            },
                                            child: Icon(
                                              Icons.star,
                                              color: stars >= e
                                                  ? Colors.yellow[800]
                                                  : Colors.grey,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      15.verticalSpace,
                                      TextField(
                                        controller: review,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: const InputDecoration(
                                          hintText: 'Add remarks',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      35.verticalSpace,
                                      AppButton(
                                        label: 'Submit',
                                        onPressed: () {
                                          if (review.text.trim() != '') {
                                            controller.addReview(
                                              context,
                                              stars,
                                              review.text.trim(),
                                            );
                                            Navigator.pop(context);
                                            SnackBars.success(
                                              context,
                                              'Review added successfully',
                                            );
                                          } else {
                                            SnackBars.failure(
                                              context,
                                              'Please write a review',
                                            );
                                          }
                                        },
                                        buttonType: ButtonType.secondary,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
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
