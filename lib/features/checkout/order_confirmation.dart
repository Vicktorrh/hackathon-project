import 'package:flutter/material.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/features/homepage/homepage.dart';
import 'package:hackathanproject/features/product/product_shop.dart';
import 'package:hackathanproject/features/welcome_back/welcome_back.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';

class OrderConfirmation extends StatefulWidget {
  const OrderConfirmation({super.key});

  @override
  State<OrderConfirmation> createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 240, 240),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 80),
              Row(
                children: [
                  Icon(Icons.done_all, size: 50, color: AppColor.primaryColor),
                  SizedBox(width: 12),
                  SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          'Thank you for placing an order on Stylish!',
                          style: AppTextStyle.body(
                              size: 16, fontWeight: FontWeight.normal),
                        ),
                        Text('Order No - 651763872121',
                            style: AppTextStyle.body(size: 15))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Icon(Icons.delivery_dining_sharp,
                  size: 100, color: AppColor.primaryColor),
              SizedBox(height: 10),
              Text('Delivery between 01 August and 02 August.',
                  style: AppTextStyle.body(size: 14)),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 50),
              AppButton(
                text: 'See Order Details',
                onTap: () {},
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text('Check out more products',
                    style: AppTextStyle.body(
                        color: AppColor.primaryColor, size: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
