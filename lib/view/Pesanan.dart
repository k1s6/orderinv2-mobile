import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:orderez/Widget/DrawerComponent.dart';
import 'package:orderez/Widget/ListTileComponent.dart';
import 'package:orderez/pages/PageBatalkan.dart';
import 'package:orderez/pages/PageKonfirmasi.dart';
import 'package:orderez/view/ListMenu.dart';
import 'package:orderez/pages/PagePesanan.dart';

class Pesanan extends StatefulWidget {
  const Pesanan({super.key});

  @override
  State<Pesanan> createState() => _PesananState();
}

class _PesananState extends State<Pesanan> {
  TabBar get _tabBar => const TabBar(
        tabs: [
          Tab(text: 'Diterima'),
          Tab(text: 'Dibatalkan'),
          Tab(text: 'Dikonfirmasi'),
        ],
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
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: const Color.fromARGB(255, 47, 47, 47),
            title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 84),
                child: Text(
                  'Pesanan',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: const Color.fromARGB(255, 255, 206, 64),
                child: _tabBar,
              ),
            ),
          ),
          drawer: DrawerComponent(nums: 1),
          body: const TabBarView(children: [
            PagePesanan(),
            PageBatalkan(),
            PageKonfirmasi(),
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
