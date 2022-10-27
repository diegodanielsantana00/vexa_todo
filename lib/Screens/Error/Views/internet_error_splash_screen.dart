// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vexa_todo/Common/GlobalFunctions.dart';
import 'package:vexa_todo/Common/Navigator.dart';
import 'package:vexa_todo/Screens/Splash/Views/splash_screen.dart';

class InternetErrorSplashScreen extends StatefulWidget {
  const InternetErrorSplashScreen({super.key});

  @override
  State<InternetErrorSplashScreen> createState() => _InternetErrorSplashScreenState();
}

class _InternetErrorSplashScreenState extends State<InternetErrorSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi,
              color: Colors.white,
              size: 80,
            ),
            Text(
              "Sem internet",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Flexible(
                  child: Text("Conecte a internet e tente novamente ou compre o plano PREMIUM", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
            ),
            SizedBox(
              width: 230,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: styleButtonDefaut(Colors.white),
                    onPressed: () {
                      NavigatorController().navigatorToNoReturnNoAnimated(context, SplashScreen());
                    },
                    child: Text("Tentar novamente", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.red[900]))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
