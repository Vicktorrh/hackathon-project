import 'package:flutter/material.dart';
import 'package:hackathanproject/apis/auth.dart';
import 'package:hackathanproject/features/create_account/provider/provider.dart';
import 'package:hackathanproject/features/splashscreen/splashscreen1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hackathanproject/firebase_options.dart';
import 'package:hackathanproject/global_widget/loading.dart';
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
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: AuthService().firebaseAuth.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            } else if (snapshot.hasData) {
              return Home();
            } else {
              return Splashscreen1();
            }
          }),
    );
  }
}
