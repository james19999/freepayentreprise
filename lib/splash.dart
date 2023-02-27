import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/helper/images.dart';
import 'package:freepayagency/pages/login/login.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.white,
      splash: Image.asset(
        logo,
        height: 500,
        width: 200,
        fit: BoxFit.cover,
      ),
      nextScreen: Login(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
