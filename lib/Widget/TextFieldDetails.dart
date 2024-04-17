import 'package:flutter/material.dart';

class TextFieldDetails extends StatelessWidget {
  const TextFieldDetails({super.key, required this.controller});

  final controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          // textAlign: TextAlign.center,
          decoration: const InputDecoration(
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