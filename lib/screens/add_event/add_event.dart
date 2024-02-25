import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/models/event.dart';
import 'package:softec_app/services/auth.dart';
import 'package:softec_app/services/event.dart';
import 'package:softec_app/services/notifications/base.dart';
import 'package:softec_app/widgets/core/snackbar/custom_snackbar.dart';
import 'package:softec_app/widgets/design/buttons/app_button.dart';
import 'package:softec_app/widgets/design/input/app_text_field.dart';

part '_state.dart';
part '_body.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return ChangeNotifierProvider(
        create: (context) => _ScreenState(), child: const _Body());
  }
}
