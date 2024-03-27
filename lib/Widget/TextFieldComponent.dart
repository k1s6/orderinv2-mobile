import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldComponent extends StatefulWidget {
  TextFieldComponent(
      {super.key,
      required this.controller,
      required this.obscure,
      required this.hinttxt,
      required this.icon});

  final controller;
  bool obscure;
  final String hinttxt;
  final Icon icon;

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  void toggleVisibility() {
    setState(() {
      widget.obscure = !widget.obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
            controller: widget.controller,
            obscureText: widget.obscure,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: widget.hinttxt,
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              prefixIcon: widget.icon,
              suffixIcon: widget.hinttxt == "Password"
                  ? IconButton(
                      icon: Icon(
                        widget.obscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: toggleVisibility,
                    )
                  : null,
            )));
  }
}
