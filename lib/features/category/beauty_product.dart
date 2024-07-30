import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathanproject/apis/user_products.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/constant/app_image.dart';
import 'package:hackathanproject/features/product/product_description.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';

class BeautyProduct extends StatefulWidget {
  const BeautyProduct({super.key});

  @override
  State<BeautyProduct> createState() => _BeautyProductState();
}

class _BeautyProductState extends State<BeautyProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 240, 240),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_new)),
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
            SizedBox(height: 8),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('product')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (snapshot.hasData) {
                      var listOfDoc = snapshot.data!.docs;
                      var beautyProducts = listOfDoc
                          .where((element) =>
                              element.data()['productCategory'] == 'Beauty')
                          .toList();
                      return GridView.builder(
                          itemCount: listOfDoc.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            maxCrossAxisExtent: 199,
                            childAspectRatio: 0.6,
                          ),
                          itemBuilder: (context, index) {
                            var beautyProduct = beautyProducts[index].data();
                            print(beautyProduct);
                            List wishlist = beautyProduct['wishlist'];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDescription(
                                              products: beautyProduct,
                                            )));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                              height: 150,
                                              width: double.infinity,
                                              child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: beautyProduct[
                                                      'productUrl'])),
                                          Positioned(
                                            right: 6,
                                            top: 5,
                                            child: GestureDetector(
                                                onTap: () {
                                                  UserProducts().addtoWishlist(
                                                      beautyProduct[
                                                          'productId'],
                                                      beautyProduct);
                                                },
                                                child: wishlist.contains(
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid)
                                                    ? Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      )
                                                    : Icon(
                                                        Icons.favorite_border)),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 6),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              beautyProduct['productName'],
                                              style:
                                                  AppTextStyle.body(size: 16),
                                            ),
                                            Text(
                                                beautyProduct[
                                                    'productDescription'],
                                                style: AppTextStyle.body(
                                                    size: 13,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                            SizedBox(height: 7),
                                            Row(
                                              children: [
                                                Text(
                                                    "\$ ${beautyProduct['price'].toString()}",
                                                    style: AppTextStyle.body(
                                                        size: 14)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Container();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
