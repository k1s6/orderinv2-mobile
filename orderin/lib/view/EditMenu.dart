import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orderin/Widget/ButtonDetailMenu.dart';
import 'package:orderin/Widget/ButtonLogs.dart';
import 'package:orderin/Widget/TextFieldDetails.dart';
import 'package:orderin/Widget/TextFieldEdit.dart';
import 'package:orderin/configuration/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:orderin/view/ListMenu.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

final _formKey = GlobalKey<FormState>();

class EditMenu extends StatefulWidget {
  const EditMenu(
      {super.key,
      required this.idprod,
      required this.name,
      required this.jenis,
      required this.price,
      required this.deskripsi,
      required this.stock,
      required this.imgplaceholder});

  final String idprod;
  final String name;
  final String price;
  final String jenis;
  final String deskripsi;
  final String stock;
  final String imgplaceholder;

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
        centerTitle: true,
        title: const Text(
          'Detail Menu',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: BodyOfEditMenu(
        idprod: widget.idprod,
        name: widget.name,
        jenis: widget.jenis,
        harga: widget.price,
        deskripsi: widget.deskripsi,
        stock: widget.stock,
        imgplaceholder: widget.imgplaceholder,
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
    required this.stock,
    required this.imgplaceholder,
  });

  final String idprod;
  final String name;
  final String jenis;
  final String harga;
  final String deskripsi;
  final String stock;
  final String imgplaceholder;

  @override
  State<BodyOfEditMenu> createState() => _BodyOfEditMenu();
}

class _BodyOfEditMenu extends State<BodyOfEditMenu> {
  File? _imageFile;
  String? _imgName;

  late bool imgcheck;
  late TextEditingController nameController;
  late TextEditingController hargaController;
  late TextEditingController descController;
  late bool isAvailable;
  late bool light1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imgcheck = false;
    nameController = TextEditingController(text: widget.name);
    hargaController = TextEditingController(text: widget.harga);
    descController = TextEditingController(text: widget.deskripsi);
    light1 = widget.stock == "tersedia" ? true : false;
    categoryValue = widget.jenis;
  }

  static Future<void> updateData(
      String nama,
      String harga,
      String deskripsi,
      String stock,
      String jenis,
      String gambar,
      String kodeprod,
      BuildContext context) async {
    final String apiUrl = '${OrderinAppConstant.updateURL}/$kodeprod';

    try {
      // Kirim permintaan HTTP POST ke server
      final response = await http.put(
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

          // Fluttertoast.showToast(msg: 'data berhasil diubah');
          showSnackbarCustom(context);

          Timer(Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ListMenu(
                        initialTabIndex: initIndex,
                      )),
            );
          });
        }
      } else {
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: Text('Update Data Gagal'),
        //       content: Text('error 01'),
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
        final responseData = json.decode(response.body);
        String errorMessage = responseData['message'];
        showSnackbarCustomFail(context, errorMessage);
      }
    } catch (e) {
      showSnackbarCustomFail(
          context, "Gagal, pastikan koneksi internet anda stabil");
    }
  }

  Future<void> confirmDeleteData(BuildContext context, String idprod) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin ingin menghapus data ini?'),
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
                await deleteData(idprod, context);
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> deleteData(String kodeprod, BuildContext context) async {
    final String apiUrl = '${OrderinAppConstant.delprodURL}/$kodeprod';

    try {
      // Kirim permintaan HTTP POST ke server
      final response = await http.get(
        Uri.parse(apiUrl),
      );

      // Periksa status code respons dari server
      if (response.statusCode == 200) {
        // Decode respons JSON
        final responseData = json.decode(response.body);

        // Periksa status dalam respons
        if (responseData['status'] == 'success') {
          // Jika response success eksekusi kode dibawah

          Fluttertoast.showToast(msg: 'data berhasil dihapus');

          int initIndex = 0;

          switch (categoryValue) {
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

          Timer(Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ListMenu(
                        initialTabIndex: initIndex,
                      )),
            );
          });
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Delete Data Gagal'),
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
            title: Text('Delete Data Gagal'),
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

  Future<void> _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemporary = File(image.path);
      imgcheck = true;

      setState(() {
        _imageFile = imageTemporary;
      });

      Fluttertoast.showToast(msg: 'image picked');
    } on PlatformException catch (e) {
      Fluttertoast.showToast(msg: 'failed pick image $e');
    }
  }

  Future<void> uploadImage() async {
    if (_imageFile != null && imgcheck == true) {
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
          // Fluttertoast.showToast(msg: 'Gambar berhasil terunggah');
          setState(() {
            _imgName = responseData['name'];
          });
        }
      } else {
        // Handle other status codes
        Fluttertoast.showToast(msg: 'Gambar gagal diubah');
      }
    } else {
      String imageName = getImageNameFromUrl(widget.imgplaceholder);
      // Fluttertoast.showToast(msg: "Gambar tidak diubah");
      setState(() {
        _imgName = imageName;
      });
    }
  }

  String getImageNameFromUrl(String url) {
    // Split the URL by slashes to get individual components
    List<String> urlParts = url.split('/');

    // The image name is usually the last component in the URL
    String imageName = urlParts.last;

    return imageName;
  }

  Future<void> updateandupload() async {
    String imageName = getImageNameFromUrl(widget.imgplaceholder);
    await uploadImage();
    updateData(
        nameController.text,
        hargaController.text,
        descController.text,
        light1 == true ? "tersedia" : "habis",
        categoryValue,
        imgcheck ? _imgName! : imageName,
        widget.idprod,
        context);
  }

  final WidgetStateProperty<Icon?> thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  final ListMenuItems = [
    DropdownMenuItem(
      value: "Makanan",
      child: Text('Makanan'),
    ),
    DropdownMenuItem(
      value: "Minuman",
      child: Text('Minuman'),
    ),
    DropdownMenuItem(
      value: "Snack",
      child: Text('Snack'),
    ),
    DropdownMenuItem(
      value: "Steak",
      child: Text('Steak'),
    ),
  ];

  static String categoryValue = "Makanan";

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

  String? descValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'deskripsi tidak boleh kosong';
    } else if (value.length > 250) {
      return 'deskripsi tidak boleh lebih dari 250 karakter';
    }
    return null;
  }

  static void showSnackbarCustom(BuildContext context) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Sukses!',
        message: 'Menu Berhasil Diupdate!',

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
        message: msg,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // categoryValue = widget.jenis;

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
                : imgcheck
                    ? Icon(
                        Icons.image,
                        size: 170,
                      )
                    : Image.network(widget.imgplaceholder,
                        width: 170, height: 170, fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                        // default gambar
                        return Icon(
                          Icons.image,
                          size: 170,
                        );
                      }),
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
                      validator: nameValidator,
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
            SizedBox(height: 170),
            Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                GestureDetector(
                  onTap: () => {
                    // Fluttertoast.showToast(msg: "clicked")
                    // deleteData(widget.idprod, context)
                    confirmDeleteData(context, widget.idprod)
                  },
                  child: const ButtonDetailMenu(
                    color: Colors.red,
                    btntype: "Hapus",
                  ),
                ),
                Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: () => {
                    if (_formKey.currentState?.validate() ?? false)
                      {updateandupload()}
                  },
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
      ),
    );
  }
}
