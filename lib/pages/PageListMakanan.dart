import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orderez/configuration/Constant.dart';
import 'package:orderez/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:orderez/view/EditMenu.dart';

class PageMakanan extends StatefulWidget {
  const PageMakanan({super.key});

  @override
  State<PageMakanan> createState() => _PageMakananState();

  void updateFindClicked(bool value) {
    updateFindClicked(value);
  }
}

class _PageMakananState extends State<PageMakanan> {
  late List<Product> listProd = [];

  late bool findclicked = false;

  late String valuekey = "";

  late TextEditingController SearchController;

  @override
  void initState() {
    super.initState();
    findclicked;
    SearchController = TextEditingController(text: valuekey);
  }

  void updateclick(bool value) {
    setState(() {
      findclicked = true;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback(
  //     (timeStamp) async {
  //       try {
  //         await getDataProduct(context);
  //       } catch (ex) {
  //         Fluttertoast.showToast(msg: "ERROR : ${ex.toString()}");
  //       }
  //     },
  //   );
  // }

  bool isDataNotEmpty = true;

  Future<void> getDataProduct(BuildContext context) async {
    final String apiUrl = '${OrderinAppConstant.productgetURL}/makanan';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {
          // tampilkan data
          List<dynamic> data = responseData['data'];

          listProd = data.map((item) => Product.fromJson(item)).toList();
        } else if (responseData['status'] == 'fail') {
          print(responseData['message']);
          isDataNotEmpty = false;
        } else {
          print('data gagal di dapat');
        }
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Failed Get Data'),
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

  bool isDataNotEmpty1 = true;

  Future<void> getDataProductFind(
      BuildContext context, String jenis, String keyword) async {
    final String apiUrl =
        '${OrderinAppConstant.productgetfindURL}/$jenis?keyword=$keyword';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {
          // tampilkan data
          List<dynamic> data = responseData['data'];

          listProd = data.map((item) => Product.fromJson(item)).toList();
        } else if (responseData['status'] == 'fail') {
          print(responseData['message']);
          isDataNotEmpty1 = false;
        } else {
          print('data gagal di dapat');
        }
      } else if (response.statusCode == 404) {
        listProd = [];
        isDataNotEmpty = false;
        // print('statuscode 404');
        Fluttertoast.showToast(msg: '404 statuscode');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Failed Get Data'),
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

  Future<List<Product>> products(BuildContext context) async {
    await getDataProduct(context);
    return listProd;
  }

  Future<List<Product>> productsfind(
      BuildContext context, String keyword) async {
    // findclicked = true;
    Fluttertoast.showToast(msg: 'productsfind...');
    await getDataProductFind(context, "makanan", valuekey);
    return listProd;
  }

  @override
  Widget build(BuildContext context) {
    // final SearchController = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: SearchController,
              textAlignVertical: TextAlignVertical.center,
              // textAlign: TextAlign.center,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                prefixIcon: Icon(Icons.search),
                hintText: "Cari Makanan...",
                fillColor: Color.fromARGB(255, 245, 245, 245),
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
              ),
              onEditingComplete: () {
                setState(() {
                  findclicked = true;
                  valuekey = SearchController.text;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Product>?>(
              future: findclicked == true
                  ? productsfind(context, SearchController.text)
                  : products(context),
              builder: (context, snapshot) {
                // dalam loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CupertinoActivityIndicator());
                }

                // jika error
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error : ${snapshot.error}",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }

                // jika data didapatkan
                if (snapshot.hasData && listProd.isNotEmpty) {
                  return GridView.count(
                    padding: const EdgeInsets.all(5),
                    crossAxisCount: 2,
                    children: listProd.map(
                      (drink) {
                        return _buildCard(
                          drink.kodeProduct.toString(),
                          drink.namaProduct ?? '',
                          // drink.hargaProduct ?? '',
                          drink.hargaProduct.toString(),
                          drink.gambarProduct ?? '',
                          drink.stockProduct ?? '',
                          drink.descProduct ?? '',
                        );
                      },
                    ).toList(),
                  );
                } else {
                  // jika data tidak ditemukan
                  return Center(
                    child: Text(
                      isDataNotEmpty ? 'Something Wrong' : 'Tidak Ada Data',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String IDproduct, String name, String price, String image,
      String stock, String deskripsi) {
    String isOutOfStock = stock;

    return Padding(
      padding: const EdgeInsets.all(6),
      child: Card(
        margin: const EdgeInsets.all(3),
        child: InkWell(
          onTap: () {
            print('u clicked this2');
            Fluttertoast.showToast(
                msg: "STATUS : Inkwell Clicked ID ${IDproduct}");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditMenu(
                          idprod: IDproduct,
                          name: name,
                          jenis: "Makanan",
                          price: price,
                          deskripsi: deskripsi,
                          stock: stock,
                          imgplaceholder: image,
                        )));
          },
          splashColor: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Center(
                      child: Image.network('${image}', fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                        // default gambar
                        return Image.asset(
                          'lib/images/handleimg.png',
                          fit: BoxFit.cover,
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  child: Text(
                    name,
                    style: const TextStyle(fontSize: 16.0,),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  isOutOfStock == 'habis' ? 'Stok Habis' : price,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: isOutOfStock == 'habis'
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isOutOfStock == 'habis' ? Colors.red : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class SearchprodWidget extends StatelessWidget {
//   const SearchprodWidget({super.key, required this.controller});

//   final controller;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(12),
//       child: TextField(
//         controller: controller,
//         textAlignVertical: TextAlignVertical.center,
//         // textAlign: TextAlign.center,
//         decoration: const InputDecoration(
//           contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//           prefixIcon: Icon(Icons.search),
//           hintText: "Search Here...",
//           fillColor: Color.fromARGB(255, 245, 245, 245),
//           filled: true,
//           enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey),
//               borderRadius: BorderRadius.all(Radius.circular(10))),
//           focusedBorder:
//               OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
//         ),
//         onEditingComplete: () {
//           _PageMakananState? pageState = context.findAncestorStateOfType<_PageMakananState>();
//             if (pageState != null) {
//               // Memanggil setState dari widget PageMakanan untuk mengubah nilai findclicked menjadi true
//               pageState.setState(() {
//                 pageState.findclicked = true;
//               });
//             }
//         },
//       ),
//     );
//     ;
//   }
// }
