import 'package:flutter/material.dart';
import 'package:hackathanproject/apis/auth.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/core/snackbar.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';
import 'package:hackathanproject/features/welcome_back/welcome_back.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text('Forgot \nPassword?', style: AppTextStyle.body(size: 40)),
              SizedBox(height: 40),
              AppTextField(
                  controller: emailController,
                  hintText: 'Enter your email address',
                  isEmail: true),
              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: '* ',
                        style: AppTextStyle.body(size: 12, color: Colors.red)),
                    TextSpan(
                      text:
                          ' We will send you a message to set or reset \nyour new password',
                      style: AppTextStyle.body(color: AppColor.black, size: 12),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              AppButton(
                  text: 'Submit',
                  onTap: () async {
                    if (emailController.text.isEmpty ||
                        !emailController.text.contains('@') ||
                        !emailController.text.contains('.')) {
                      AppSnackBar.error(context, 'Enter a valid email');
                      return;
                    }
                    setState(() {
                      isLoading = true;
                    });
                    await AuthService()
                        .forgotPassword(context, emailController.text);
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => WelcomeBack()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
