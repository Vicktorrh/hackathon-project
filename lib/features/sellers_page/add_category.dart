import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hackathanproject/apis/add_category_endpoint.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/core/appcore.dart';
import 'package:hackathanproject/core/snackbar.dart';
import 'package:hackathanproject/features/welcome_back/welcome_back.dart';
import 'package:hackathanproject/global_widget/loading.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';
import 'package:image_picker/image_picker.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController categoryName = TextEditingController();
  TextEditingController categoryDescription = TextEditingController();
  File? image;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Loading()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          Text(
                            'Add Category',
                            style: AppTextStyle.body(size: 30),
                          ),
                          SizedBox(height: 20),
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
                                                  var img =
                                                      await AppCore.pickImage(
                                                          ImageSource.camera);
                                                  if (img != null) {
                                                    setState(() {
                                                      image = img;
                                                    });
                                                  }
                                                },
                                                child: Text('Camera',
                                                    style: AppTextStyle.body(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        size: 14,
                                                        color:
                                                            AppColor.black))),
                                            SizedBox(width: 60),
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
                                                  var img =
                                                      await AppCore.pickImage(
                                                          ImageSource.gallery);
                                                  if (img != null) {
                                                    setState(() {
                                                      image = img;
                                                    });
                                                  }
                                                },
                                                child: Text('Gallery',
                                                    style: AppTextStyle.body(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        size: 14,
                                                        color:
                                                            AppColor.black))),
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
                                  shape: BoxShape.rectangle,
                                  color: AppColor.grey,
                                  borderRadius: BorderRadius.circular(8),
                                  image: image != null
                                      ? DecorationImage(
                                          image: FileImage(image!))
                                      : null),
                              child: Text(
                                image == null ? 'click to upload image' : '',
                                style: AppTextStyle.body(
                                    size: 14, color: AppColor.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                          TextFormField(
                            controller: categoryName,
                            validator: (data) {
                              if (data == null || data.isEmpty) {
                                return 'Please input your category name';
                              } else {
                                return null;
                              }
                            },
                            style: AppTextStyle.body(
                                size: 13, fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                                hintText: 'Category Name',
                                hintStyle: AppTextStyle.body(
                                    size: 13, fontWeight: FontWeight.normal),
                                filled: true,
                                fillColor: Color.fromARGB(255, 243, 242, 242),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            validator: (data) {
                              if (data == null || data.isEmpty) {
                                return 'Please write your product desctiption';
                              } else {
                                return null;
                              }
                            },
                            controller: categoryDescription,
                            maxLines: 5,
                            style: AppTextStyle.body(
                                size: 13, fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                                hintText: 'Category Description',
                                hintStyle: AppTextStyle.body(
                                    size: 13, fontWeight: FontWeight.normal),
                                filled: true,
                                fillColor: Color.fromARGB(255, 243, 242, 242),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                          SizedBox(height: 70),
                          AppButton(
                              text: 'Submit',
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (image != null) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await AddCategoryEndpoint().addCategory(
                                        categoryName.text,
                                        categoryDescription.text,
                                        image!);
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else {
                                    AppSnackBar.error(
                                        context, 'Image is empty');
                                  }
                                }
                              }),
                          SizedBox(height: 70),
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
