import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vexa_todo/Screens/Splash/Views/splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // ignore: prefer_const_constructors
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()));
}
