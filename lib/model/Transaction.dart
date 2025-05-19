import 'dart:convert';

import 'package:orderez/model/Product.dart';

Transaksi transaksiFromJson(String str) => Transaksi.fromJson(json.decode(str));

String transaksiToJson(Transaksi data) => json.encode(data.toJson());

class Transaksi {
  final int kodeTransaksi;
  final String nama;
  final String status;
  final int jumlah;
  final int total;
  final String? catatan;
  final String createdAt;
  final String updatedAt;
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

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
      kodeTransaksi: json['kode_transaksi'],
      nama: json['nama'],
      status: json['status'],
      jumlah: json['jumlah'],
      total: json['total'],
      catatan: json['catatan'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      details: (json['details'] as List<dynamic>)
          .map((detail) => Detail.fromJson(detail))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "kode_transaksi": kodeTransaksi,
        "nama": nama,
        "status": status,
        "jumlah": jumlah,
        "total": total,
        "catatan": catatan,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
      };
}

class Detail {
  final int kodeTransaksi;
  final String namaProduct;
  final int jumlah;
  final int harga;
  final int total;
  final String? catatan;
  final int kodeProduct;

  Detail({
    required this.kodeTransaksi,
    required this.namaProduct,
    required this.jumlah,
    required this.harga,
    required this.total,
    this.catatan,
    required this.kodeProduct,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      kodeTransaksi: json['kode_transaksi'],
      namaProduct: json['nama_product'],
      jumlah: json['jumlah'],
      harga: json['harga'],
      total: json['total'],
      catatan: json['catatan'],
      kodeProduct: json['kode_product'],
    );
  }

  Map<String, dynamic> toJson() => {
        "kode_transaksi": kodeTransaksi,
        "nama_product": namaProduct,
        "jumlah": jumlah,
        "harga": harga,
        "total": total,
        "catatan": catatan,
        "kode_product": kodeProduct,
      };
}
