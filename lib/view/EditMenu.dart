import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orderez/Widget/ButtonDetailMenu.dart';
import 'package:orderez/Widget/ButtonLogs.dart';
import 'package:orderez/Widget/TextFieldDetails.dart';
import 'package:orderez/Widget/TextFieldEdit.dart';
import 'package:orderez/configuration/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:orderez/view/ListMenu.dart';

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
    final String apiUrl = '${OrderinAppConstant.updateURL}/${kodeprod}';

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

      // Periksa status code respons dari server
      if (response.statusCode == 200) {
        // Decode respons JSON
        final responseData = json.decode(response.body);

        // Periksa status dalam respons
        if (responseData['status'] == 'success') {
          // Jika response success eksekusi kode dibawah

          Fluttertoast.showToast(msg: 'data berhasil diubah');

          // Timer(Duration(seconds: 2), () {
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(builder: (context) => ListMenu()),
          //   );
          // });
        } else {
          // Jika upload data gagal, dapatkan pesan error
          String errorMessage = responseData['message'];
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Update Data Gagal'),
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
              title: Text('Update Data Gagal'),
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
            title: Text('Update Data Gagal'),
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
              onPressed: () {
                Navigator.of(context).pop();
                deleteData(idprod, context);
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> deleteData(String kodeprod, BuildContext context) async {
    final String apiUrl = '${OrderinAppConstant.delprodURL}/${kodeprod}';

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
                title: Text('Update Data Gagal'),
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
        this._imageFile = imageTemporary;
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
          Fluttertoast.showToast(msg: 'Data berhasil diupload');
          setState(() {
            this._imgName = responseData['name'];
          });
        } else {
          // Handle other cases when status is not success
          Fluttertoast.showToast(msg: 'Gagal mengupload data');
        }
      } else {
        // Handle other status codes
        Fluttertoast.showToast(msg: 'Gagal mengupload data');
      }
    } else {
      String imageName = getImageNameFromUrl(widget.imgplaceholder);
      Fluttertoast.showToast(msg: "No image selected");
      setState(() {
        this._imgName = imageName;
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
                  updateandupload(),
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
