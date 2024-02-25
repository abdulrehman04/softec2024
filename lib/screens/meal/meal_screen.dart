import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/models/meal_plan.dart';
import 'package:softec_app/router/router.dart';
import 'package:softec_app/screens/meal_plan_view.dart';
import 'package:softec_app/screens/posts/posts.dart';
import 'package:softec_app/utils/app_utils.dart';
import 'package:softec_app/widgets/design/buttons/app_button.dart';
import 'package:softec_app/widgets/design/input/app_text_field.dart';

part '_state.dart';
part 'widgets/_body.dart';
part 'widgets/_card.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _ScreenState(),
      child: const _Body(),
    );
  }
}
