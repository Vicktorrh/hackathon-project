import 'package:flutter/material.dart';
import 'package:hackathanproject/apis/auth.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/features/welcome_back/welcome_back.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';
import 'package:hackathanproject/widget/nav_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                'MY ACCOUNT',
                style:
                    AppTextStyle.body(size: 20, color: AppColor.primaryColor),
              ),
              SizedBox(height: 20),
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 220, 217, 217)),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.local_grocery_store_rounded, size: 25),
                        SizedBox(width: 20),
                        Text(
                          'Orders',
                          style: AppTextStyle.body(
                              size: 20, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.card_membership, size: 25),
                        SizedBox(width: 20),
                        Text(
                          'Vouchers',
                          style: AppTextStyle.body(
                              size: 20, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.location_on, size: 25),
                        SizedBox(width: 20),
                        Text(
                          'Address Book',
                          style: AppTextStyle.body(
                              size: 20, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.account_box, size: 25),
                        SizedBox(width: 20),
                        Text(
                          'Account Management',
                          style: AppTextStyle.body(
                              size: 20, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.visibility_rounded, size: 25),
                        SizedBox(width: 20),
                        Text(
                          'Recently Viewed',
                          style: AppTextStyle.body(
                              size: 20, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.privacy_tip, size: 25),
                        SizedBox(width: 20),
                        Text(
                          'Privacy Policy',
                          style: AppTextStyle.body(
                              size: 20, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.notifications, size: 25),
                        SizedBox(width: 20),
                        Text(
                          'Notification Settings',
                          style: AppTextStyle.body(
                              size: 20, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              AppButton(
                  text: 'Logout',
                  onTap: () {
                    AuthService().logout(context);
                    context.read<NavProvider>().updateCurrentIndex(0);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
