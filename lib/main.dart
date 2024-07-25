import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:hackathanproject/core/secure_storage.dart';
import 'package:hackathanproject/features/create_account/provider/provider.dart';
import 'package:hackathanproject/features/splashscreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hackathanproject/features/welcome_back/welcome_back.dart';
import 'package:hackathanproject/firebase_options.dart';
import 'package:hackathanproject/global_widget/loading.dart';
import 'package:hackathanproject/model/users_provider.dart';
import 'package:hackathanproject/widget/button_nav.dart';
import 'package:hackathanproject/widget/nav_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => NavProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => AllUsersProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AllUsersProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<auth.User?>(
        stream: auth.FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasData) {
            return const Home();
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Column(
                  children: [Text('Check your data connection')],
                ),
              ),
            );
          } else {
            return FutureBuilder(
                future: AppStorage().getSaveOnBoard(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const LoadingScreen();
                  } else if (snap.hasData) {
                    print(snap.data);
                    if (snap.data != null && snap.data == 'true') {
                      return const WelcomeBack();
                    } else {
                      return const Splashscreen();
                    }
                  } else {
                    return const Splashscreen();
                  }
                });
          }
        },
      ),
    );
  }
}
