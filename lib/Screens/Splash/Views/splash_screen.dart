// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:vexa_todo/Common/GlobalFunctions.dart';
import 'package:vexa_todo/Common/Navigator.dart';
import 'package:vexa_todo/Common/SQLiteHelper.dart';
import 'package:vexa_todo/Screens/Home/Views/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    StartProcess() async {
      String version = await GetVersion();
      String varsionDataBase = await DatabaseHelper().getLastVersion();

      if (int.parse(varsionDataBase.split("+")[0].replaceAll(".", "")) < int.parse(version.split("+")[0].replaceAll(".", ""))) {
        //Structure
      }
      NavigatorController().navigatorToNoReturnNoAnimated(context, HomeScreen());
    }

    StartProcess();
    return Scaffold(
      backgroundColor: Colors.green,
    );
  }
}
