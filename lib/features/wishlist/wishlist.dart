import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathanproject/apis/user_products.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/constant/app_image.dart';
import 'package:hackathanproject/features/product/product_shop.dart';
import 'package:hackathanproject/features/welcome_back/welcome_back.dart';
import 'package:hackathanproject/model/users_model.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';
import 'package:hackathanproject/widget/nav_provider.dart';
import 'package:provider/provider.dart';

class Wishlist extends StatefulWidget {
  final UserModel user;
  const Wishlist({super.key, required this.user});

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
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('wishlist')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (snapshot.hasData) {
                      var listOfDoc = snapshot.data!.docs;

                      if (listOfDoc.isEmpty)
                        return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'You havent found what you like?',
                                style: AppTextStyle.body(
                                    size: 16, fontWeight: FontWeight.normal),
                              ),
                              SizedBox(height: 5),
                              AppButton(
                                  text: 'Go to Store',
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductShop(
                                                  user: widget.user,
                                                )));
                                  }),
                            ],
                          ),
                        );
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
                            var product = listOfDoc[index].data();
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 150,
                                        width: double.infinity,
                                        child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: product['productUrl'])),
                                    SizedBox(height: 6),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            product['productName'],
                                            style: AppTextStyle.body(size: 16),
                                          ),
                                          Text(product['productDescription'],
                                              style: AppTextStyle.body(
                                                  size: 13,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          SizedBox(height: 7),
                                          Row(
                                            children: [
                                              Text(
                                                  "\$ ${product['price'].toString()}",
                                                  style: AppTextStyle.body(
                                                      size: 14)),
                                              Spacer(),
                                              GestureDetector(
                                                  onTap: () {
                                                    UserProducts().addtoCart(
                                                        product['productId'],
                                                        product);
                                                    context
                                                        .read<NavProvider>()
                                                        .updateCurrentIndex(2);
                                                  },
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7),
                                                          color: AppColor
                                                              .primaryColor),
                                                      child:
                                                          Text('Add to cart'))),
                                              SizedBox(width: 10)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
