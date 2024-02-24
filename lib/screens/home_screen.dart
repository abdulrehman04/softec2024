import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softec_app/widgets/core/bottom_bar/bottom_bar.dart';
import 'package:softec_app/widgets/design/buttons/app_button.dart';
import 'package:softec_app/widgets/design/input/app_text_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Method'),
      ),
      bottomNavigationBar: const BottomBar(),
      body: Column(
        children: [
          Center(
            child: FormBuilder(
              key: _formKey,
              child: AppTextField(
                name: '',
                validator: (v) {
                  if (v != null) {
                    if (v.length == 1) {
                      return "hehehe";
                    }
                  }
                  return null;
                },
              ),
            ),
          ),
          AppButton(
            label: 'Tester',
            onPressed: () {
              final form = _formKey.currentState!;
              form.saveAndValidate();
            },
          )
        ],
      ),
    );
  }
}
