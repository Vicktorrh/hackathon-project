import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/constant/app_image.dart';
import 'package:hackathanproject/features/wishlist/wishlist.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';

class HoemPage extends StatefulWidget {
  const HoemPage({super.key});

  @override
  State<HoemPage> createState() => _HoemPageState();
}

class _HoemPageState extends State<HoemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 240, 240),
      body: SingleChildScrollView(
        child: Padding(
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
                    'All Featured',
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
              SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('category')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else if (snapshot.hasData) {
                        var listOfDoc = snapshot.data?.docs;

                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listOfDoc?.length ?? 0,
                            itemBuilder: (context, index) {
                              var doc = listOfDoc![index].data();
                              print(doc);
                              return Container(
                                height: 100,
                                width: 75,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                doc['categoryUrl'])),
                                    Text(doc['categoryName']),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return Container();
                      }
                    }),
              ),
              Container(
                  child: Image(
                image: AssetImage(AppImages.discount),
                width: double.infinity,
                fit: BoxFit.cover,
              )),
              SizedBox(height: 20),
              Container(
                height: 60,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Color(0xff4392F9),
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deal of the Day',
                          style: AppTextStyle.body(
                              color: AppColor.white,
                              size: 16,
                              fontWeight: FontWeight.normal),
                        ),
                        Row(
                          children: [
                            Image(image: AssetImage(AppImages.clock)),
                            Text(
                              '22h 55m 20s remaining',
                              style: AppTextStyle.body(
                                  size: 12,
                                  color: AppColor.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 90),
                    Container(
                      height: 30,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppColor.white)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Wishlist()));
                          },
                          child: Row(
                            children: [
                              Text('View All',
                                  style: AppTextStyle.body(
                                      size: 12,
                                      color: AppColor.white,
                                      fontWeight: FontWeight.normal)),
                              SizedBox(width: 10),
                              const Icon(
                                Icons.arrow_forward,
                                size: 18,
                                color: AppColor.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                                  element.data()['productCategory'] == 'Men')
                              .toList();

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                print(listOfDoc.length);
                                print(menProducts.length);

                                var menProduct = menProducts[index].data();
                                print(menProduct);

                                return Card(
                                  child: Container(
                                    height: 200,
                                    width:
                                        MediaQuery.sizeOf(context).width / 2.3,
                                    child: Column(
                                      children: [
                                        Container(
                                            height: 150,
                                            width: double.infinity,
                                            child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    menProduct['productUrl'])),
                                        Text(
                                          menProduct['productName'],
                                          style: AppTextStyle.body(
                                              size: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(menProduct['productDescription'],
                                            style: AppTextStyle.body(
                                                size: 13,
                                                fontWeight: FontWeight.normal)),
                                        Text(menProduct['price'].toString(),
                                            style: AppTextStyle.body(
                                                size: 12,
                                                fontWeight: FontWeight.normal)),
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
    );
  }
}
