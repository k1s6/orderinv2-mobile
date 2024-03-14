import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orderez/view/ListMenu.dart';

class ListCardPesanan extends StatelessWidget {
  const ListCardPesanan({super.key, required this.dataList});

  final List dataList;

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
              ); // Custom dialog widget
            },
          );
        },
        splashColor: Colors.amberAccent,
        child: const Padding(
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
                      Text('John Doe', style: TextStyle(fontSize: 20)),
                      Text('Wednesday, 06 March 2024'),
                      Text('12:59:00'),
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
  const SecondPageDialog({super.key, required this.dataList});

  final List dataList;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width:
            MediaQuery.of(context).size.width * 0.9, // 90% of the screen width
        height: MediaQuery.of(context).size.height *
            0.9, // 90% of the screen height
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
                Container(
                  height: 500,
                  child: SingleChildScrollView(
                    child: DataTable(
                      border: TableBorder(
                          horizontalInside:
                              BorderSide(width: 1, color: Colors.grey)),
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
                            numeric: true),
                      ],
                      rows: dataList.map((e) {
                        return DataRow(cells: [
                          DataCell(Text(e["nama"] ?? '')),
                          DataCell(Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Rp ${e["harga"].toString()} x ${e["jumlah"].toString()}',
                              textAlign: TextAlign.end,
                            ),
                          )),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text('total harga'),
                          Expanded(child: SizedBox()),
                          Text('Rp berapa gitu')
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: OutlinedButton(
                        child: Text("tolak"),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: OutlinedButton(
                        child: Text("konfirmasi"),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                )
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
