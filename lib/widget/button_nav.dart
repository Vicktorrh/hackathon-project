import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathanproject/apis/users.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/constant/app_image.dart';
import 'package:hackathanproject/global_widget/image_widget.dart';
import 'package:hackathanproject/global_widget/loading.dart';
import 'package:hackathanproject/model/users_model.dart';
import 'package:hackathanproject/widget/nav_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
//  UserModel? user;
  @override
  void initState() {
    //  setUsersDetail();
    super.initState();
  }

  // setUsersDetail() async {
  //   var users = await UserService.getUserData();

  //   if (users != null) {
  //     setState(() {
  //       user = users;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          return Consumer<NavProvider>(builder: (context, navProvider, _) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            } else {
              var data = snapshot.data!.data();
              UserModel user = UserModel.fromMap(data!);
              return Scaffold(
                body: navProvider.screens(user)[navProvider.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
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
                        label: 'Home'),
                    BottomNavigationBarItem(
                        icon: ImageWidget(
                          imagePath: AppImages.heart,
                          color: navProvider.checkCurrentState(1)
                              ? AppColor.primaryColor
                              : Colors.grey,
                        ),
                        label: 'Wishlist'),
                    BottomNavigationBarItem(
                        icon: ImageWidget(
                          imagePath: AppImages.shoppingcart,
                          color: navProvider.checkCurrentState(2)
                              ? AppColor.primaryColor
                              : Colors.grey,
                        ),
                        label: ''),
                    user?.seller ?? false
                        ? BottomNavigationBarItem(
                            icon: Icon(
                              Icons.store,
                              color: navProvider.checkCurrentState(3)
                                  ? AppColor.primaryColor
                                  : Colors.grey,
                            ),
                            label: 'Seller Page')
                        : BottomNavigationBarItem(
                            icon: Icon(
                              Icons.menu_open_outlined,
                              color: navProvider.checkCurrentState(3)
                                  ? AppColor.primaryColor
                                  : Colors.grey,
                            ),
                            label: 'Category'),
                    BottomNavigationBarItem(
                        icon: ImageWidget(
                          imagePath: AppImages.settings,
                          color: navProvider.checkCurrentState(4)
                              ? AppColor.primaryColor
                              : Colors.grey,
                        ),
                        label: 'Setting'),
                  ],
                ),
              );
            }
          });
        });
  }
}
