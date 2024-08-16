import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathanproject/apis/user_products.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/constant/app_image.dart';
import 'package:hackathanproject/core/snackbar.dart';
import 'package:hackathanproject/features/category/categories.dart';
import 'package:hackathanproject/features/product/product_description.dart';
import 'package:hackathanproject/features/product/product_shop.dart';
import 'package:hackathanproject/model/users_model.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  PopupMenuButton<String>(
                    icon: Icon(Icons.menu_rounded),
                    onSelected: (String result) {
                      switch (result) {
                        case 'Categories':
                          print('filter 1 clicked');
                          break;
                        case 'Wishlist':
                          print('filter 2 clicked');
                          break;
                        case 'Logout':
                          print('Clear filters');
                          break;
                        default:
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'filter1',
                        child: Text('Categories'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'filter2',
                        child: Text('Wishlist'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'clearFilters',
                        child: Text('Logout'),
                      ),
                    ],
                  ),
                  SizedBox(width: 70),
                  Image(image: AssetImage(AppImages.smalllogo)),
                  SizedBox(width: 90),
                  Image(image: AssetImage(AppImages.pp))
                ],
              ),
              SizedBox(height: 35),
              SearchWidget(),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'All Featured',
                    style: AppTextStyle.body(),
                  ),
                  SizedBox(width: 100),
                  GestureDetector(
                    onTap: () {
                      AppSnackBar.error(context, 'Not Implemented Yet');
                    },
                    child: Container(
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
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      AppSnackBar.error(context, 'Not Implemented Yet');
                    },
                    child: Container(
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
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CategoriesScreen(
                                                user: widget.user,
                                                category: doc['categoryName'],
                                              )));
                                },
                                child: Container(
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
                                ),
                              );
                            });
                      } else {
                        return Container();
                      }
                    }),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductShop(user: widget.user)));
                },
                child: Container(
                    child: Image(
                  image: AssetImage(AppImages.discount),
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
              ),
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
                                    builder: (context) => ProductShop(
                                          user: widget.user,
                                        )));
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
              SizedBox(height: 15),
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
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                print(listOfDoc.length);

                                var menProduct = menProducts[index].data();
                                print(menProduct);
                                List wishlist = menProduct['wishlist'];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDescription(
                                                  products: menProduct,
                                                  user: widget.user,
                                                )));
                                  },
                                  child: Card(
                                    child: Container(
                                      height: 200,
                                      width: MediaQuery.sizeOf(context).width /
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
                                            style: AppTextStyle.body(size: 16),
                                          ),
                                          Text(menProduct['productDescription'],
                                              style: AppTextStyle.body(
                                                  size: 13,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          SizedBox(height: 7),
                                          Row(
                                            children: [
                                              Text(
                                                  '\$ ${menProduct['price'].toString()}',
                                                  style: AppTextStyle.body(
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
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid)
                                                      ? Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                        )
                                                      : Icon(Icons
                                                          .favorite_border)),
                                              SizedBox(width: 10)
                                            ],
                                          ),
                                        ],
                                      ),
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
              Container(
                height: 95,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromARGB(255, 235, 230, 230)),
                child: Row(
                  children: [
                    SizedBox(width: 15),
                    Image(image: AssetImage(AppImages.special)),
                    SizedBox(width: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Special Offers',
                          style: AppTextStyle.body(
                              fontWeight: FontWeight.bold, size: 18),
                        ),
                        Text(
                          'We make sure you get the \noffer you need at best prices',
                          style: AppTextStyle.body(
                              size: 14, fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                  child: Image(
                image: AssetImage(AppImages.mac),
                width: double.infinity,
                fit: BoxFit.cover,
              )),
              SizedBox(height: 15),
              Container(
                height: 60,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Color(0xffFD6E87),
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trending Products',
                          style: AppTextStyle.body(
                              color: AppColor.white,
                              size: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Icon(Icons.calendar_month_outlined,
                                color: AppColor.white, size: 16),
                            SizedBox(width: 8),
                            Text(
                              'Last Date 29/08/24',
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
                                    builder: (context) => ProductShop(
                                          user: widget.user,
                                        )));
                          },
                          child: Row(
                            children: [
                              Text('View All',
                                  style: AppTextStyle.body(
                                      size: 12,
                                      color: AppColor.white,
                                      fontWeight: FontWeight.w500)),
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
              SizedBox(height: 15),
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

                          var womenProducts = listOfDoc!
                              .where((element) =>
                                  element.data()['productCategory'] == 'Women')
                              .toList();

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                print(listOfDoc.length);

                                var womenProduct = womenProducts[index].data();
                                print(womenProduct);
                                List wishlist = womenProduct['wishlist'];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDescription(
                                                    products: womenProduct,
                                                    user: widget.user)));
                                  },
                                  child: Card(
                                    child: Container(
                                      height: 200,
                                      width: MediaQuery.sizeOf(context).width /
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
                                                  imageUrl: womenProduct[
                                                      'productUrl'])),
                                          Text(
                                            womenProduct['productName'],
                                            style: AppTextStyle.body(size: 16),
                                          ),
                                          Text(
                                              womenProduct[
                                                  'productDescription'],
                                              style: AppTextStyle.body(
                                                  size: 13,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          SizedBox(height: 7),
                                          Row(
                                            children: [
                                              Text(
                                                  "\$ ${womenProduct['price'].toString()}",
                                                  style: AppTextStyle.body(
                                                      size: 14)),
                                              Spacer(),
                                              GestureDetector(
                                                  onTap: () {
                                                    UserProducts()
                                                        .addtoWishlist(
                                                            womenProduct[
                                                                'productId'],
                                                            womenProduct);
                                                  },
                                                  child: wishlist.contains(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid)
                                                      ? Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                        )
                                                      : Icon(Icons
                                                          .favorite_border)),
                                              SizedBox(width: 10)
                                            ],
                                          ),
                                        ],
                                      ),
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
              SizedBox(height: 15),
              Container(
                  child: Image(
                      image: AssetImage(AppImages.mask),
                      width: double.infinity,
                      fit: BoxFit.cover)),
              Container(
                height: 60,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Arrivals',
                          style: AppTextStyle.body(
                              color: AppColor.black,
                              size: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Summer 25 Collections',
                          style: AppTextStyle.body(
                              size: 18,
                              color: AppColor.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    SizedBox(width: 40),
                    Container(
                      height: 30,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor.primaryColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductShop(
                                          user: widget.user,
                                        )));
                          },
                          child: Row(
                            children: [
                              Text('View All',
                                  style: AppTextStyle.body(
                                      size: 12,
                                      color: AppColor.white,
                                      fontWeight: FontWeight.w500)),
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
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sponsored',
                    style: AppTextStyle.body(
                        size: 22, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Image(
                    image: AssetImage(AppImages.maskg),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'up to 50% Off',
                        style: AppTextStyle.body(size: 18),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Search any product',
            hintStyle:
                AppTextStyle.body(size: 14, fontWeight: FontWeight.normal),
            prefixIcon: Icon(Icons.search_rounded),
            suffixIcon: Icon(Icons.mic_none_rounded),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}
