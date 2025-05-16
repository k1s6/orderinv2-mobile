import 'dart:convert';

import 'package:orderez/model/Product.dart';

Transaksi transaksiFromJson(String str) => Transaksi.fromJson(json.decode(str));

String transaksiToJson(Transaksi data) => json.encode(data.toJson());

class Transaksi {
  
  final int kodeTransaksi;
  final String nama;
  final String status;
  final int jumlah;
  // int jumlah;
  final String total;
  // int total;
  final String? catatan;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Detail> details;

  Transaksi({
    required this.kodeTransaksi,
    required this.nama,
    required this.status,
    required this.jumlah,
    required this.total,
    this.catatan,
    required this.createdAt,
    required this.updatedAt,
    required this.details,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        kodeTransaksi: json["kode_transaksi"],
        nama: json["nama"],
        status: json["status"],
        jumlah:
            json["jumlah"] is int ? json["jumlah"] : int.parse(json["jumlah"]),
        total: json["total"].toString(),
        catatan: json["catatan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kode_transaksi": kodeTransaksi,
        "nama": nama,
        "status": status,
        "jumlah": jumlah,
        "total": total,
        "catatan": catatan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
      };
}

class Detail {
  final String kodeTransaksi;
   // int kodeTransaksi;
  final String namaProduct;
  final String jumlah;
   // int jumlah;
  final String harga;
   // int harga;
  final String total;
   // int total;

  Detail({
    required this.kodeTransaksi,
    // required this.kodeProduct,
    required this.namaProduct,
    required this.jumlah,
    required this.harga,
    required this.total,
    // required this.product,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        kodeTransaksi: json["kode_transaksi"].toString(),
        // kodeProduct: json["kode_product"],
        namaProduct: json["nama_product"],
        jumlah:
            json["jumlah"] is int ? json["jumlah"].toString() : json["jumlah"],
        harga: json["harga"].toString(),
        total: json["total"].toString(),
        // product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "kode_transaksi": kodeTransaksi,
        // "kode_product": kodeProduct,
        "nama_product": namaProduct,
        "jumlah": jumlah,
        "harga": harga,
        "total": total,
        // "product": product.toJson(),
      };
}
