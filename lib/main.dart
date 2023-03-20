import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/utils/timeago_messages.dart';
import 'firebase_options.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'config/routes/app_router.dart';
import 'config/routes/app_routes.dart' as routes;
import 'config/di/dependency_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();

  timeago.setLocaleMessages('en_short', TimeagoMessages());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: FlexThemeData.light(scheme: FlexScheme.green, useMaterial3: true),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.green, useMaterial3: true),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _router.generateRoute,
      initialRoute: FirebaseAuth.instance.currentUser == null ? routes.authentication : routes.home,
    );
  }
}
