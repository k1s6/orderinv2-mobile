import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderez/Widget/TextFieldComponent.dart';
import 'package:orderez/view/ListMenu.dart';

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
              'Tambah Menu',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
      ),
      body: BodyOfTambahMenu(),
    );
  }
}

class BodyOfTambahMenu extends StatefulWidget {
  const BodyOfTambahMenu({super.key});

  @override
  State<BodyOfTambahMenu> createState() => _BodyOfTambahMenuState();
}

class _BodyOfTambahMenuState extends State<BodyOfTambahMenu> {
  final nameController = TextEditingController();
  final hargaController = TextEditingController();

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
    return Column(
      children: [
        const Icon(
          Icons.image,
          size: 170,
        ),
        const Text('Edit'),
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
                    child: TextFieldDetails(
                  controller: nameController,
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
      ],
    );
  }
}

class TextFieldDetails extends StatelessWidget {
  const TextFieldDetails({super.key, required this.controller});

  final controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center,

          // textAlign: TextAlign.center,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          )),
    );
  }
}
