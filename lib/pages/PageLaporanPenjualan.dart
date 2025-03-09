import 'package:flutter/material.dart';

class PageLaporanPenjualan extends StatefulWidget {
  @override
  _PageLaporanPenjualanState createState() => _PageLaporanPenjualanState();
}

class _PageLaporanPenjualanState extends State<PageLaporanPenjualan> {
  String selectedMonth = 'Januari';
  String selectedYear = '2025';

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
                  DropdownButton<String>(
                    value: selectedMonth,
                    items: ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
                    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMonth = newValue!;
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: selectedYear,
                    items: ['2025', '2024', '2023']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedYear = newValue!;
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
                      'Pendapatan',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Rp 9.832.000',
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
                  _infoBox('Pemasukan Hari Ini', 'Rp 2.430.000'),
                  _infoBox('Menu Terjual Hari Ini', '42 item'),
                  _infoBox('Pembeli Hari Ini', '20 orang'),
                ],
              ),

              SizedBox(height: 16),

              // Data Penjualan
              Text(
                'Data Penjualan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              _listItem('John Doe', 'Thursday, 12 February 2023', '14:07:05'),
              _listItem('John Doe', 'Thursday, 12 February 2023', '14:07:05'),
              _listItem('John Doe', 'Thursday, 12 February 2023', '14:07:05'),
              _listItem('John Doe', 'Thursday, 12 February 2023', '14:07:05'),
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
          color: Colors.amber[200],
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
}
