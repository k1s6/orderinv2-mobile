import 'package:flutter/material.dart';
import 'package:orderez/Widget/TextFieldDetails.dart';
import 'package:orderez/Widget/TextFieldEdit.dart';

class EditMenu extends StatefulWidget {
  const EditMenu({
    super.key,
    required this.idprod,
    required this.name,
    required this.jenis,
  });

  final String idprod;
  final String name;
  // final String price;
  // final String stock;
  final String jenis;

  @override
  State<EditMenu> createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 47, 47, 47),
        title: const Padding(
            padding: EdgeInsets.only(left: 50),
            child: Text(
              'Detail Menu',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
      ),
      body: BodyOfEditMenu(
        idprod: widget.idprod,
        name: widget.name,
        jenis: widget.jenis,
      ),
    );
  }
}

class BodyOfEditMenu extends StatefulWidget {
  const BodyOfEditMenu({
    super.key,
    required this.idprod,
    required this.name,
    required this.jenis,
  });

  final String idprod;
  final String name;
  final String jenis;

  @override
  State<BodyOfEditMenu> createState() => _BodyOfEditMenu();
}

class _BodyOfEditMenu extends State<BodyOfEditMenu> {

  late TextEditingController nameController;
  late TextEditingController hargaController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: widget.name);
    hargaController = TextEditingController();
  }

  final ListMenuItems = [
    DropdownMenuItem(
      child: Text('Makanan'),
      value: "Makanan",
    ),
    DropdownMenuItem(
      child: Text('Minuman'),
      value: "Minuman",
    ),
    DropdownMenuItem(
      child: Text('Snack'),
      value: "Snack",
    ),
    DropdownMenuItem(
      child: Text('Steak'),
      value: "Steak",
    ),
  ];

  String categoryValue = "Makanan";

  @override
  Widget build(BuildContext context) {
    categoryValue = widget.jenis;


    return SingleChildScrollView(
      child: Column(
        children: [
          const Icon(
            Icons.image,
            size: 170,
          ),
          const Text(
            'Edit',
            style: TextStyle(color: Colors.blue),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text('nama'),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: TextFieldEdit(
                    controller: nameController,
                    hintxt: widget.name,
                  )),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text('harga'),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: TextFieldDetails(
                    controller: hargaController,
                  )),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text('Jenis'),
                SizedBox(
                  width: 20,
                ),
                DropdownButton(
                    items: ListMenuItems,
                    value: categoryValue,
                    onChanged: (val) {
                      setState(() {
                        categoryValue = val.toString();
                      });
                    }),
              ],
            ),
          ),
          SizedBox(height: 100),
          TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {},
              child: const Text('Tambah'))
        ],
      ),
    );
  }
}
