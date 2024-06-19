import 'dart:convert';
import 'dart:math';
import 'dart:developer';

import 'package:d_method/d_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:orderez/Widget/ListTileComponent.dart';
import 'package:orderez/Widget/ListCardPesanan.dart';
import 'package:orderez/configuration/Constant.dart';
import 'package:orderez/model/Product.dart';
import 'package:orderez/model/Transaction.dart';
import 'package:orderez/view/LoginUser.dart';
import 'package:http/http.dart' as http;

class PagePesanan extends StatefulWidget {
  const PagePesanan({super.key});

  @override
  State<PagePesanan> createState() => _PagePesananState();
}

class _PagePesananState extends State<PagePesanan> {
  late List<Transaksi> listProd = [];
  late List<Transaksi> filteredListProd = [];
  late Future<void> _dataFuture;

  bool isDataNotEmpty = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dataFuture = showData(context);
  }

  Future<void> showData(BuildContext context) async {
    final String apiUrl = '${OrderinAppConstant.getdataTransaction}/diterima';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      DMethod.log('CALL SHOW DATA');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        DMethod.log('RESPONSE CODE IS 200');

        if (responseData['status'] == 'success') {
          DMethod.log('CALL STATUS');
          // tampilkan data
          List<dynamic> data = responseData['data'];

          // listProd = data.map((item) => Transaksi.fromJson(item)).toList();
          // filteredListProd = listProd;

          // if (listProd.length == 0) {
          //   isDataNotEmpty = false;
          // }
          setState(() {
            listProd = data.map((item) => Transaksi.fromJson(item)).toList();
            filteredListProd = listProd;
            isDataNotEmpty = listProd.isNotEmpty;
          });

          for (var trx in listProd) {
            DMethod.log('DATA -> ${trx.nama}');
          }

          // log(listProd);
        } else if (responseData['status'] == 'fail') {
          DMethod.log('CALL FAIL');
          DMethod.log(responseData['message']);
          isDataNotEmpty = false;
        } else {
          DMethod.log('DATA GAGAL');
          DMethod.log('data gagal di dapat');
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

  void filterSearchResults(String query) {
    // if (query.isNotEmpty) {
    List<Transaksi> filteredUsers = listProd.where((user) {
      return user.nama.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      filteredListProd = filteredUsers;
      isDataNotEmpty = false;
    });
  }

  Future<void> _refreshData(BuildContext context) async {
    setState(() {
      // Reset listProd and isDataNotEmpty before fetching new data
      listProd.clear();
      filteredListProd.clear();
      isDataNotEmpty = true;
      _dataFuture = showData(context);
    });
    // await showData(context);
  }

  // Future<List<Transaksi>> transaksi(BuildContext context) async {
  //   await showData(context);
  //   return listProd;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 14.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    textAlignVertical: TextAlignVertical.center,
                    // textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Cari Nama Pelanggan",
                      fillColor: Color.fromARGB(255, 245, 245, 245),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: () => showDialog(
                      context: context, builder: (context) => const SortingDialog()),
                  child: const Icon(Icons.sort_sharp),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Transaksi>?>(
              future: Future.value(listProd),
              builder: (context, snapshot) {
                // dalam loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CupertinoActivityIndicator());
                }

                // jika error
                if (snapshot.hasError) {
                  return RefreshIndicator(
                    onRefresh: () => _refreshData(context),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        Center(
                          child: Text(
                            "Error : ${snapshot.error}",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // jika data didapatkan
                if (snapshot.hasData && filteredListProd.isNotEmpty) {
                  return RefreshIndicator(
                    onRefresh: () => _refreshData(context),
                    child: ListView.builder(
                      itemCount: filteredListProd.length,
                      itemBuilder: (s, index) {
                        return ListCardPesanan(
                          dataList: filteredListProd[index],
                          categories: 'pesanan',
                        );
                      },
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
    );
  }
}

class SortingDialog extends StatefulWidget {
  const SortingDialog({super.key});

  @override
  State<SortingDialog> createState() => SortingDialogState();
}

class SortingDialogState extends State<SortingDialog> {
  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('this is list of sorting'),
            Text('this is list of sorting'),
            Text('this is list of sorting'),
            Text('this is list of sorting'),
            Text('this is list of sorting'),
          ],
        ),
      ),
    );
  }
}
