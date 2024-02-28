import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:orderez/Widget/ListTileComponent.dart';
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
        indicatorColor: Colors.yellow,
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
                  style: TextStyle(color: Colors.white),
                )),
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: const Color.fromARGB(255, 246, 246, 246),
                child: _tabBar,
              ),
            ),
          ),
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 200.0,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 229, 175, 16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            size: 90,
                          ),
                          Text(
                            'Gua Admin',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ListtilComponent(
                        selected: true,
                        name: 'Pesanan',
                        icons: Icon(Icons.note_alt_rounded),
                        destination: Pesanan(),
                      ),
                      ListtilComponent(
                        selected: false,
                        name: 'List Menu',
                        icons: Icon(Icons.menu_book_rounded),
                        destination: ListMenu(),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    // Handle logout action
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
          body: const TabBarView(children: [
            PagePesanan(),
            PlaceholderPage(),
            PlaceholderPage(),
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
