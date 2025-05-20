import 'package:flutter/material.dart';
import 'package:orderin/theme.dart';

class ButtonDetailMenu extends StatelessWidget {
  const ButtonDetailMenu(
      {super.key, required this.color, required this.btntype});

  final Color color;
  final String btntype;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(6))),
        child: Center(
          child: Text(
            btntype,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
