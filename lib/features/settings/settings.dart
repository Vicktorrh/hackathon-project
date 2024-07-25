import 'package:flutter/material.dart';
import 'package:hackathanproject/apis/auth.dart';
import 'package:hackathanproject/features/welcome_back/welcome_back.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(height: 500),
              AppButton(
                  text: 'Logout',
                  onTap: () {
                    AuthService().logout(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
