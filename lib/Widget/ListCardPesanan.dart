import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orderez/view/ListMenu.dart';

class ListCardPesanan extends StatelessWidget {
  const ListCardPesanan({super.key});

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
              return SecondPageDialog(); // Custom dialog widget
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
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width:
            MediaQuery.of(context).size.width * 0.9, // 90% of the screen width
        height: MediaQuery.of(context).size.height *
            0.9, // 90% of the screen height
        child: SecondPageContent(),
      ),
    );
  }
}

class SecondPageContent extends StatelessWidget {
  final List dataList = [
    {'nama': 'expresso', 'jumlah': 2, 'harga': 10000},
    {'nama': 'americano', 'jumlah': 1, 'harga': 30000},
    {'nama': 'steak', 'jumlah': 3, 'harga': 50000},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _getTitleProduct('ok'),
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: Container(
        child: Column(
          children: [
            DataTable(
              columns: [
                DataColumn(label: Text('nama')),
                DataColumn(label: Text('jumlah')),
              ],
              rows: dataList.map((e) {
                return DataRow(cells: [
                  DataCell(Text(e["nama"] ?? '')),
                  DataCell(Text(
                      '${e["jumlah"].toString()} x Rp ${e["harga"].toString()}')),
                ]);
              }).toList(),
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

    );
  }
}

Text _getTitleProduct(String txt) {
  switch (txt) {
    case "ok":
      return Text('Nama : John Doe');
    default:
      return Text('nothing');
  }
}
