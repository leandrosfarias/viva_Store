import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:viva_store/config/color_palette.dart';
import 'package:viva_store/screens/admin_dashboard.dart';
import 'package:viva_store/screens/login.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Viva Store',
      theme: ThemeData(
        // primarySwatch: Colors.blue, //#3a5f73
        primaryColor: ColorPalette.primaryColor,
        backgroundColor: ColorPalette.backgroundColor,
        // fontFamily: 'RobotoMono'
      ),
      home: const LoginScreen(),
    );
  }
}
