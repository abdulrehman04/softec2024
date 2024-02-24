import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/cubits/chat/cubit.dart';
import 'package:softec_app/models/chat/chat_meta.dart';
import 'package:softec_app/router/router.dart';
import 'package:softec_app/screens/all_users.dart';
import 'package:softec_app/services/auth.dart';
import 'package:softec_app/widgets/core/bottom_bar/bottom_bar.dart';
import 'package:softec_app/widgets/design/buttons/app_button.dart';
import 'package:softec_app/widgets/design/input/app_text_field.dart';

part '_state.dart';
part '_body.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return ChangeNotifierProvider(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
