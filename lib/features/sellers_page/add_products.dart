import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathanproject/apis/add_category_endpoint.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/core/appcore.dart';
import 'package:hackathanproject/core/snackbar.dart';
import 'package:hackathanproject/features/welcome_back/welcome_back.dart';
import 'package:hackathanproject/global_widget/loading.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';
import 'package:image_picker/image_picker.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  TextEditingController productName = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController price = TextEditingController();
  File? image;
  String productCategory = 'Men';
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Loading()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      'Add Products',
                      style: AppTextStyle.body(size: 30),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Pick Image',
                                    style: AppTextStyle.body(
                                        fontWeight: FontWeight.normal)),
                                actions: [
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColor.primaryColor),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            setState(() {
                                              image = null;
                                            });
                                            var img = await AppCore.pickImage(
                                                ImageSource.camera);
                                            if (img != null) {
                                              setState(() {
                                                image = img;
                                              });
                                            }
                                          },
                                          child: Text('Camera',
                                              style: AppTextStyle.body(
                                                  fontWeight: FontWeight.normal,
                                                  size: 14,
                                                  color: AppColor.black))),
                                      const SizedBox(width: 60),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColor.primaryColor,
                                          ),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            setState(() {
                                              image = null;
                                            });
                                            var img = await AppCore.pickImage(
                                                ImageSource.gallery);
                                            if (img != null) {
                                              setState(() {
                                                image = img;
                                              });
                                            }
                                          },
                                          child: Text('Gallery',
                                              style: AppTextStyle.body(
                                                  fontWeight: FontWeight.normal,
                                                  size: 14,
                                                  color: AppColor.black))),
                                    ],
                                  ),
                                ],
                              );
                            });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.grey,
                            image: image != null
                                ? DecorationImage(image: FileImage(image!))
                                : null),
                        child: Text(
                          image == null ? 'click to upload image' : '',
                          style: AppTextStyle.body(
                              size: 14, color: AppColor.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: productName,
                            validator: (data) {
                              if (data == null || data.isEmpty) {
                                return 'Please input your product name';
                              } else {
                                return null;
                              }
                            },
                            style: AppTextStyle.body(
                                size: 13, fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                                hintText: 'Product Name',
                                hintStyle: AppTextStyle.body(
                                    size: 13, fontWeight: FontWeight.normal),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 243, 242, 242),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: productDescription,
                            validator: (data) {
                              if (data == null || data.isEmpty) {
                                return 'Please input your product description';
                              } else {
                                return null;
                              }
                            },
                            maxLines: 5,
                            style: AppTextStyle.body(
                                size: 13, fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                                hintText: 'Product Description',
                                hintStyle: AppTextStyle.body(
                                    size: 13, fontWeight: FontWeight.normal),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 243, 242, 242),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                          const SizedBox(height: 30),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                                fillColor:
                                    const Color.fromARGB(255, 243, 242, 242),
                                border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: AppColor.grey),
                                    borderRadius: BorderRadius.circular(8))),
                            value: productCategory,
                            borderRadius: BorderRadius.circular(10),
                            hint: const Text(
                                'Please select your product category'),
                            style: AppTextStyle.body(
                                color: AppColor.black,
                                fontWeight: FontWeight.normal,
                                size: 13),
                            items: ['Men', 'Women', 'Kids', 'Beauty', 'Fashion']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (o) {
                              setState(() {
                                productCategory = o!;
                              });
                            },
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: price,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            validator: (data) {
                              if (data == null || data.isEmpty) {
                                return 'Please input the price';
                              } else {
                                return null;
                              }
                            },
                            style: AppTextStyle.body(
                                size: 13, fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                                hintText: 'Price',
                                hintStyle: AppTextStyle.body(
                                    size: 13, fontWeight: FontWeight.normal),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 243, 242, 242),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 70),
                    AppButton(
                        text: 'Submit',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            if (image != null) {
                              setState(() {
                                isLoading = true;
                              });
                              await AddProductsEndpoint().addProducts(
                                productName.text,
                                productDescription.text,
                                price.text,
                                image!,
                                productCategory,
                              );
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              AppSnackBar.error(context, 'Image is empty');
                            }
                          }
                        }),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
    );
  }
}
