import 'package:flutter/material.dart';
import 'package:viva_store/screens/admin_dashboard.dart';
import 'package:viva_store/screens/category_management.dart';
import 'package:viva_store/screens/login.dart';
import 'package:viva_store/config/color_palette.dart';
import 'package:viva_store/screens/product_management.dart';
import 'package:viva_store/screens/product_management2.dart';

void main() {
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
      home: ProductManagment(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const <Widget>[
//             Text(
//               'Viva Store',
//             ),
//           ],
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {},
//       //   tooltip: 'Increment',
//       //   child: const Icon(Icons.add),
//       // ),
//     );
//   }
// }
