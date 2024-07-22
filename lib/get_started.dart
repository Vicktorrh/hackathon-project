import 'package:flutter/material.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/constant/app_image.dart';
import 'package:hackathanproject/features/sellers_page/sellers_page.dart';
import 'package:hackathanproject/features/welcome_back/welcome_back.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.getstarted), fit: BoxFit.cover),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Spacer(),
                  Text(
                    textAlign: TextAlign.center,
                    'You want Authentic, here you go!',
                    style: AppTextStyle.body(size: 40, color: AppColor.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Find it here, buy it now!',
                    style: AppTextStyle.body(size: 12, color: AppColor.white),
                  ),
                  SizedBox(height: 30),
                  AppButton(
                      text: 'Get Started',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomeBack()));
                      }),
                  SizedBox(height: 30),
                  AppButton(
                      text: 'Go to Seller Page',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SellersPage()));
                      }),
                  SizedBox(height: 40)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
