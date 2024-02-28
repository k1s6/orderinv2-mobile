import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderez/view/Pesanan.dart';

class ButtonLogs extends StatelessWidget {
  const ButtonLogs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(Pesanan()),
      child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
              color: Colors.yellow,
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
