import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/helper/images.dart';
import 'package:freepayagency/pages/home/home.dart';
import 'package:freepayagency/pages/login/login.dart';

class SplashHome extends StatelessWidget {
  const SplashHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 1000,
      backgroundColor: Colors.white,
      splash: Center(
        child: CircularProgressIndicator(
          strokeWidth: 1,
          color: AppColors.mainColor,
        ),
      ),
      nextScreen: Home(),
      splashTransition: SplashTransition.rotationTransition,
    );
  }
}
