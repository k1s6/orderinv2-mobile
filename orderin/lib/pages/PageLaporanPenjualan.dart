import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orderin/configuration/Constant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PageLaporanPenjualan extends StatefulWidget {
  const PageLaporanPenjualan({super.key});

  @override
  _PageLaporanPenjualanState createState() => _PageLaporanPenjualanState();
}

class _PageLaporanPenjualanState extends State<PageLaporanPenjualan> {
  int selectedMonthIndex =
      DateTime.now().month; // Initialize with current month
  late String selectedYear;
  late Future<void> _laporanPengeluaran;
  List<Widget> listItems = []; // Store list items dynamically
  int totalItemsSoldToday = 0; // Variable to store the total items sold today
  int pembeliHariini = 0;
  int pemasukanHariIni = 0;
  int pendapatanTahun = 0;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    selectedMonthIndex = now.month; // Store current month index
    selectedYear = now.year.toString(); // Get current year
    _laporanPengeluaran = fetchLaporanPengeluaran(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdown untuk bulan dan tahun
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<int>(
                    value: selectedMonthIndex,
                    items: List.generate(12, (index) {
                      return DropdownMenuItem<int>(
                        value: index + 1,
                        child: Text(DateFormat('MMMM', 'id_ID')
                            .format(DateTime(0, index + 1))), // Month name
                      );
                    }),
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedMonthIndex = newValue!;
                        _laporanPengeluaran =
                            fetchLaporanPengeluaran(context); // Trigger fetch
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: selectedYear,
                    items: List.generate(5, (index) {
                      int year = DateTime.now().year - index;
                      return DropdownMenuItem<String>(
                        value: year.toString(),
                        child: Text(year.toString()),
                      );
                    }),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedYear = newValue!;
                        _laporanPengeluaran =
                            fetchLaporanPengeluaran(context); // Trigger fetch
                      });
                    },
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Kotak Pendapatan
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.account_balance_wallet, size: 30),
                    SizedBox(height: 8),
                    Text(
                      'Pendapatan per Tahun ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Rp  $pendapatanTahun',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Informasi tambahan
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoBox(
                    'Pemasukan Hari Ini',
                    'Rp ${NumberFormat('#,##0', 'id_ID').format(pemasukanHariIni)}', // Format pemasukan
                  ),
                  _infoBox('Menu Terjual Hari Ini',
                      '$totalItemsSoldToday item'), // Display total items sold
                  _infoBox('Pembeli Hari Ini', '$pembeliHariini orang'),
                ],
              ),

              SizedBox(height: 16),

              // Data Penjualan
              Text(
                'Data Penjualan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              FutureBuilder<void>(
                future: _laporanPengeluaran, // Await the future
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Loading indicator
                  } else if (snapshot.hasError) {
                    return Center(
                        child:
                            Text('Error: ${snapshot.error}')); // Error message
                  } else {
                    return Column(
                      children: listItems, // Display dynamic list items
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk info ringkasan
  Widget _infoBox(String title, String value) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk daftar transaksi
  Widget _listItem(String name, String date, String time) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$date\n$time'),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Future<void> fetchLaporanPengeluaran(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(OrderinAppConstant.laporanPenjualan),
        body: ({
          'bulan': selectedMonthIndex.toString(), // Send index
          'tahun': selectedYear,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        pendapatanTahun = int.parse(data['pendapatanTahun']);

        if (data is Map<String, dynamic> && data.containsKey('data')) {
          List<dynamic> items = data['data']; // Extract the list from 'data'
          List<Widget> newListItems = [];
          int itemCount = 0; // Counter for total items sold
          int pembeli = 0;
          int pemasukan = 0;

          for (var item in items) {
            // Extract necessary fields
            String name = item['nama'] ?? 'Unknown';
            String imageUrl =
                '${OrderinAppConstant.gambar}${item['gambar_product']}';
            int jumlah = item['jumlah'] ?? 0;
            int total = item['total'] ?? 0;
            DateTime createdAt = DateTime.parse(item['created_at']);
            String day = DateFormat('EEEE', 'id_ID').format(createdAt); // Day
            String date =
                DateFormat('d MMMM yyyy', 'id_ID').format(createdAt); // Date
            String time = DateFormat('HH:mm:ss').format(createdAt); // Time

            // Add item to the list
            newListItems
                .add(_listItemWithImage(name, imageUrl, '$day, $date', time));

            // Increment counters
            itemCount += jumlah;
            pembeli += 1;
            pemasukan += total;
          }

          setState(() {
            listItems = newListItems; // Update the list items
            totalItemsSoldToday = itemCount; // Update total items sold
            pembeliHariini = pembeli; // Update pembeli count
            pemasukanHariIni = pemasukan; // Update pemasukan
          });
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        print('Error: ${response.statusCode}');
        throw Exception('Failed to load laporan');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Widget for list item with image
  Widget _listItemWithImage(
      String name, String imageUrl, String date, String time) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Image.network(
          imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.broken_image,
                size: 50); // Fallback for broken images
          },
        ),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$date\n$time'),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
