import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orderez/Widget/ButtonDetailMenu.dart';
import 'package:orderez/Widget/ButtonLogs.dart';
import 'package:orderez/Widget/TextFieldDetails.dart';
import 'package:orderez/Widget/TextFieldEdit.dart';

class EditMenu extends StatefulWidget {
  const EditMenu({
    super.key,
    required this.idprod,
    required this.name,
    required this.jenis,
    required this.price,
    required this.deskripsi,
  });

  final String idprod;
  final String name;
  final String price;
  // final String stock;
  final String jenis;
  final String deskripsi;

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
        harga: widget.price,
        deskripsi: widget.deskripsi,
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
    required this.harga,
    required this.deskripsi,
  });

  final String idprod;
  final String name;
  final String jenis;
  final String harga;
  final String deskripsi;

  @override
  State<BodyOfEditMenu> createState() => _BodyOfEditMenu();
}

class _BodyOfEditMenu extends State<BodyOfEditMenu> {
  late TextEditingController nameController;
  late TextEditingController hargaController;
  late TextEditingController descController;
  bool isAvailable = false;
  bool light1 = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: widget.name);
    hargaController = TextEditingController(text: widget.harga);
    descController = TextEditingController(text: widget.deskripsi);
    categoryValue = widget.jenis;
  }

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

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
    // categoryValue = widget.jenis;

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
                const Text('status'),
                const SizedBox(
                  width: 20,
                ),
                Switch(
                  thumbIcon: thumbIcon,
                  value: light1,
                  onChanged: (bool value) {
                    setState(() {
                      light1 = value;
                    });
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  light1 ? 'Tersedia' : 'Habis',
                  style: TextStyle(
                    color: light1 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
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
                  const Text('deskripsi'),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: TextFieldDetails(
                    controller: descController,
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
          SizedBox(height: 170),
          Row(
            children: [
              SizedBox(
                width: 40,
              ),
              GestureDetector(
                onTap: () => {Fluttertoast.showToast(msg: "clicked")},
                child: const ButtonDetailMenu(
                  color: Colors.red,
                  btntype: "Hapus",
                ),
              ),
              Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () => {Fluttertoast.showToast(msg: "clicked")},
                child: const ButtonDetailMenu(
                  color: Colors.green,
                  btntype: "Perbarui",
                ),
              ),
              SizedBox(
                width: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SliderButton extends StatelessWidget {
  const SliderButton({Key? key, required this.isSliding, required this.onSlide})
      : super(key: key);

  final bool isSliding;
  final ValueChanged<bool> onSlide;

  @override
  Widget build(BuildContext context) {
    Color buttonColor = isSliding
        ? Colors.green
        : Colors.red; // Warna hijau jika isSliding true, warna merah jika false
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        double dx = details.localPosition.dx;
        if (dx < 0) dx = 0;
        if (dx > 43) dx = 43;
        double value = dx / 43;
        onSlide(value > 0.5);
      },
      child: Container(
        width: 43,
        height: 18,
        decoration: BoxDecoration(
          color: isSliding
              ? const Color.fromARGB(255, 158, 158, 158)
              : const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: isSliding ? 25 : 0,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color:
                      buttonColor, // Menggunakan warna sesuai kondisi isSliding
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
