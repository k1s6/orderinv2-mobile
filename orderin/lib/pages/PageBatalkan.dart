import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orderin/Widget/ListCardPesanan.dart';
import 'package:orderin/configuration/Constant.dart';
import 'package:orderin/model/Transaction.dart';

class PageBatalkan extends StatefulWidget {
  const PageBatalkan({super.key});

  @override
  State<PageBatalkan> createState() => _PageBatalkanState();
}

class _PageBatalkanState extends State<PageBatalkan> {
  late List<Transaksi> listProd = [];
  late List<Transaksi> filteredListProd = [];
  late Future<void> _dataFuture;
  bool isDescending = false;

  void updateSortOrder(bool descending) {
    setState(() {
      isDescending = descending;
    });
  }

  bool isDataNotEmpty = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dataFuture = showData(context);
  }

  Future<void> showData(BuildContext context) async {
    final String apiUrl = '${OrderinAppConstant.getdataTransaction}/ditolak';

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

          // if (listProd.length == 0) {
          //   isDataNotEmpty = false;
          // }
          setState(() {
            listProd = data.map((item) => Transaksi.fromJson(item)).toList();
            filteredListProd = listProd;
            isDataNotEmpty = listProd.isNotEmpty;
          });

          for (var trx in listProd) {
            DMethod.log('DATA -> ${trx.kodeTransaksi}');
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
                      context: context,
                      builder: (context) => SortingDialog(
                          initialSortOrder: isDescending,
                          onSortOrderChanged: updateSortOrder)),
                  child: Image.asset(
                    'lib/images/sorting.png',
                    height: 40,
                  ),
                  // const Icon(Icons.sort_sharp),
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
                        final items = isDescending
                            ? filteredListProd.reversed.toList()
                            : filteredListProd;

                        return ListCardPesanan(
                          dataList: items[index],
                          categories: 'tolak',
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
                        SizedBox(
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
  final bool initialSortOrder;
  final void Function(bool) onSortOrderChanged;

  const SortingDialog(
      {super.key,
      required this.initialSortOrder,
      required this.onSortOrderChanged});

  @override
  State<SortingDialog> createState() => SortingDialogState();
}

List<String> options = ["Option 1", "Option 2"];

class SortingDialogState extends State<SortingDialog> {
  late bool currentOptions;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentOptions = widget.initialSortOrder;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Urutkan",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RadioListTile(
                title: const Text("Pesanan Terlama"),
                value: false,
                groupValue: currentOptions,
                onChanged: (value) {
                  setState(() {
                    currentOptions = false;
                  });
                  widget.onSortOrderChanged(false);
                  Navigator.pop(context);
                }),
            RadioListTile(
                title: const Text("Pesanan Terbaru"),
                value: true,
                groupValue: currentOptions,
                onChanged: (value) {
                  setState(() {
                    currentOptions = true;
                  });
                  widget.onSortOrderChanged(true);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
