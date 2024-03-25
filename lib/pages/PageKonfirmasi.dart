import 'package:flutter/material.dart';
import 'package:orderez/Widget/ListCardPesanan.dart';

class PageKonfirmasi extends StatelessWidget {
  const PageKonfirmasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 14.0),
      child: ListView(
        children: [
          ListCardPesanan(dataList: dataList1, categories: "dikonfirmasi",),
          ListCardPesanan(dataList: dataList2, categories: "dikonfirmasi",)
        ],
      ),
    );
  }
}


final List dataList1 = [
  {'nama': 'expresso', 'jumlah': 2, 'harga': 10000},
  {'nama': 'americano', 'jumlah': 1, 'harga': 30000},
  {'nama': 'steak', 'jumlah': 3, 'harga': 50000},
];

final List dataList2 = [
  {'nama': 'burger', 'jumlah': 2, 'harga': 10000},
  {'nama': 'pizza', 'jumlah': 1, 'harga': 30000},
  {'nama': 'mocca latte', 'jumlah': 2, 'harga': 50000},
  {'nama': 'mocca latte', 'jumlah': 2, 'harga': 50000},
  {'nama': 'mocca latte', 'jumlah': 2, 'harga': 50000},
  {'nama': 'mocca latte', 'jumlah': 2, 'harga': 50000},
  {'nama': 'mocca latte', 'jumlah': 2, 'harga': 50000},
  {'nama': 'mocca latte', 'jumlah': 2, 'harga': 50000},
  {'nama': 'mocca latte', 'jumlah': 2, 'harga': 50000},
  {'nama': 'mocca latte', 'jumlah': 2, 'harga': 50000},
  {'nama': 'mocca latte', 'jumlah': 2, 'harga': 50000},
  {'nama': 'mocca latte', 'jumlah': 2, 'harga': 50000},
  {'nama': 'mocca latte', 'jumlah': 2, 'harga': 50000},
  {'nama': 'mocca latte', 'jumlah': 2, 'harga': 50000},
  {'nama': 'mocca latte', 'jumlah': 2, 'harga': 50000},
  {'nama': 'mocca latte', 'jumlah': 2, 'harga': 50000},
  {'nama': 'mocca latte', 'jumlah': 2, 'harga': 50000},
  {'nama': 'mocca latte', 'jumlah': 2, 'harga': 50000},
];
