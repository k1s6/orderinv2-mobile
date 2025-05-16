import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderez/koneksi/Firestoreget.dart';
import 'package:orderez/koneksi/ListPage.dart';
import 'package:orderez/utils/Utils.dart';
import 'package:orderez/view/ListMenu.dart';
import 'package:orderez/view/Login.dart';
import 'package:orderez/view/Login2.dart';
import 'package:orderez/view/LoginUser.dart';
// import 'package:orderez/koneksi/Lis';
import 'package:orderez/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orderez/view/Pesanan.dart';
import 'package:orderez/view/splashscreen.dart';
import 'package:orderez/view/Laporan.dart';
import 'package:intl/date_symbol_data_local.dart'; // Import for locale initialization
import 'pages/PageLaporanPenjualan.dart'; // Import your page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(
      'id_ID', null); // Initialize locale for Indonesian
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
        // home: ListMenu(initialTabIndex: 0,),
        home: Laporan(initialTabIndex: 0)
        // home: SplashScreen()
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
