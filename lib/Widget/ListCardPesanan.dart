import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orderez/configuration/Constant.dart';
import 'package:orderez/model/Transaction.dart';
import 'package:orderez/view/ListMenu.dart';

import 'package:http/http.dart' as http;

class ListCardPesanan extends StatelessWidget {
  const ListCardPesanan(
      {super.key, required this.dataList, required this.categories});

  final Transaksi dataList;
  final String categories;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: null,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        onTap: () {
          // pengalihan sementara
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => ListMenu()));
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SecondPageDialog(
                dataList: dataList,
                categories: categories,
              ); // Custom dialog widget
            },
          );
        },
        splashColor: Colors.amberAccent,
        child: Padding(
          padding: EdgeInsets.all(7.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dataList.nama, style: TextStyle(fontSize: 20)),
                      Text('${dataList.createdAt}'),
                      Text(dataList.nama),
                    ],
                  )),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.amber,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPageDialog extends StatelessWidget {
  const SecondPageDialog(
      {super.key, required this.dataList, required this.categories});

  final Transaksi dataList;
  final String categories;

  Future<void> updateTransaksi(
      String status, String kode, BuildContext context) async {
    final String apiUrl = '${OrderinAppConstant.updateTransaction}/${kode}';

    try {
      // Kirim permintaan HTTP POST ke server
      final response = await http.put(
        Uri.parse(apiUrl),
        body: {
          "status": status,
        }, // raw body
      );

      // Periksa status code respons dari server
      if (response.statusCode == 200) {
        // Decode respons JSON
        final responseData = json.decode(response.body);

        // Periksa status dalam respons
        if (responseData['status'] == 'success') {
          // Jika response success eksekusi kode dibawah
          status == "diterima"
              ? Fluttertoast.showToast(msg: 'transaksi diterima!')
              : Fluttertoast.showToast(msg: 'transaksi ditolak');
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width:
            MediaQuery.of(context).size.width * 0.9, // 90% of the screen width
        height: MediaQuery.of(context).size.height *
            0.7, // 90% of the screen height
        child: Scaffold(
          appBar: AppBar(
            title: _getTitleProduct('ok'),
            automaticallyImplyLeading: false, // Remove the back button
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the page dialog
                },
              ),
            ],
          ),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 0,
                        maxHeight: 300,
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: SingleChildScrollView(
                          child: DataTable(
                            border: TableBorder(
                              horizontalInside:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            columns: const [
                              DataColumn(label: Text('nama')),
                              DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'jumlah',
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                numeric: true,
                              ),
                            ],
                            rows: dataList.details.map((e) {
                              return DataRow(cells: [
                                DataCell(Text(e.product.namaProduct ?? '')),
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Rp ${e.product.hargaProduct} x ${e.jumlah}',
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      child: Row(
                        children: [
                          Text(
                            'total harga',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: SizedBox()),
                          Text(
                            'Rp 50.000',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: this.categories == "pesanan"
                          ? OutlinedButton(
                              child: Text(
                                "tolak",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.red,
                                  ),
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                updateTransaksi("ditolak",
                                    '${dataList.kodeTransaksi}', context);
                              },
                            )
                          : SizedBox(),
                    ),
                    Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: this.categories == "pesanan"
                          ? OutlinedButton(
                              child: Text(
                                "konfirmasi",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.green,
                                ),
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () {
                                updateTransaksi("dikonfirmasi",
                                    '${dataList.kodeTransaksi}', context);
                              },
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 60), child: SizedBox())
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// final List dataList = [
//   {'nama': 'expresso', 'jumlah': 2, 'harga': 10000},
//   {'nama': 'americano', 'jumlah': 1, 'harga': 30000},
//   {'nama': 'steak', 'jumlah': 3, 'harga': 50000},
// ];

// class SecondPageContent extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

Text _getTitleProduct(String txt) {
  switch (txt) {
    case "ok":
      return Text('Nama : John Doe');
    default:
      return Text('nothing');
  }
}
