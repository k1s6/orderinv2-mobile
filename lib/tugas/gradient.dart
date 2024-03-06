
import 'package:flutter/material.dart';

class GradientClass extends StatefulWidget {
  const GradientClass({super.key});

  @override
  State<GradientClass> createState() => _GradientClassState();
}

class _GradientClassState extends State<GradientClass> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter, colors:[Colors.white, Colors.purpleAccent, Colors.deepPurple])
        ),
      ),
    );
  }
}
