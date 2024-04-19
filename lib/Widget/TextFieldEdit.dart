import 'package:flutter/material.dart';

class TextFieldEdit extends StatelessWidget {
  const TextFieldEdit({
    super.key,
    required this.controller,
  });

  final controller;
  // final String price;
  // final String stock;
  // final String jenis;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          )),
    );
  }
}
