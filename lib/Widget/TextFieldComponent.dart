import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent(
      {super.key,
      required this.controller,
      required this.obscure,
      required this.hinttxt,
      required this.icon});

  final controller;
  final bool obscure;
  final String hinttxt;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: hinttxt,
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              prefixIcon: icon),
        ));
  }
}
