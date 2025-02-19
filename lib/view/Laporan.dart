import 'package:flutter/material.dart';
import 'package:orderez/Widget/DrawerComponent.dart';
import 'package:orderez/theme.dart';

class Laporan extends StatefulWidget {
  final int initialTabIndex;

  const Laporan({super.key, required this.initialTabIndex});


  @override
  State<Laporan> createState() => _LaporanState();
}

class _LaporanState extends State<Laporan>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: const Color.fromARGB(255, 47, 47, 47),
            title: const Text(
              'Laporan',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          drawer: DrawerComponent(nums: 1),
          ),
      ),
    );
  }
}