import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/cubits/chat/cubit.dart';
import 'package:softec_app/models/auth_data.dart';
import 'package:softec_app/models/chat/message.dart';
import 'package:softec_app/services/auth.dart';
import 'package:softec_app/widgets/design/input/app_text_field.dart';

part '_state.dart';

part 'static/_form_data.dart';
part 'static/_form_keys.dart';

part 'widgets/_body.dart';
part 'widgets/_bubble.dart';

class ConversationScreen extends StatelessWidget {
  final AuthData receiver;
  const ConversationScreen({required this.receiver, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: _Body(receiver: receiver),
    );
  }
}
