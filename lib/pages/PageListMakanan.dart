import 'package:flutter/material.dart';

class PageMakanan extends StatelessWidget {
  const PageMakanan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        padding: const EdgeInsets.all(5),
        crossAxisCount: 2,
        children: dataList.map((food) {
          return _buildCard(food['name']!, food['price']!, food['image']!, int.parse(food['stock']!));
        }).toList(),
      ),
    );
  }

  Widget _buildCard(String name, String price, String image, int stock) {
    bool isOutOfStock = stock == 0;

    return Padding(
      padding: const EdgeInsets.all(6),
      child: Card(
        margin: const EdgeInsets.all(3),
        child: InkWell(
          onTap: isOutOfStock ? () {} : () {},
          splashColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'lib/images/${image}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  name,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 10),
                Text(
                  isOutOfStock ? 'Stok Habis' : price,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: isOutOfStock ? FontWeight.bold : FontWeight.normal,
                    color: isOutOfStock ? Colors.red : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final List<Map<String, String>> dataList = [
  {
    'name': 'Tahu Goreng',
    'description': 'Ini makanan terbuat dari tahu',
    'price': 'Rp. 5000',
    'image': 'tahugoreng.jpg',
    'stock': '1',
  },
  {
    'name': 'Pisang Goreng',
    'description': 'Ini makanan terbuat dari pisang',
    'price': 'Rp. 4000',
    'image': 'tahugoreng.jpg',
    'stock': '0',
  },
  
];
