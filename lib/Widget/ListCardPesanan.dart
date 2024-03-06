import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orderez/view/ListMenu.dart';

class ListCardPesanan extends StatelessWidget {
  const ListCardPesanan({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: null,
      child: InkWell(
        onTap: () {
          // pengalihan sementara
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ListMenu()));
        },
        splashColor: Colors.amberAccent,
        child: const Padding(
          padding: EdgeInsets.all(7.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John Doe', style: TextStyle(fontSize: 20)),
                      Text('Wednesday, 06 March 2024'),
                      Text('12:59:00'),
                    ],
                  )),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.amber,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
