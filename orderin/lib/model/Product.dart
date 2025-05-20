import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  final int kodeProduct;
  final String? namaProduct;
  final int? hargaProduct;
  final String? gambarProduct;
  final String? stockProduct;
  final String? descProduct;
  final String? jenisProduct;
  final String? createdAt; // Add created_at field
  final String? updatedAt; // Add updated_at field

  Product({
    required this.kodeProduct,
    this.namaProduct,
    this.hargaProduct,
    this.gambarProduct,
    this.stockProduct,
    this.descProduct,
    this.jenisProduct,
    this.createdAt, // Initialize createdAt
    this.updatedAt, // Initialize updatedAt
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      kodeProduct: json['kode_product'] as int,
      namaProduct: json['nama_product'] as String?,
      hargaProduct: json['harga_product'] as int?,
      gambarProduct: json['gambar_product'] as String?,
      stockProduct: json['stock_product'] as String?,
      descProduct: json['deskripsi'] as String?,
      jenisProduct: json['jenis_product'] as String?,
      createdAt: json['created_at'] as String?, // Parse created_at
      updatedAt: json['updated_at'] as String?, // Parse updated_at
    );
  }

  Map<String, dynamic> toJson() => {
        "kode_product": kodeProduct,
        "nama_product": namaProduct,
        "gambar_product": gambarProduct,
        "harga_product": hargaProduct,
        "stock_product": stockProduct,
        "jenis_product": jenisProduct,
        "deskripsi": descProduct,
        "created_at": createdAt, // Include created_at
        "updated_at": updatedAt, // Include updated_at
      };
}
