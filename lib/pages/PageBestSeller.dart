import 'package:flutter/material.dart';

class PageBestSeller extends StatefulWidget {
  @override
  _PageBestSellerState createState() => _PageBestSellerState();
}

class _PageBestSellerState extends State<PageBestSeller> {
  String selectedCategory = "Makanan";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pilihan Kategori Menu
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pilih Kategori Menu !",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: Center(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedCategory,
                      items: ["Makanan", "Minuman", "Snack", "Steak"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          alignment: AlignmentDirectional.center,
                          child: Center(
                            child: Text(value)
                            ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue!;
                        });
                      },
                    ),),
                  ),
                ),
              ],
            ),
          ),

          // Kartu Menu Best Seller
          Center(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  // Gambar Menu
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      "lib/images/tahugoreng.jpg",
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Nama Menu
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "TAHU GORENG",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Jumlah Terjual
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(12)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Terjual Bulan Ini",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        Text(
                          "157 item",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
