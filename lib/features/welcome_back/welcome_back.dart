import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hackathanproject/apis/auth.dart';
import 'package:hackathanproject/constant/app_color.dart';
import 'package:hackathanproject/constant/app_image.dart';
import 'package:hackathanproject/features/create_account/create_account.dart';
import 'package:hackathanproject/features/forgot_password/forgot_password.dart';
import 'package:hackathanproject/global_widget/loading.dart';
import 'package:hackathanproject/text_styles/text_styles.dart';
import 'package:hackathanproject/widget/button_nav.dart';
import 'package:hackathanproject/widget/nav_provider.dart';
import 'package:provider/provider.dart';

class WelcomeBack extends StatefulWidget {
  const WelcomeBack({super.key});

  @override
  State<WelcomeBack> createState() => _WelcomeBackState();
}

class _WelcomeBackState extends State<WelcomeBack> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Loading()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      'Welcome \nBack!',
                      style: AppTextStyle.body(size: 40),
                    ),
                    const SizedBox(height: 25),
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
                                return 'Please input your email';
                              } else if (!emailController.text.contains('@') ||
                                  !emailController.text.contains('.')) {
                                return 'The email is not valid';
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
                                return 'Please input your password';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPassword()));
                        },
                        child: Text(
                          'Forgot Password?',
                          style: AppTextStyle.body(
                              color: AppColor.primaryColor, size: 12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    AppButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          var user = await AuthService()
                              .signInWithEmailAndPassword(
                                  context,
                                  emailController.text,
                                  passwordController.text);

                          setState(() {
                            isLoading = false;
                          });
                          print(user);

                          if (user != null) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                                (r) => false);
                          }
                        }
                      },
                      text: 'Login',
                    ),
                    const SizedBox(height: 80),
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
                                color: const Color.fromARGB(255, 222, 211, 214),
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
                              border: Border.all(color: AppColor.primaryColor),
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
                              border: Border.all(color: AppColor.primaryColor),
                              color: const Color.fromARGB(255, 222, 211, 214),
                              image: DecorationImage(
                                  image: AssetImage(AppImages.facebook)),
                              shape: BoxShape.circle),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Create An Account',
                                style: AppTextStyle.body(size: 14)),
                            TextSpan(
                              text: ' Sign Up',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateAccount()));
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
            ),
    );
  }
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          text,
          style: AppTextStyle.body(size: 20, color: AppColor.white),
        ),
      ),
    );
  }
}

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final bool isPassword;
  final bool isUsername;
  final bool isEmail;
  const AppTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.isEmail = false,
    this.isUsername = false,
    required this.controller,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        obscureText: widget.isPassword ? isObscure : false,
        validator: widget.validator,
        controller: widget.controller,
        style: AppTextStyle.body(size: 13, fontWeight: FontWeight.normal),
        decoration: InputDecoration(
            hintStyle:
                AppTextStyle.body(size: 12, fontWeight: FontWeight.normal),
            hintText: widget.hintText,
            prefixIcon: widget.isPassword
                ? const Icon(Icons.lock)
                : widget.isUsername
                    ? const Icon(Icons.person_rounded)
                    : widget.isEmail
                        ? const Icon(Icons.email)
                        : null,
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    child: Icon(isObscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                  )
                : null,
            contentPadding: const EdgeInsets.only(left: 20),
            fillColor: const Color.fromARGB(255, 243, 242, 242),
            filled: true,
            border: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 199, 196, 196)),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}
