import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/router/router.dart';
import 'package:softec_app/screens/login/login.dart';
import 'package:softec_app/widgets/design/buttons/app_button.dart';
import 'package:softec_app/widgets/design/input/app_text_field.dart';
import 'package:softec_app/widgets/headless/divider.dart';

part 'static/_form_data.dart';
part 'static/_form_keys.dart';

part '_state.dart';

part 'widgets/_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
