import 'package:flutter/material.dart';

class TextFieldEdit extends StatefulWidget {
  const TextFieldEdit({
    super.key,
    required this.controller,
    required this.validator,
  });

  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  State<TextFieldEdit> createState() => _TextFieldEditState();
}

class _TextFieldEditState extends State<TextFieldEdit> {
  // final String price;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
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
      ),
      validator: widget.validator,
    );
  }
}
