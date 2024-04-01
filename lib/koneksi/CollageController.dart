import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:orderez/module/models/collage_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:orderez/model/Product.dart';

class CollageController {
  /// Representasi dari collection "Collages" yang ada di Firestore
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("product");

  /// digunakan untuk mengecek bahwa mahasiswa tersebut ada atau tidak didalam database (berdasarkan nim)
  // Future<bool> isExistStudent(String nim) async {
  //   try {
  //     // mendapatkan data dari database
  //     QuerySnapshot querySnapshot = await _collectionReference
  //         .where('nim', isEqualTo: nim)
  //         .limit(1)
  //         .get();

  //     // jika data kosong maka data dianggap tidak ada
  //     return querySnapshot.docs.isNotEmpty;
  //   } catch (ex) {
  //     return false;
  //   }
  // }

  /// digunakan untuk mendapatkan jumlah total mahasiswa
  Future<int> totalStudent() async {
    try {
      // mendapatkan semua data mahasiswa
      QuerySnapshot querySnapshot = await _collectionReference.get();
      // mendapatkan jumlah mahasiswa
      return querySnapshot.size;
    } catch (ex) {
      return 0;
    }
  }

  /// mendapatkan semua list mahasiswa
  Future<List<Product>> getAllStudent() async {
    try {
      // list kosong untuk menyimpan data
      List<Product> data = [];
      // mendapatkan semua data
      QuerySnapshot querySnapshot = await _collectionReference.get();

      // membaca semua data yang didapatkan
      for (var element in querySnapshot.docs) {
        // menyimpan data kedalam model
        Product model = Product.fromJson(
          element.data() as Map<String, dynamic>,
        );
        // menyimpan model kedalam list
        data.add(model);
        Logger().i(
            'nama => ${model.namaProduct},  harga => ${model.hargaProduct},  stock => ${model.stockProduct},  gambar => ${model.gambarProduct},  jenis => ${model.jenisProduct}');
        // Logger().i('data => ${model.hargaProduct}');
        // Logger().i('data => ${model.stockProduct}');
        // Logger().i('data => ${model.gambarProduct}');
        // Logger().i('data => ${model.jenisProduct}');
      }
      return data;
    } catch (ex) {
      Logger().e(ex);
      return [];
    }
  }

  /// mendapatkan data mahasiswa berdasarkan nim
  // Future<CollageModel?> getStudent(String nim) async {
  //   try {
  //     // mendapatkan data berdasarkan nim
  //     QuerySnapshot querySnapshot = await _collectionReference
  //         .where('nim', isEqualTo: nim)
  //         .limit(1)
  //         .get();

  //     // mengecek apakah data ditemukan atau tidak
  //     if (querySnapshot.docs.isNotEmpty) {
  //       // jika ditemukan maka data akan disimpan didalam model
  //       DocumentSnapshot data = querySnapshot.docs.first;
  //       return CollageModel(
  //         nim: data.get("nim"),
  //         name: data.get("name"),
  //         majoring: data.get("majoring"),
  //         photo: data.get("photo"),
  //       );
  //     } else {
  //       Logger().i('student is not exist');
  //       return null;
  //     }
  //   } catch (ex) {
  //     Logger().e('error -> ${ex.toString()}');
  //     throw Exception(ex);
  //   }
  // }
}

void main(List<String> args) async {
  CollageController controller = CollageController();
  await controller.getAllStudent();
}
