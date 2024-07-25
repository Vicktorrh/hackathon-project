import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hackathanproject/apis/auth.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/constant/app_image.dart';
import 'package:hackathanproject/features/create_account/provider/provider.dart';
import 'package:hackathanproject/global_widget/loading.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';
import 'package:hackathanproject/features/welcome_back/welcome_back.dart';
import 'package:provider/provider.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(builder: (context, authProvider, _) {
        return isLoading
            ? const Loading()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80),
                      Text(
                        'Create an \naccount',
                        style: AppTextStyle.body(size: 40),
                      ),
                      const SizedBox(height: 50),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            AppTextField(
                              controller: emailController,
                              hintText: 'Username or Email',
                              isUsername: true,
                              validator: (data) {
                                if (data == null || data.isEmpty) {
                                  return 'username or email field is required';
                                } else if (data.length < 3) {
                                  return 'The username or email is less than the required length';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 30),
                            AppTextField(
                              controller: passwordController,
                              hintText: 'Password',
                              isPassword: true,
                              validator: (data) {
                                if (data == null || data.isEmpty) {
                                  return 'Password is required';
                                } else if (data.length < 6) {
                                  return 'Password length requirement is not met';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 30),
                            AppTextField(
                                controller: confirmpasswordController,
                                hintText: 'Confirm Password',
                                isPassword: true,
                                validator: (data) {
                                  if (data == null || data.isEmpty) {
                                    return 'Please confirm your password';
                                  } else if (data != passwordController.text) {
                                    return 'Password entered does not match';
                                  } else {
                                    return null;
                                  }
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'By clicking the',
                                style: AppTextStyle.body(size: 12)),
                            TextSpan(
                              text: ' Register',
                              style: AppTextStyle.body(
                                  color: Colors.red, size: 12),
                            ),
                            TextSpan(
                                text:
                                    ' button, you agree \nto the public offer!',
                                style: AppTextStyle.body(size: 12)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      AppButton(
                          text: 'Create Account',
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              await authProvider.SignUpWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  context: context);
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }),
                      const SizedBox(height: 40),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '- OR Continue with -',
                          style: AppTextStyle.body(size: 12),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await AuthService()
                                  .signInWithEmailProvider(context);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColor.primaryColor),
                                  color:
                                      const Color.fromARGB(255, 222, 211, 214),
                                  image: DecorationImage(
                                      image: AssetImage(AppImages.google)),
                                  shape: BoxShape.circle),
                            ),
                          ),
                          const SizedBox(width: 9),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColor.primaryColor),
                                color: const Color.fromARGB(255, 222, 211, 214),
                                image: DecorationImage(
                                    image: AssetImage(AppImages.apple)),
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 9),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColor.primaryColor),
                                color: const Color.fromARGB(255, 222, 211, 214),
                                image: DecorationImage(
                                    image: AssetImage(AppImages.facebook)),
                                shape: BoxShape.circle),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: 'I Already Have an Account',
                                  style: AppTextStyle.body(size: 14)),
                              TextSpan(
                                text: ' Login',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const WelcomeBack()));
                                  },
                                style: AppTextStyle.body(
                                    color: AppColor.primaryColor, size: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
