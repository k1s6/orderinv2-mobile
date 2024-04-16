import 'dart:convert';

import 'package:orderez/configuration/Constant.dart';
import 'package:orderez/model/Product.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:collection';

List<Product> listProd = [];

Future<void> getDataProduct() async {
  final String apiUrl = '${OrderinAppConstant.baseURL}/dataproduct';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    List<Product> dataobj = [];
    
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData['status'] == 'success') {
        // tampilkan data
        List<dynamic> data = responseData['data'];

        // tampilkan data object

        listProd = data.map((item) => Product.fromJson(item)).toList();
        // });

        // for (var element in data) {
        //   Product model = Product.fromJson(
        //     element as Map<String, dynamic>,
        //   );
        //   // menyimpan model kedalam list
        //   dataobj.add(model);

        //   // Logger().i(
        //   //   'nama => ${model.namaProduct},  harga => ${model.hargaProduct},  stock => ${model.stockProduct},  gambar => ${model.gambarProduct},  jenis => ${model.jenisProduct}');
        //   print('==============================');
        //   print(model.namaProduct);
        //   print(model.hargaProduct);
        //   print('==============================');
        // }

        for (var element in listProd) {
          // Product model = Product.fromJson(
          //   element as Map<String, dynamic>,
          // );
          // menyimpan model kedalam list
          // dataobj.add(model);

          // Logger().i(
          //   'nama => ${model.namaProduct},  harga => ${model.hargaProduct},  stock => ${model.stockProduct},  gambar => ${model.gambarProduct},  jenis => ${model.jenisProduct}');
          print('==============================');
          print(element.namaProduct);
          print(element.hargaProduct);
          print('==============================');
        }

        // listProd.forEach((product) {
        //   print(product);
        // });

        // print(data);

        print('berhasil didapat');
        Logger().i('its works');

      } else {
        // tampilkan error nya
        print('data gagal di dapat');
      }
    }
  } catch (e) {
    print('error => ${e}');
  }
}

void main() {
  try {
    getDataProduct();
  } catch (e) {
    print(e);
  }
}
