import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/cubits/chat/cubit.dart';
import 'package:softec_app/cubits/pose_analysis/pose_analysis_cubit.dart';
import 'package:softec_app/firebase_options.dart';
import 'package:softec_app/providers/analytics_provider.dart';
import 'package:softec_app/router/router.dart';
import 'package:softec_app/screens/posts/posts.dart';
import 'package:softec_app/screens/profile/profileState.dart';
import 'package:softec_app/screens/search_screen/search_screen.dart';
import 'package:softec_app/services/auth.dart';
import 'package:softec_app/services/event.dart';
import 'package:softec_app/services/notifications/base.dart';
import 'package:softec_app/services/notifications/service.dart';
import 'configs/configs.dart' as theme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  NotificationBase.init(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _handleLocationPermission(context);
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
            BlocProvider(create: (_) => ChatCubit()),
            ChangeNotifierProvider(create: (_) => NotiService()),
            ChangeNotifierProvider(create: (_) => SearchState()),
            BlocProvider(create: (_) => ChatCubit()),
            ChangeNotifierProvider(create: (_) => EventService()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Softec 2024',
            builder: (context, child) {
              App.init(context);
              final notificationService = NotificationBase();
              notificationService.listenNotifications(context);
              return child!;
            },
            theme: theme.themeDark.copyWith(
              textTheme: GoogleFonts.poppinsTextTheme(),
            ),
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

  Future<bool> _handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
}
