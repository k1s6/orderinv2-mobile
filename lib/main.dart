import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderez/koneksi/Firestoreget.dart';
import 'package:orderez/koneksi/ListPage.dart';
import 'package:orderez/utils/Utils.dart';
import 'package:orderez/view/ListMenu.dart';
import 'package:orderez/view/LoginUser.dart';
// import 'package:orderez/koneksi/Lis';
import 'package:orderez/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orderez/view/Pesanan.dart';
import 'package:orderez/view/splashscreen.dart';

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
      home: Pesanan(),
    );
  }
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
