import 'package:flutter/material.dart';
import 'package:orderez/Widget/DrawerComponent.dart';

class ListMenu extends StatefulWidget {
  const ListMenu({super.key});

  @override
  State<ListMenu> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListMenu> {
  TabBar get _tabBar => const TabBar(
        tabs: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text('Makanan')],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text('Minuman')],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text('Snack')],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text('Steak')],
          ),
          // Tab(text: 'Minuman'),
          // Tab(text: 'Snack'),
          // Tab(text: 'Steak'),
        ],
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black,
        // indicator: BoxDecoration(
        //     color: Color.fromARGB(255, 229, 175, 16),
        //     // border: Border.all(width: 1, color: Colors.black54),
        //     borderRadius: BorderRadius.all(Radius.circular(10))),
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
              MakananPage(),
              MinumanScreen(),
              SnackScreen(),
              SteakScreen(),
            ]),
            floatingActionButton: FloatingActionButton(
                child: Image.asset('lib/images/btn_add.png'),
                onPressed: () {
                  print('test button');
                }),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          ),
        ));
  }
}

class MakananScreen extends StatelessWidget {
  const MakananScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Tabs Makanan'),
    );
  }
}

class MakananPage extends StatelessWidget {
  const MakananPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        padding: const EdgeInsets.all(5),
        crossAxisCount: 2,
        children: List.generate(15, (index) {
          return _buildCard('Tahu Goreng', 'Rp. 5000');
        }),
      ),
    );
  }

  Widget _buildCard(String name, String price) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Card(
        margin: const EdgeInsets.all(3),
        child: InkWell(
          onTap: () {},
          splashColor: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'lib/images/tahugoreng.jpg',
                  width: 90,
                  height: 90,
                ),
                Text(name, style: const TextStyle(fontSize: 12.0)),
                Text(price, style: const TextStyle(fontSize: 12.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MinumanScreen extends StatelessWidget {
  const MinumanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuPlaceholder(
      categoriesMenu: "Minuman",
    );
  }
}

class SnackScreen extends StatelessWidget {
  const SnackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Tabs Snack'),
    );
  }
}

class SteakScreen extends StatelessWidget {
  const SteakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Tabs Steak'),
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
