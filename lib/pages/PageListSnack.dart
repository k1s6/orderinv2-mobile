import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orderez/configuration/Constant.dart';
import 'package:orderez/model/Product.dart';
import 'package:orderez/view/EditMenu.dart';

final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class PageSnack extends StatefulWidget {
  const PageSnack({super.key, required this.onShowMessage});

  final void Function(String message) onShowMessage; // Callback untuk menampilkan pesan

  @override
  State<PageSnack> createState() => _PageSnackState();

  void updateFindClicked(bool value) {
    updateFindClicked(value);
  }
}

class _PageSnackState extends State<PageSnack> {
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

  Future<void> _refreshData(BuildContext context) async {
    setState(() {
      // Reset listProd and isDataNotEmpty before fetching new data
      listProd.clear();
      isDataNotEmpty = true;
      getDataProduct(context);
    });
    // await showData(context);
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
    final String apiUrl = '${OrderinAppConstant.productgetURL}/snack';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {
          // tampilkan data
          List<dynamic> data = responseData['data'];

          listProd = data.map((item) => Product.fromJson(item)).toList();
        } else if (responseData['status'] == 'fail') {
          _scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(content: Text('Data gagal didapatkan')),
          );
          isDataNotEmpty = false;
        }
      }
    } catch (e) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Server Error')),
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
        Builder(
          builder: (context) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('404 statuscode')),
            );
            return SizedBox.shrink();
          },
        );
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
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text('productsfind...')),
    );
    await getDataProductFind(context, "snack", valuekey);
    return listProd;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
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
                  hintText: "Cari Snack...",
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
                    return RefreshIndicator(
                      onRefresh: () => _refreshData(context),
                      child: GridView.count(
                        padding: const EdgeInsets.all(5),
                        crossAxisCount: 2,
                        children: listProd.map(
                          (drink) {
                            return _buildCard(
                              drink.kodeProduct.toString(),
                              drink.namaProduct ?? '',
                              drink.hargaProduct.toString(),
                              drink.gambarProduct ?? '',
                              drink.stockProduct ?? '',
                              drink.descProduct ?? '',
                            );
                          },
                        ).toList(),
                      ),
                    );
                  } else {
                    // jika data tidak ditemukan
                    return RefreshIndicator(
                      onRefresh: () => _refreshData(context),
                      child: ListView(
                        children: [
                          Container(
                            height: 270,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    isDataNotEmpty
                                        ? 'Something Wrong'
                                        : 'Tidak Ada Data',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String IDproduct, String name, String price, String image,
      String stock, String deskripsi) {
    return InkWell(
      onTap: () {
        _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(content: Text("STATUS : Inkwell Clicked ID ${IDproduct}")),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditMenu(
              idprod: IDproduct,
              name: name,
              jenis: "Snack",
              price: price,
              deskripsi: deskripsi,
              stock: stock,
              imgplaceholder: image,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Card(
          margin: const EdgeInsets.all(3),
          child: InkWell(
            onTap: () {
              print('u clicked this2');
              _scaffoldMessengerKey.currentState?.showSnackBar(
                SnackBar(content: Text("STATUS : Inkwell Clicked ID ${IDproduct}")),
              );
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditMenu(
                            idprod: IDproduct,
                            name: name,
                            jenis: "Snack",
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
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    stock == 'habis' ? 'Stok Habis' : price,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: stock == 'habis'
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: stock == 'habis' ? Colors.red : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
