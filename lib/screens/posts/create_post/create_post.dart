import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/screens/posts/posts.dart';
import 'package:softec_app/widgets/core/snackbar/custom_snackbar.dart';
import 'package:softec_app/widgets/design/buttons/app_button.dart';
import 'package:softec_app/widgets/design/input/app_text_field.dart';

class CreatePost extends StatelessWidget {
  CreatePost({super.key});

  static final _createPostKey = GlobalKey<FormBuilderState>();
  final TextEditingController caption = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenProvider = PostState.s(context, true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create post'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: screenProvider.isLoading
            ? const SizedBox(
                height: 50,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : AppButton(
                label: 'Post',
                buttonType: ButtonType.secondary,
                onPressed: () async {
                  if (screenProvider.pickedImage != null) {
                    bool result = await screenProvider.createPost(
                      context,
                      caption.text.trim(),
                      screenProvider.pickedImage!,
                    );
                    if (result) {
                      if (context.mounted) {
                        Navigator.pop(context);
                        SnackBars.success(context, 'Post added successfully');
                      }
                    }
                  } else {
                    SnackBars.failure(context, 'You must pick an image');
                  }
                },
              ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              FormBuilder(
                key: _createPostKey,
                child: AppTextField(
                  controller: caption,
                  name: 'Add caption',
                  hint: 'Add caption',
                ),
              ),
              20.verticalSpace,
              GestureDetector(
                onTap: () {
                  screenProvider.pickImage(context);
                },
                child: Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppTheme.c.primary!),
                    image: screenProvider.pickedImage != null
                        ? DecorationImage(
                            image: FileImage(screenProvider.pickedImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: screenProvider.pickedImage == null
                      ? Center(
                          child: Container(
                            width: 90.w,
                            height: 90.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[900],
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 40,
                            ),
                          ),
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
