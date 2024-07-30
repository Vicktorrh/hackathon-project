import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathanproject/apis/user_products.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/constant/app_image.dart';
import 'package:hackathanproject/features/checkout/checkout.dart';
import 'package:hackathanproject/features/product/product_shop.dart';
import 'package:hackathanproject/features/welcome_back/welcome_back.dart';
import 'package:hackathanproject/model/users_model.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';

class Cart extends StatefulWidget {
  final UserModel user;
  const Cart({super.key, required this.user});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
                      .collection('cart')
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
                                            builder: (context) =>
                                                ProductShop()));
                                  }),
                            ],
                          ),
                        );
                      return ListView.builder(
                          itemCount: listOfDoc.length,
                          itemBuilder: (context, index) {
                            var product = listOfDoc[index].data();
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 100,
                                        child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: product['productUrl'])),
                                    SizedBox(width: 6),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 240,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 180,
                                                  child: Text(
                                                    product['productName'],
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyle.body(
                                                        size: 16),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    UserProducts().deleteCart(
                                                        product['productId'],
                                                        product,
                                                        listOfDoc);
                                                  },
                                                  child: Icon(
                                                    Icons
                                                        .delete_outline_outlined,
                                                    color:
                                                        AppColor.primaryColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 180,
                                            child: Text(
                                                product['productDescription'],
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyle.body(
                                                    size: 13,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                          ),
                                          SizedBox(height: 7),
                                          Row(
                                            children: [
                                              Text(
                                                  "\$ ${product['totalPrice'].toString()}",
                                                  style: AppTextStyle.body(
                                                      size: 14)),
                                              SizedBox(width: 80),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        UserProducts()
                                                            .decreaseCurrentProduct(
                                                                context,
                                                                product[
                                                                    'productId'],
                                                                product);
                                                      },
                                                      child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      4),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7),
                                                              color: AppColor
                                                                  .primaryColor),
                                                          child: Icon(
                                                              Icons.remove))),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10.0),
                                                    child: Text(
                                                      '${product['productCount']}',
                                                      style: AppTextStyle.body(
                                                          size: 16),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        UserProducts()
                                                            .increaseCurrentProduct(
                                                                product[
                                                                    'productId'],
                                                                product);
                                                      },
                                                      child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      4),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7),
                                                              color: AppColor
                                                                  .primaryColor),
                                                          child:
                                                              Icon(Icons.add))),
                                                ],
                                              ),
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
            widget.user.totalPrice < 1
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$ ${widget.user.totalPrice}",
                        style: AppTextStyle.body(
                            size: 30, fontWeight: FontWeight.normal),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Checkout()));
                        },
                        child: Container(
                          height: 55,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Checkout',
                            style: AppTextStyle.body(
                                size: 20, color: AppColor.white),
                          ),
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
