import 'package:flutter/material.dart';
import 'package:orderin/Widget/DrawerComponent.dart';
import 'package:orderin/Widget/ListTileComponent.dart';
import 'package:orderin/theme.dart';
import 'package:orderin/pages/PageLaporanPenjualan.dart';
import 'package:orderin/pages/PageBestSeller.dart';

class Laporan extends StatefulWidget {
  final int initialTabIndex;

  const Laporan({super.key, required this.initialTabIndex});

  @override
  State<Laporan> createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  TabBar get _tabBar => const TabBar(
        tabs: [Tab(text: 'Laporan Penjualan'), Tab(text: 'Menu Best Seller')],
        labelColor: Colors.black,
        indicatorColor: Colors.black,
        unselectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        unselectedLabelColor: Colors.black87,
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
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
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: const Color.fromARGB(255, 255, 206, 64),
                child: _tabBar,
              ),
            ),
          ),
          drawer: DrawerComponent(nums: 3),
          body: TabBarView(children: [
            PageLaporanPenjualan(),
            PageBestSeller(),
          ]),
        ),
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('placeholder');
  }
}
