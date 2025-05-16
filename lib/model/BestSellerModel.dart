class BestSellerModel {
  final String kodeProduct;
  final String namaProduct;
  final String gambarProduct;
  final String jenisProduct;
  final int totalJumlah;

  BestSellerModel({
    required this.kodeProduct,
    required this.namaProduct,
    required this.gambarProduct,
    required this.jenisProduct,
    required this.totalJumlah,
  });

  factory BestSellerModel.fromJson(Map<String, dynamic> json) {
    return BestSellerModel(
      kodeProduct: json['kode_product'].toString(), // Convert to String
      namaProduct: json['nama_product'] ?? 'Unknown',
      gambarProduct: json['gambar_product'] ?? '',
      jenisProduct: json['jenis_product'] ?? '',
      totalJumlah:
          int.tryParse(json['total_jumlah'].toString()) ?? 0, // Convert to int
    );
  }
}
