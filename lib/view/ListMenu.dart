import 'package:flutter/material.dart';

class ListMenu extends StatefulWidget {
  const ListMenu({super.key});

  @override
  State<ListMenu> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListMenu> {
  TabBar get _tabBar => const TabBar(
        tabs: [
          Tab(text: 'Makanan'),
          Tab(text: 'Minuman'),
          Tab(text: 'Snack'),
          Tab(text: 'Steak'),
        ],
        labelColor: Colors.black,
        indicatorColor: Colors.yellow,
      );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.yellowAccent,
              title: const Text('List Menu'),
              bottom: PreferredSize(
                preferredSize: _tabBar.preferredSize,
                child: Material(
                  color: Colors.greenAccent,
                  child: _tabBar,
                ),
              ),
            ),
            drawer: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text('Drawer Header'),
                  ),
                  ListTile(
                    title: const Text('Home'),
                    // selected: _selectedIndex == 0,
                    onTap: () {
                      // Update the state of the app
                      // _onItemTapped(0);
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Business'),
                    // selected: _selectedIndex == 1,
                    onTap: () {
                      // Update the state of the app
                      // _onItemTapped(1);
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('School'),
                    // selected: _selectedIndex == 2,
                    onTap: () {
                      // Update the state of the app
                      // _onItemTapped(2);
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            body: const TabBarView(children: [
              MakananScreen(),
              MinumanScreen(),
              SnackScreen(),
              SteakScreen(),
            ]),
          ),
        )

//         SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(10),
//             child: Column(
//               children: [
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text('Makanan'),
//                     Text('Minuman'),
//                     Text('Snack'),
//                     Text('Steak')
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Container(
//                       height: 10,
//                       width: 100,
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                               color: Colors.yellow,
//                               width: 2,
//                               style: BorderStyle.solid,
//                               strokeAlign: BorderSide.strokeAlignInside)),
//                     ),
//                     Container(
//                       height: 10,
//                       width: 100,
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                               color: Colors.yellow,
//                               width: 2,
//                               style: BorderStyle.solid,
//                               strokeAlign: BorderSide.strokeAlignInside)),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
        );
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
