import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:orderin/configuration/Constant.dart';
import 'package:orderin/model/BestSellerModel.dart';

class PageBestSeller extends StatefulWidget {
  const PageBestSeller({super.key});

  @override
  _PageBestSellerState createState() => _PageBestSellerState();
}

class _PageBestSellerState extends State<PageBestSeller> {
  String selectedCategory = "makanan"; // Default category
  BestSellerModel? bestSellerData; // Store fetched data
  bool isLoading = false; // Track loading state

  @override
  void initState() {
    super.initState();
    fetchBestSellerData(); // Fetch data initially
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : Column(
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
                              items: ["makanan", "minuman", "snack", "steak"]
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  alignment: AlignmentDirectional.center,
                                  child: Center(child: Text(value)),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedCategory = newValue!;
                                });
                                fetchBestSellerData(); // Fetch new data
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Kartu Menu Best Seller
                Center(
                  child: bestSellerData != null
                      ? Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              // Gambar Menu
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12)),
                                child: bestSellerData!.gambarProduct.isNotEmpty
                                    ? Image.network(
                                        '${OrderinAppConstant.gambar}${bestSellerData!.gambarProduct}',
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      (loadingProgress
                                                              .expectedTotalBytes ??
                                                          1)
                                                  : null,
                                            ),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            "lib/images/bg.png", // Fallback image
                                            height: 180,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      )
                                    : Image.asset(
                                        "lib/images/bg.png", // Fallback image
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                              ),

                              // Nama Menu
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  bestSellerData!.namaProduct,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              // Jumlah Terjual
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(12)),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Terjual Bulan Ini",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    Text(
                                      "${bestSellerData!.totalJumlah} item",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text(
                          'Data belum tersedia',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ],
            ),
    );
  }

  Future<void> fetchBestSellerData() async {
    setState(() {
      isLoading = true; // Start loading
    });
    try {
      final response = await http.post(
        Uri.parse(OrderinAppConstant.menuBestSeller),
        body: {'kategori': selectedCategory},
      ).timeout(const Duration(seconds: 10)); // Add timeout
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['data'] != null && jsonData['data'].isNotEmpty) {
          setState(() {
            bestSellerData = BestSellerModel.fromJson(jsonData['data']);
          });
        } else {
          setState(() {
            bestSellerData = null; // No data available
          });
        }
      } else {
        throw Exception('Failed to load best seller menu');
      }
    } on TimeoutException catch (_) {
      showErrorSnackbar('Request timed out. Please try again.');
    } on http.ClientException catch (_) {
      showErrorSnackbar('Network error. Please check your connection.');
    } catch (e) {
      showErrorSnackbar('Data tidak tersedia'); // Update error message
      setState(() {
        bestSellerData = null; // Ensure no data is displayed
      });
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  void showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
