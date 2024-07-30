import 'package:flutter/material.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/constant/app_image.dart';
import 'package:hackathanproject/core/secure_storage.dart';
import 'package:hackathanproject/get_started.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentPage = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 800,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: PageView(
                  controller: pageController,
                  onPageChanged: (val) {
                    setState(() {
                      currentPage = val;
                    });
                  },
                  children: [
                    SplashScreenWidget(
                      headerNum: '1/3',
                      imagePath: AppImages.splashscreen1,
                      title: 'Choose Products',
                      subtitle:
                          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
                    ),
                    SplashScreenWidget(
                      headerNum: '2/3',
                      imagePath: AppImages.splashscreen2,
                      title: 'Make Payment',
                      subtitle:
                          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
                    ),
                    SplashScreenWidget(
                      headerNum: '3/3',
                      imagePath: AppImages.splashscreen3,
                      title: 'Get Your Order',
                      subtitle:
                          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  currentPage > 0
                      ? GestureDetector(
                          onTap: () {
                            if (pageController.page != 0) {
                              pageController.previousPage(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            }
                          },
                          child: Text(
                            "Prev",
                            style: AppTextStyle.body(
                                color: AppColor.grey, size: 16),
                          ),
                        )
                      : Container(),
                  Spacer(),
                  SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                          dotColor: AppColor.grey,
                          activeDotColor: AppColor.black,
                          dotHeight: 10,
                          dotWidth: 10)),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      if (pageController.page == 2) {
                        AppStorage().saveOnBoard();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GetStarted()));
                      } else {
                        pageController.nextPage(
                            duration: Duration(milliseconds: 200),
                            curve: Curves.ease);
                      }
                    },
                    child: Text(
                      currentPage == 2 ? 'Get Started' : "Next",
                      style: AppTextStyle.body(
                          color: AppColor.primaryColor, size: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SplashScreenWidget extends StatelessWidget {
  final String headerNum;
  final String imagePath;
  final String title;
  final String subtitle;
  const SplashScreenWidget({
    super.key,
    required this.headerNum,
    required this.imagePath,
    required this.subtitle,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(height: 100),
            Text(
              headerNum,
              style: AppTextStyle.body(
                size: 18,
              ),
            ),
            const SizedBox(width: 320),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GetStarted()));
              },
              child: Text(
                'Skip',
                style: AppTextStyle.body(size: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 100),
        Image(image: AssetImage(imagePath)),
        const SizedBox(height: 30),
        Text(title, style: AppTextStyle.body(size: 28)),
        Text(
            textAlign: TextAlign.center,
            subtitle,
            style: AppTextStyle.body(
                size: 14, color: AppColor.grey, fontWeight: FontWeight.normal)),
        const Spacer(),
      ],
    );
  }
}
