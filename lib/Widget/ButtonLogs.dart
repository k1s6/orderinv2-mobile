import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderez/view/Pesanan.dart';
import 'package:orderez/theme.dart';

class ButtonLogs extends StatelessWidget {
  const ButtonLogs({
    super.key,
    required this.ontap
  });

  final ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ontap,
      child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
              color: yellowcustom2,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: const Center(
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
    );
  }
}
