import 'package:flutter/material.dart';
import 'package:orderez/Widget/ListTileComponent.dart';
import 'package:orderez/Widget/ListCardPesanan.dart';
import 'package:orderez/view/LoginUser.dart';

class PagePesanan extends StatelessWidget {
  const PagePesanan({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 14.0),
      child: ListView(
        children: [ListCardPesanan(), ListCardPesanan()],
      ),
    );
  }
}
