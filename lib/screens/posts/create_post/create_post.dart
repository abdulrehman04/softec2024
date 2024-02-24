import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softec_app/widgets/design/input/app_text_field.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      child: AppTextField(name: 'name'),
    );
  }
}
