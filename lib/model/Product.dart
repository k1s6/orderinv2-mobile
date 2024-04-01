import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    String namaProduct;
    String gambarProduct;
    num hargaProduct;
    String stockProduct;
    String jenisProduct;

    Product({
        required this.namaProduct,
        required this.gambarProduct,
        required this.hargaProduct,
        required this.stockProduct,
        required this.jenisProduct,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        namaProduct: json["nama_product"],
        gambarProduct: json["gambar_product"],
        hargaProduct: json["harga_product"]?.toDouble(),
        stockProduct: json["stock_product"],
        jenisProduct: json["jenis_product"],
    );

    Map<String, dynamic> toJson() => {
        "nama_product": namaProduct,
        "gambar_product": gambarProduct,
        "harga_product": hargaProduct,
        "stock_product": stockProduct,
        "jenis_product": jenisProduct,
    };
}
