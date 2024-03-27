import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Koneksi extends StatefulWidget {
  const Koneksi({super.key});

  @override
  State<Koneksi> createState() => _KoneksiState();
}

class _KoneksiState extends State<Koneksi> {
  List data = [];

  Future<void> getrecord() async {
    String uri = "http://192.168.1.73/apimobileorderin/data_transaksi.php";

    try {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        data = jsonDecode(response.body);
        print(data);
      });

      print(response);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(data);
    return Scaffold(
      appBar: AppBar(title: Text('View Data')),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  data[index]["nama"],
                  style: TextStyle(color: Colors.amber),
                ),
                // subtitle: ,
              ),
            );
          }),
    );
  }
}
