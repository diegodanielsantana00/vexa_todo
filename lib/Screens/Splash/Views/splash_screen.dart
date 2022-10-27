// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vexa_todo/Common/GlobalFunctions.dart';
import 'package:vexa_todo/Common/Navigator.dart';
import 'package:vexa_todo/Common/SQLiteHelper.dart';
import 'package:vexa_todo/Common/Structure.dart';
import 'package:vexa_todo/Controller/AdsController.dart';
import 'package:vexa_todo/Screens/Error/Views/internet_error_splash_screen.dart';
import 'package:vexa_todo/Screens/Home/Views/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AdsController adsController = AdsController();
  @override
  Widget build(BuildContext context) {
    StartProcess() async {
      String version = await GetVersion();
      String varsionDataBase = await DatabaseHelper().getLastVersion();

      if (int.parse(varsionDataBase.split("+")[0].replaceAll(".", "")) < int.parse(version.split("+")[0].replaceAll(".", ""))) {
        await Structure().runStructure();
      }
      await adsController.ativarAds();

      try {
        final result = await InternetAddress.lookup('google.com.br');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          Future.delayed(Duration(seconds: 3), () {
            NavigatorController().navigatorToNoReturnNoAnimated(context, HomeScreen(adsController));
          });
        } else {
          NavigatorController().navigatorToNoReturnNoAnimated(context, InternetErrorSplashScreen());
        }
      } on SocketException catch (_) {
        NavigatorController().navigatorToNoReturnNoAnimated(context, InternetErrorSplashScreen());
      }
    }

    StartProcess();
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 30,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
            CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/png/logo.png"),
                )),
          ],
        ),
      ),
    );
  }
}
