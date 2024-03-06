import 'package:flutter/material.dart';

class DetailMenu extends StatefulWidget {
  const DetailMenu({super.key});

  @override
  State<DetailMenu> createState() => _DetailMenuState();
}

class _DetailMenuState extends State<DetailMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 47, 47, 47),
        title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 84),
            child: Text(
              'Tambah Menu',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
      ),
      body: const Center(
        child: Text('this is add menu page'),
      ),
    );
  }
}
