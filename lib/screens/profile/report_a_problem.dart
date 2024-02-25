import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/models/auth_data.dart';
import 'package:softec_app/services/auth.dart';
import 'package:softec_app/widgets/core/snackbar/custom_snackbar.dart';
import 'package:softec_app/widgets/design/buttons/app_button.dart';
import 'package:softec_app/widgets/design/input/app_text_field.dart';

final reportKey = GlobalKey<FormBuilderState>();

class ReportAProblem extends StatefulWidget {
  ReportAProblem({super.key});

  @override
  State<ReportAProblem> createState() => _ReportAProblemState();
}

class _ReportAProblemState extends State<ReportAProblem> {
  final TextEditingController email = TextEditingController();

  final TextEditingController name = TextEditingController();

  final TextEditingController report = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthData user = Provider.of<AuthService>(context).authData!;
    email.text = user.email;
    name.text = user.fullname;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report a problem'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: isLoading
            ? Container(
                height: 55.h,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : AppButton(
                label: 'Report',
                onPressed: () async {
                  if (email.text == '' ||
                      name.text == '' ||
                      report.text == '') {
                    SnackBars.failure(context, 'Please fill all fields');
                  } else {
                    setState(() {
                      isLoading = true;
                    });
                    await FirebaseFirestore.instance.collection('reports').add({
                      'name': name.text.trim(),
                      'email': email.text.trim(),
                      'report': report.text.trim(),
                    });
                    setState(() {
                      isLoading = false;
                    });
                    if (context.mounted) {
                      Navigator.pop(context);
                      SnackBars.success(
                        context,
                        'Feedback submitted succesfully',
                      );
                    }
                  }
                },
                buttonType: ButtonType.secondary,
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: reportKey,
            child: Column(
              children: [
                AppTextField(
                  name: 'email',
                  controller: email,
                  label: 'Email',
                ),
                10.verticalSpace,
                AppTextField(
                  name: 'name',
                  controller: name,
                  label: 'Name',
                ),
                10.verticalSpace,
                AppTextField(
                  name: 'report',
                  controller: report,
                  label: 'Report',
                  hint: 'Write your query',
                  maxLines: 7,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
