import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderez/Widget/ListCardPesanan.dart';
import 'package:orderez/configuration/Constant.dart';
import 'package:orderez/model/Transaction.dart';
import 'package:http/http.dart' as http;

class PageBatalkan extends StatefulWidget {
  const PageBatalkan({super.key});

  @override
  State<PageBatalkan> createState() => _PageBatalkanState();
}

class _PageBatalkanState extends State<PageBatalkan> {
  late List<Transaksi> listProd = [];

  bool isDataNotEmpty = true;

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

          listProd = data.map((item) => Transaksi.fromJson(item)).toList();

          if (listProd.length == 0) {
            isDataNotEmpty = false;
          }

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

  Future<void> _refreshData(BuildContext context) async {
    setState(() {
      // Reset listProd and isDataNotEmpty before fetching new data
      listProd.clear();
      isDataNotEmpty = true;
    });
    await showData(context);
  }

  Future<List<Transaksi>> transaksi(BuildContext context) async {
    await showData(context);
    return listProd;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 14.0),
      child: Expanded(
        child: FutureBuilder<List<Transaksi>?>(
          future: transaksi(context),
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
            if (snapshot.hasData && listProd.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () => _refreshData(context),
                child: ListView.builder(
                  itemCount: listProd.length,
                  itemBuilder: (s, index) {
                    return ListCardPesanan(
                      dataList: listProd[index],
                      categories: 'batalkan',
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
    );
  }
}
