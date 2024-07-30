import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathanproject/apis/user_products.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/features/checkout/checkout.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';
import 'package:hackathanproject/widget/nav_provider.dart';
import 'package:provider/provider.dart';

class ProductDescription extends StatefulWidget {
  final Map<String, dynamic> products;
  const ProductDescription({super.key, required this.products});

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 240, 240),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Image(
                image:
                    CachedNetworkImageProvider(widget.products['productUrl']),
                fit: BoxFit.contain,
                width: double.infinity,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Text(
                        widget.products['productName'],
                        style: AppTextStyle.body(size: 18),
                      ),
                      Text(
                        widget.products['productDescription'],
                        style: AppTextStyle.body(
                            size: 12, fontWeight: FontWeight.normal),
                      ),
                      Text("\$ ${widget.products['price'].toString()}",
                          style: AppTextStyle.body(
                              size: 18, fontWeight: FontWeight.normal)),
                      Container(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                UserProducts().addtoCart(
                                    widget.products['productId'],
                                    widget.products);
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }

                                context
                                    .read<NavProvider>()
                                    .updateCurrentIndex(2);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(7)),
                                child: Text(
                                  'Add to cart',
                                  style: AppTextStyle.body(
                                      size: 18, color: AppColor.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 30),
                            GestureDetector(
                              onTap: () {
                                UserProducts().addtoCart(
                                    widget.products['productId'],
                                    widget.products);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Checkout()));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(7)),
                                child: Text(
                                  'Buy Now',
                                  style: AppTextStyle.body(
                                      size: 18, color: AppColor.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 237, 139, 172),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Delivery in',
                              style: AppTextStyle.body(
                                size: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Within 1 Hour',
                              style: AppTextStyle.body(size: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            alignment: Alignment.center,
                            height: 40,
                            width: 180,
                            decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Icon(Icons.visibility_outlined),
                                SizedBox(width: 6),
                                Text(
                                  'View Similar',
                                  style: AppTextStyle.body(
                                      size: 14, fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            height: 40,
                            width: 180,
                            decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Icon(Icons.compare),
                                SizedBox(width: 6),
                                Text(
                                  'Add to Compare',
                                  style: AppTextStyle.body(
                                      size: 14, fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Similar To',
                        style: AppTextStyle.body(
                            size: 18, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Many Items',
                            style: AppTextStyle.body(),
                          ),
                          SizedBox(width: 100),
                          Container(
                            height: 25,
                            width: 65,
                            decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Sort',
                                    style: AppTextStyle.body(
                                        size: 13,
                                        fontWeight: FontWeight.normal),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Filter',
                                    style: AppTextStyle.body(
                                        size: 13,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Icon(Icons.filter_alt_outlined)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                          height: 300,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('product')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container();
                                } else if (snapshot.hasData) {
                                  var listOfDoc = snapshot.data?.docs;

                                  var menProducts = listOfDoc!
                                      .where((element) =>
                                          element.data()['productCategory'] ==
                                          'Men')
                                      .toList();

                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 4,
                                      itemBuilder: (context, index) {
                                        print(listOfDoc.length);

                                        var menProduct =
                                            menProducts[index].data();
                                        print(menProduct);
                                        List wishlist = menProduct['wishlist'];

                                        return Card(
                                          child: Container(
                                            height: 200,
                                            width: MediaQuery.sizeOf(context)
                                                    .width /
                                                2.3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    height: 150,
                                                    width: double.infinity,
                                                    child: CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        imageUrl: menProduct[
                                                            'productUrl'])),
                                                Text(
                                                  menProduct['productName'],
                                                  style: AppTextStyle.body(
                                                      size: 16),
                                                ),
                                                Text(
                                                    menProduct[
                                                        'productDescription'],
                                                    style: AppTextStyle.body(
                                                        size: 13,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                                SizedBox(height: 7),
                                                Row(
                                                  children: [
                                                    Text(
                                                        '\$ ${menProduct['price'].toString()}',
                                                        style:
                                                            AppTextStyle.body(
                                                                size: 14)),
                                                    Spacer(),
                                                    GestureDetector(
                                                        onTap: () {
                                                          UserProducts()
                                                              .addtoWishlist(
                                                                  menProduct[
                                                                      'productId'],
                                                                  menProduct);
                                                        },
                                                        child: wishlist.contains(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid)
                                                            ? Icon(
                                                                Icons.favorite,
                                                                color:
                                                                    Colors.red,
                                                              )
                                                            : Icon(Icons
                                                                .favorite_border)),
                                                    SizedBox(width: 10)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                } else {
                                  return Container(
                                    height: 50,
                                    width: 50,
                                  );
                                }
                              })),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
