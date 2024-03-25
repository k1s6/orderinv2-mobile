import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderez/koneksi/Koneksi.dart';
import 'package:orderez/view/LoginUser.dart';
// import 'package:orderez/view/DetailMenu.dart';
// import 'package:orderez/view/ListMenu.dart';
// import 'package:orderez/view/LoginUser.dart';
import 'package:orderez/view/Pesanan.dart';
// import 'package:orderez/view/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Orderin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade300),
        useMaterial3: true,
      ),
      home: LoginUser(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderez/view/ListMenu.dart';
// import 'package:orderez/view/DetailMenu.dart';
// import 'package:orderez/view/ListMenu.dart';
import 'package:orderez/view/LoginUser.dart';
import 'package:orderez/view/splashscreen.dart';
// import 'package:orderez/view/Pesanan.dart';
// import 'package:orderez/view/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Orderin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade300),
        useMaterial3: true,
      ),
      home: ListMenu(),
    );
  }
}
