import 'package:flutter/material.dart';
import 'package:hackathanproject/constant/app_image.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(AppImages.biglogo),
        ),
      ),
    );
  }
}
