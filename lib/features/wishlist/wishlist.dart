import 'package:flutter/material.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/constant/app_image.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 240, 240),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
            Row(
              children: [
                Text(
                  '52 Items',
                  style: AppTextStyle.body(),
                ),
                SizedBox(width: 130),
                Container(
                  height: 25,
                  width: 65,
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Row(
                      children: [
                        Text(
                          'Sort',
                          style: AppTextStyle.body(
                              size: 13, fontWeight: FontWeight.normal),
                        ),
                        Icon(Icons.compare_arrows_rounded)
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 25,
                  width: 70,
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Row(
                      children: [
                        Text(
                          'Filter',
                          style: AppTextStyle.body(
                              size: 13, fontWeight: FontWeight.normal),
                        ),
                        Icon(Icons.filter_alt_outlined)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
