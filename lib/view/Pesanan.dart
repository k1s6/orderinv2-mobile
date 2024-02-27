import 'package:flutter/material.dart';
import 'package:orderez/view/ListMenu.dart';

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
              title: const Text(
                'List Menu',
                style: TextStyle(color: Colors.white),
              ),
              bottom: PreferredSize(
                preferredSize: _tabBar.preferredSize,
                child: Material(
                  color: const Color.fromARGB(255, 246, 246, 246),
                  child: _tabBar,
                ),
              ),
            ),
            drawer: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 340.0,
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
                                size: 150,
                              ),
                              Text(
                                'Pramudya',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: const Text('Pesanan'),
                    // selected: _selectedIndex == 0,
                    onTap: () {
                      // Update the state of the app
                      // _onItemTapped(0);
                      // Then close the drawer
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ListMenu()));
                    },
                  ),
                  ListTile(
                    title: const Text('Kelola Menu'),
                    // selected: _selectedIndex == 1,
                    onTap: () {
                      // Update the state of the app
                      // _onItemTapped(1);
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
