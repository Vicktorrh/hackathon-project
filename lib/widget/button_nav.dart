import 'package:flutter/material.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/constant/app_image.dart';
import 'package:hackathanproject/global_widget/image_widget.dart';
import 'package:hackathanproject/widget/nav_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavProvider>(builder: (context, navProvider, _) {
      return Scaffold(
        body: navProvider.screens[navProvider.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navProvider.currentIndex,
          onTap: navProvider.updateCurrentIndex,
          items: [
            BottomNavigationBarItem(
                icon: ImageWidget(
                  imagePath: AppImages.home,
                  color: navProvider.checkCurrentState(0)
                      ? AppColor.primaryColor
                      : Colors.grey,
                ),
                label: 'Messages'),
            BottomNavigationBarItem(
                icon: ImageWidget(
                  imagePath: AppImages.heart,
                  color: navProvider.checkCurrentState(0)
                      ? AppColor.primaryColor
                      : Colors.grey,
                ),
                label: 'Wishlist'),
            BottomNavigationBarItem(
                icon: ImageWidget(
                  imagePath: AppImages.shoppingcart,
                  color: navProvider.checkCurrentState(0)
                      ? AppColor.primaryColor
                      : Colors.grey,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: ImageWidget(
                  imagePath: AppImages.search,
                  color: navProvider.checkCurrentState(0)
                      ? AppColor.primaryColor
                      : Colors.grey,
                ),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: ImageWidget(
                  imagePath: AppImages.settings,
                  color: navProvider.checkCurrentState(0)
                      ? AppColor.primaryColor
                      : Colors.grey,
                ),
                label: 'Setting'),
          ],
        ),
      );
    });
  }
}
