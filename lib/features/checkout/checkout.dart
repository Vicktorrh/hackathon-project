import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathanproject/apis/user_products.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/core/snackbar.dart';
import 'package:hackathanproject/features/checkout/order_confirmation.dart';
import 'package:hackathanproject/features/welcome_back/welcome_back.dart';
import 'package:hackathanproject/global_widget/loading.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  TextEditingController cvv = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController cardNumber = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 240, 240),
      body: isLoading
          ? Loading()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                        return Container(
                          child: Column(
                            children: [
                              SizedBox(height: 70),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.arrow_back_ios_new)),
                                  SizedBox(width: 120),
                                  Text('Checkout', style: AppTextStyle.body()),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined),
                                  SizedBox(width: 20),
                                  Text('Delivery Address',
                                      style: AppTextStyle.body(size: 15)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    hintText: 'Address line 1',
                                    hintStyle: AppTextStyle.body(
                                        fontWeight: FontWeight.normal,
                                        size: 12)),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    hintText: 'Address line 2',
                                    hintStyle: AppTextStyle.body(
                                        fontWeight: FontWeight.normal,
                                        size: 12)),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    hintText: 'City',
                                    hintStyle: AppTextStyle.body(
                                        fontWeight: FontWeight.normal,
                                        size: 12)),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    hintText: 'Region',
                                    hintStyle: AppTextStyle.body(
                                        fontWeight: FontWeight.normal,
                                        size: 12)),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    hintText: 'Phone Number',
                                    hintStyle: AppTextStyle.body(
                                        fontWeight: FontWeight.normal,
                                        size: 12)),
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text('Shopping List',
                                      style: AppTextStyle.body(size: 15)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(
                                height: 300,
                                child: ListView.builder(
                                    itemCount: listOfDoc.length,
                                    itemBuilder: (context, index) {
                                      var product = listOfDoc[index].data();
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                          height: 120,
                                          decoration: BoxDecoration(
                                              color: AppColor.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: 100,
                                                  child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl: product[
                                                          'productUrl'])),
                                              SizedBox(width: 6),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                              product[
                                                                  'productName'],
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: AppTextStyle
                                                                  .body(
                                                                      size: 16),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 180,
                                                      child: Text(
                                                          product[
                                                              'productDescription'],
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: AppTextStyle.body(
                                                              size: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
                                                    ),
                                                    SizedBox(height: 7),
                                                    Row(
                                                      children: [
                                                        Text(
                                                            "\$ ${product['totalPrice'].toString()}",
                                                            style: AppTextStyle
                                                                .body(
                                                                    size: 14)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Text(
                                    'Order',
                                    style: AppTextStyle.body(
                                        fontWeight: FontWeight.normal,
                                        size: 16,
                                        color: AppColor.grey),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$ ${5000}",
                                    style: AppTextStyle.body(
                                        size: 16,
                                        fontWeight: FontWeight.normal,
                                        color: AppColor.grey),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    'Shipping',
                                    style: AppTextStyle.body(
                                        fontWeight: FontWeight.normal,
                                        size: 16,
                                        color: AppColor.grey),
                                  ),
                                  Spacer(),
                                  Text(
                                    '\$ ${100}',
                                    style: AppTextStyle.body(
                                        fontWeight: FontWeight.normal,
                                        size: 16,
                                        color: AppColor.grey),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    'Total',
                                    style: AppTextStyle.body(
                                        fontWeight: FontWeight.normal,
                                        size: 16),
                                  ),
                                  Spacer(),
                                  Text(
                                    '\$ ${10000}',
                                    style: AppTextStyle.body(
                                        fontWeight: FontWeight.normal,
                                        size: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    'Payment',
                                    style: AppTextStyle.body(
                                        fontWeight: FontWeight.normal,
                                        size: 18),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Input your credit/debit card informtaion',
                                style: AppTextStyle.body(
                                    fontWeight: FontWeight.normal, size: 14),
                              ),
                              SizedBox(height: 10),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: name,
                                      validator: (data) {
                                        if (data == null || data.isEmpty) {
                                          return 'Please input your name';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          hintText: 'Name on the card',
                                          labelStyle:
                                              AppTextStyle.body(size: 10),
                                          hintStyle: AppTextStyle.body(
                                              fontWeight: FontWeight.normal,
                                              size: 12)),
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      maxLength: 19,
                                      controller: cardNumber,
                                      validator: (data) {
                                        if (data == null || data.isEmpty) {
                                          return 'Please input your card number';
                                        } else {
                                          return null;
                                        }
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          hintText: 'Card Number',
                                          hintStyle: AppTextStyle.body(
                                              fontWeight: FontWeight.normal,
                                              size: 12)),
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      maxLength: 3,
                                      controller: cvv,
                                      validator: (data) {
                                        if (data == null || data.isEmpty) {
                                          return 'Please input your card cvv';
                                        } else {
                                          return null;
                                        }
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          hintText: 'CVV',
                                          hintStyle: AppTextStyle.body(
                                              fontWeight: FontWeight.normal,
                                              size: 12)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                    fillColor: const Color.fromARGB(
                                        255, 243, 242, 242),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: AppColor.grey),
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                borderRadius: BorderRadius.circular(10),
                                hint: const Text('Exp Month'),
                                style: AppTextStyle.body(
                                    color: AppColor.black,
                                    fontWeight: FontWeight.normal,
                                    size: 13),
                                items: [
                                  '01',
                                  '02',
                                  '03',
                                  '04',
                                  '05',
                                  '06',
                                  '07',
                                  '08',
                                  '09',
                                  '10',
                                  '11',
                                  '12'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (v) {},
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                    fillColor: const Color.fromARGB(
                                        255, 243, 242, 242),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: AppColor.grey),
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                borderRadius: BorderRadius.circular(10),
                                hint: const Text('Exp Year'),
                                style: AppTextStyle.body(
                                    color: AppColor.black,
                                    fontWeight: FontWeight.normal,
                                    size: 13),
                                items: [
                                  '2024',
                                  '2025',
                                  '2026',
                                  '2027',
                                  '2028',
                                  '2029',
                                  '2030',
                                  '2031',
                                  '2032',
                                  '2033',
                                  '2034',
                                  '2035'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (v) {},
                              ),
                              SizedBox(height: 30),
                              AppButton(
                                  text: 'Confirm Order',
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await UserProducts().addOrder(listOfDoc);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OrderConfirmation()));
                                    } else {
                                      AppSnackBar.error(context,
                                          'Please fill in the required information');
                                    }
                                  }),
                              SizedBox(height: 40)
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
            ),
    );
  }
}
