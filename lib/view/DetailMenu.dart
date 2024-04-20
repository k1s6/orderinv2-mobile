import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:orderez/Widget/ButtonDetailMenu.dart';
import 'package:orderez/Widget/TextFieldComponent.dart';
import 'package:orderez/Widget/ButtonWidget.dart';
import 'package:orderez/Widget/TextFieldDetails.dart';
import 'package:orderez/Widget/TextFieldEdit.dart';
import 'package:orderez/configuration/Constant.dart';
import 'package:orderez/view/ListMenu.dart';
import 'package:http/http.dart' as http;

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
  final descController = TextEditingController();

  static Future<void> storeData(String nama, String harga, String deskripsi,
      String stock, String jenis, String gambar, BuildContext context) async {
    final String apiUrl = '${OrderinAppConstant.uploadURL}/store';

    try {
      // Kirim permintaan HTTP POST ke server
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          "nama_product": nama,
          "deskripsi": deskripsi,
          "stock_product": stock,
          "harga_product": harga,
          "jenis_product": jenis,
          "gambar_product": gambar
        }, // raw body
      );

      // Periksa status code respons dari server
      if (response.statusCode == 200) {

        // Decode respons JSON
        final responseData = json.decode(response.body);

        // Periksa status dalam respons
        if (responseData['status'] == 'success') {
          // Jika response success eksekusi kode dibawah

          Fluttertoast.showToast(msg: 'data berhasil diupload');
          
          Timer(Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ListMenu()),
            );
          });
          
        } else {
          // Jika upload data gagal, dapatkan pesan error
          String errorMessage = responseData['message'];
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Upload Data Gagal'),
                content: Text(responseData['message']),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Upload Data Gagal'),
              content: Text('error 01'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Upload Data Gagal'),
            content: Text('error 02'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  final ListMenuItems = [
    const DropdownMenuItem(
      value: "Makanan",
      child: Text('Makanan'),
    ),
    const DropdownMenuItem(
      value: "Minuman",
      child: Text('Minuman'),
    ),
    const DropdownMenuItem(
      value: "Snack",
      child: Text('Snack'),
    ),
    const DropdownMenuItem(
      value: "Steak",
      child: Text('Steak'),
    ),
  ];

  String categoryValue = "Makanan";

  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 200),
          Center(
            child: GestureDetector(
              onTap: () => {
                // Fluttertoast.showToast(msg: "clicked")
                storeData(nameController.text, hargaController.text, descController.text, "tersedia", categoryValue, "null", context)
              },
              child: const ButtonDetailMenu(
                color: Colors.blue,
                btntype: "Tambah",
              ),
            ),
          )
        ],
      ),
    );
  }
}
