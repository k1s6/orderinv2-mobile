import 'package:flutter/material.dart';
import 'package:orderez/Widget/ListTileComponent.dart';
import 'package:orderez/view/ListMenu.dart';
import 'package:orderez/view/LoginUser.dart';
import 'package:orderez/view/Pesanan.dart';
import 'package:orderez/view/Laporan.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({
    super.key,
    required this.nums,
  });

  final int nums;

  // Switch(nums);

  Future<void> confirmLogout(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Apakah Anda yakin ingin logout?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Batal'),
              ),
              TextButton(
                onPressed: () async {
                  // Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginUser()));
                },
                child: Text('Keluar'),
              ),
            ],
          );
        });
  }

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
                        'Admin',
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
                  const SizedBox(
                    height: 4,
                  ),
                  ListtilComponent(
                    selected: listbool[1],
                    name: 'List Menu',
                    icons: Icon(Icons.menu_book_rounded),
                    destination: ListMenu(
                      initialTabIndex: 0,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  ListtilComponent(
                    selected: listbool[1], 
                    name: 'Laporan', 
                    icons: Icon(Icons.folder_rounded), 
                    destination: Laporan(
                      initialTabIndex: 0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.redAccent),
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  // Handle logout action
                  confirmLogout(context);
                  // Navigator.pop(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => LoginUser()));
                },
              ),
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
