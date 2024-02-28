import 'package:flutter/material.dart';
import 'package:orderez/Widget/ListTileComponent.dart';
import 'package:orderez/view/LoginUser.dart';

class PagePesanan extends StatelessWidget {
  const PagePesanan({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListtilComponent(selected: false, name: 'name', icons: Icon(Icons.ac_unit_outlined), destination: LoginUser()),
        ListtilComponent(selected: false, name: 'name', icons: Icon(Icons.ac_unit_outlined), destination: LoginUser()),
        ListtilComponent(selected: false, name: 'name', icons: Icon(Icons.ac_unit_outlined), destination: LoginUser()),
      ],
    );
  }
}