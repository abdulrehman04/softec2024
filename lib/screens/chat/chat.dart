import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/cubits/chat/cubit.dart';
import 'package:softec_app/models/auth_data.dart';
import 'package:softec_app/models/chat/chat_meta.dart';
import 'package:softec_app/router/router.dart';
import 'package:softec_app/screens/all_users.dart';
import 'package:softec_app/screens/conversation/conversation.dart';
import 'package:softec_app/services/auth.dart';
import 'package:softec_app/widgets/design/buttons/app_button.dart';
import 'package:softec_app/widgets/design/input/app_text_field.dart';

part '_state.dart';

part 'widgets/_body.dart';
part 'widgets/_chat_card.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: const _Body(),
    );
  }
}
