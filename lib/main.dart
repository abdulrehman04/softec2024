import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/cubits/chat/cubit.dart';
import 'package:softec_app/cubits/pose_analysis/pose_analysis_cubit.dart';
import 'package:softec_app/firebase_options.dart';
import 'package:softec_app/providers/analytics_provider.dart';
import 'package:softec_app/router/router.dart';
import 'package:softec_app/screens/pose_analysis_screen.dart';
import 'package:softec_app/screens/posts/posts.dart';
import 'package:softec_app/screens/profile/profileState.dart';
import 'package:softec_app/services/auth.dart';
import 'configs/configs.dart' as theme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        final List<NavigatorObserver> observers = [];
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthService()),
            ChangeNotifierProvider(create: (_) => AnalyticsProvider()),
            BlocProvider(create: (_) => PoseAnalysisCubit()),
            ChangeNotifierProvider(create: (_) => PostState()),
            ChangeNotifierProvider(create: (_) => ProfileState()),
            BlocProvider(create: (_) => ChatCubit())
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Softec 2024',
            builder: (context, child) {
              App.init(context);
              return child!;
            },
            theme: theme.themeDark,
            onGenerateRoute: onGenerateRoutes,
            navigatorObservers: [
              ...observers,
              NavigationHistoryObserver(),
            ],
            initialRoute: 'login',
            // home: PoseAnalysisScreen(),
          ),
        );
      },
      // child: const HomePage(title: 'First Method'),
    );
  }
}
