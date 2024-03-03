import 'package:flutter/material.dart';
import 'package:orderez/Widget/ListTileComponent.dart';
import 'package:orderez/view/ListMenu.dart';
import 'package:orderez/view/Pesanan.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({
    super.key,
    required this.nums,
  });

  final int nums;

  // Switch(nums);

  @override
  Widget build(BuildContext context) {
    var listbool = [false, false];

    listbool[nums - 1] = true;

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/images/bg.png'),
                opacity: 90,
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 230.0,
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
                    selected: listbool[0],
                    name: 'Pesanan',
                    icons: Icon(Icons.note_alt_rounded),
                    destination: Pesanan(),
                  ),
                  ListtilComponent(
                    selected: listbool[1],
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
    );
  }
}
