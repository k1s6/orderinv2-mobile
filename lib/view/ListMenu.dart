import 'package:flutter/material.dart';
import 'package:orderez/Widget/DrawerComponent.dart';
import 'package:orderez/pages/PageListMakanan.dart';
import 'package:orderez/pages/PageListMinuman.dart';
import 'package:orderez/pages/PageListSnack.dart';
import 'package:orderez/pages/PageListSteak.dart';
import 'package:orderez/theme.dart';
import 'package:orderez/view/DetailMenu.dart';

class ListMenu extends StatefulWidget {
  final int initialTabIndex;

  const ListMenu({super.key, required this.initialTabIndex});

  @override
  State<ListMenu> createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.index = widget.initialTabIndex;
  }

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        tabs: [
          Tab(text: 'Makanan'),
          Tab(text: 'Minuman'),
          Tab(text: 'Snack'),
          Tab(text: 'Steak'),
        ],
        indicatorColor: yellowdark,
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
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: const Color.fromARGB(255, 47, 47, 47),
              title: const Text(
                'Daftar Menu',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Container(
                  height: 60,
                  child: Material(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        height: 44, // Adjust the height as needed
                        child: _tabBar,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            drawer: DrawerComponent(nums: 2),
            body: TabBarView(controller: _tabController, children: [
              PageMakanan(
                onShowMessage: (String message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              PageMinuman(
                onShowMessage: (String message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              PageSnack(
                onShowMessage: (String message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              PageSteak(
                onShowMessage: (String message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
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
        ));
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
