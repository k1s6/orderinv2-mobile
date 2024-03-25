import 'package:flutter/material.dart';
import 'package:orderez/Widget/DrawerComponent.dart';
import 'package:orderez/pages/PageListMinuman.dart';
import 'package:orderez/pages/PageListSnack.dart';
import 'package:orderez/pages/PageListSteak.dart';
import 'package:orderez/theme.dart';
import 'package:orderez/view/DetailMenu.dart';
import 'package:orderez/pages/PageListMakanan.dart';

class ListMenu extends StatefulWidget {
  const ListMenu({super.key});

  @override
  State<ListMenu> createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu> {
  TabBar get _tabBar => const TabBar(
        tabs: [
          Tab(text: 'Makanan'),
          Tab(text: 'Minuman'),
          Tab(text: 'Snack'),
          Tab(text: 'Steak'),
        ],
        indicatorColor: yellowdark ,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black,
        splashBorderRadius: BorderRadius.all(Radius.circular(10)),
      );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: const Color.fromARGB(255, 47, 47, 47),
              title: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 84),
                  child: Text(
                    'List Menu',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Container(
                  height: 60,
                  child: Material(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Expanded(child: _tabBar),
                    ),
                  ),
                ),
              ),
            ),
            drawer: DrawerComponent(nums: 2),
            body: const TabBarView(children: [
              PageMakanan(),
              PageMinuman(),
              PageSnack(),
              PageSteak()
            ]),
            floatingActionButton: FloatingActionButton(
                focusColor: Colors.yellow,
                backgroundColor: yellowdark,
                // child: Image.asset('lib/images/btn_add.png'),
                child: const Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailMenu()));
                }),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          ),
        )
      );
  }
}

class MenuPlaceholder extends StatefulWidget {
  final String categoriesMenu;
  const MenuPlaceholder({super.key, required this.categoriesMenu});

  // final String categories;

  @override
  State<MenuPlaceholder> createState() => MenuPlaceholderState();
}

class MenuPlaceholderState extends State<MenuPlaceholder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('data'),
            Text(widget.categoriesMenu),
          ],
        )
      ],
    );
  }
}
