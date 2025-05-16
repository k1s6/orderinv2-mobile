import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orderez/Widget/ButtonDetailMenu.dart';
import 'package:orderez/Widget/TextFieldComponent.dart';
import 'package:orderez/Widget/ButtonWidget.dart';
import 'package:orderez/Widget/TextFieldDetails.dart';
import 'package:orderez/Widget/TextFieldEdit.dart';
import 'package:orderez/configuration/Constant.dart';
import 'package:orderez/view/ListMenu.dart';
import 'package:http/http.dart' as http;

final _formKey = GlobalKey<FormState>();

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
        centerTitle: true,
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
        title: const Text(
          'Tambah Menu',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
  File? _imageFile;
  String? _imgName;
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

      int initIndex;

      switch (jenis) {
        case "Makanan":
          initIndex = 0;
          break;
        case "Minuman":
          initIndex = 1;
          break;
        case "Snack":
          initIndex = 2;
          break;
        case "Steak":
          initIndex = 3;
          break;
        default:
          initIndex = 0;
      }

      // Periksa status code respons dari server
      if (response.statusCode == 200) {
        // Decode respons JSON
        final responseData = json.decode(response.body);

        // Periksa status dalam respons
        if (responseData['status'] == 'success') {
          // Jika response success eksekusi kode dibawah

          // var snackbarmsg = const SnackBar(
          //   content: Text('Menu Successfully Added'),
          // );

          // ScaffoldMessenger.of(context).showSnackBar(snackbarmsg);
          showSnackbarCustom(context);

          Timer(const Duration(seconds: 4), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ListMenu(
                        initialTabIndex: initIndex,
                      )),
            );
          });
        } else {
          // Jika upload data gagal, dapatkan pesan error
          String errorMessage = responseData['message'];
          showSnackbarCustomFail(context, "gagal");
          // showDialog(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return AlertDialog(
          //       title: Text('Upload Data Gagal'),
          //       content: Text(responseData['message']),
          //       actions: <Widget>[
          //         TextButton(
          //           onPressed: () {
          //             Navigator.of(context).pop();
          //           },
          //           child: Text('OK'),
          //         ),
          //       ],
          //     );
          //   },
          // );
        }
      } else {
        final responseData = json.decode(response.body);
        String errorMessage = responseData['message'];
        showSnackbarCustomFail(context, '$errorMessage');

        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: Text('Upload Data Gagal'),
        //       content: Text('error'),
        //       actions: <Widget>[
        //         TextButton(
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //           child: Text('OK'),
        //         ),
        //       ],
        //     );
        //   },
        // );
      }
    } catch (e) {
      print(e);
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: Text('Upload Data Gagal'),
      //       content: Text('error 02'),
      //       actions: <Widget>[
      //         TextButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: Text('OK'),
      //         ),
      //       ],
      //     );
      //   },
      // );
      showSnackbarCustomFail(
          context, "Gagal, pastikan koneksi internet anda stabil");
    }
  }

  Future<void> uploadImage() async {
    if (_imageFile != null) {
      final String apiUrl = OrderinAppConstant.upimgURL;

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      request.files
          .add(await http.MultipartFile.fromPath('image', _imageFile!.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        // Read response stream as String
        String responseBody = await response.stream.bytesToString();

        // Decode response JSON
        final responseData = json.decode(responseBody);

        // Check status in the response
        if (responseData['status'] == 'success') {
          // If response success, execute code below
          // Fluttertoast.showToast(msg: 'Gambar Produk Berhasil diupload');
          setState(() {
            this._imgName = responseData['name'];
          });
        } else {
          // Handle other cases when status is not success
          // Fluttertoast.showToast(msg: 'Gagal mengupload gambar produk');
        }
      } else {
        // Handle other status codes
        Fluttertoast.showToast(msg: 'Error upload Image');
      }
    } else {
      // Fluttertoast.showToast(msg: "Tidak ada gambar yang dipilih");
      setState(() {
        this._imgName = "null";
      });
    }
  }

  Future<void> uploadandstore() async {
    await uploadImage();
    storeData(nameController.text, hargaController.text, descController.text,
        "tersedia", categoryValue, _imgName ?? "null", context);
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

  Future<void> _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this._imageFile = imageTemporary;
      });
    } on PlatformException catch (e) {
      Fluttertoast.showToast(msg: 'failed pick image $e');
    }
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama tidak boleh kosong';
    } else if (value.length < 2) {
      return 'Panjang nama minimal 2 karakter';
    } else if (value.length > 50) {
      return 'Nama tidak boleh lebih dari 50 karakter';
    }
    return null;
  }

  String? descValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'deskripsi tidak boleh kosong';
    } else if (value.length > 250) {
      return 'deskripsi tidak boleh lebih dari 250 karakter';
    }
    return null;
  }

  String? priceValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Harga tidak boleh kosong';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Harga tidak boleh mengandung titik atau koma';
    } else if (int.parse(value) > 1000000000) {
      return 'Harga maksimal Rp 1,000,000,000';
    }
    return null;
  }

// =============== Snackbar Here ==================
  static void showSnackbarCustom(BuildContext context) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Sukses!',
        message: 'Menu Berhasil Diupload!',

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSnackbarCustomFail(BuildContext context, String msg) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Gagal!',
        message: '$msg',

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showScackbarCustom2(BuildContext context) {
    final snackbarmsg = SnackBar(
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
              padding: EdgeInsets.all(16),
              height: 90,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                children: [
                  SizedBox(
                    width: 48,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Success',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          'Menu Successfully Added',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(20)),
              child: SvgPicture.asset(
                'lib/images/bubbles.svg',
                color: Colors.greenAccent,
                height: 48,
                width: 40,
              ),
            ),
          ),
          Positioned(
              left: 0,
              top: -20,
              child: SvgPicture.asset(
                'lib/images/fail.svg',
                color: Colors.greenAccent,
                height: 40,
              ))
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );

    return ScaffoldMessenger.of(context).showSnackBar(snackbarmsg);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _imageFile != null
                ? Image.file(
                    _imageFile!,
                    width: 170,
                    height: 170,
                    fit: BoxFit.cover,
                  )
                : const Icon(
                    Icons.image,
                    size: 170,
                  ),
            GestureDetector(
              onTap: () => _pickImage(),
              child: const Text(
                'Edit',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('nama'),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFieldEdit(
                      controller: nameController,
                      validator: nameValidator,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('harga'),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: TextFieldDetails(
                      controller: hargaController,
                      keyboardType: TextInputType.number,
                      validator: priceValidator,
                    )),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('deskripsi'),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: TextFieldEdit(
                      controller: descController,
                      validator: descValidator,
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
                  if (_formKey.currentState?.validate() ?? false)
                    {uploadandstore()}
                },
                child: const ButtonDetailMenu(
                  color: Colors.blue,
                  btntype: "Tambah",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
