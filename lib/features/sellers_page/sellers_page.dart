import 'package:flutter/material.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/constant/app_image.dart';
import 'package:hackathanproject/features/sellers_page/add_category.dart';
import 'package:hackathanproject/features/sellers_page/add_products.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';

class SellersPage extends StatelessWidget {
  const SellersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                'Welcome to Sellers Page',
                style: AppTextStyle.body(size: 30),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SellersPageWidget(
                    onTap: () {},
                    image: AppImages.pendingorders,
                    text: 'Pending Orders',
                  ),
                  const SizedBox(width: 60),
                  SellersPageWidget(
                    onTap: () {},
                    image: AppImages.completedorders,
                    text: 'Completed Orders',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SellersPageWidget(
                    onTap: () {},
                    image: AppImages.productsuploaded,
                    text: 'Amount of products uploaded',
                  ),
                  const SizedBox(width: 60),
                  SellersPageWidget(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddProducts()));
                    },
                    image: AppImages.addproducts,
                    text: 'Add \nProducts',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SellersPageWidget(
                    onTap: () {},
                    image: AppImages.reviews,
                    text: 'Reviews',
                  ),
                  const SizedBox(width: 60),
                  SellersPageWidget(
                      image: AppImages.addproducts,
                      text: 'Add \nCategory',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddCategory()));
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SellersPageWidget extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;
  const SellersPageWidget({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        width: 150,
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image(image: AssetImage(image)),
            Text(
              textAlign: TextAlign.center,
              text,
              style: AppTextStyle.body(size: 20, color: AppColor.white),
            ),
          ],
        ),
      ),
    );
  }
}
