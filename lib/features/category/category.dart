import 'package:flutter/material.dart';
import 'package:hackathanproject/constant/app_image.dart';
import 'package:hackathanproject/features/category/beauty_product.dart';
import 'package:hackathanproject/features/category/fashion.dart';
import 'package:hackathanproject/features/category/kid_product.dart';
import 'package:hackathanproject/features/category/men_product.dart';
import 'package:hackathanproject/features/category/women_product.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 240, 240),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 50),
              Row(
                children: [
                  Icon(Icons.menu_rounded),
                  SizedBox(width: 90),
                  Image(image: AssetImage(AppImages.smalllogo)),
                  SizedBox(width: 90),
                  Image(image: AssetImage(AppImages.pp))
                ],
              ),
              SizedBox(height: 35),
              Card(
                elevation: 1,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Search any product',
                      hintStyle: AppTextStyle.body(
                          size: 14, fontWeight: FontWeight.normal),
                      prefixIcon: Icon(Icons.search_rounded),
                      suffixIcon: Icon(Icons.mic_none_rounded),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Browse through our product categories',
                style: AppTextStyle.body(),
              ),
              SizedBox(height: 20),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MenProduct()));
                },
                child: Row(
                  children: [
                    Text('Men',
                        style:
                            AppTextStyle.body(fontWeight: FontWeight.normal)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded, size: 20)
                  ],
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WomenProduct()));
                },
                child: Row(
                  children: [
                    Text('Women',
                        style:
                            AppTextStyle.body(fontWeight: FontWeight.normal)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded, size: 20)
                  ],
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => KidProduct()));
                },
                child: Row(
                  children: [
                    Text('Kids',
                        style:
                            AppTextStyle.body(fontWeight: FontWeight.normal)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded, size: 20)
                  ],
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BeautyProduct()));
                },
                child: Row(
                  children: [
                    Text('Beauty',
                        style:
                            AppTextStyle.body(fontWeight: FontWeight.normal)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded, size: 20)
                  ],
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FashionProduct()));
                },
                child: Row(
                  children: [
                    Text('Fashion',
                        style:
                            AppTextStyle.body(fontWeight: FontWeight.normal)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded, size: 20)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}