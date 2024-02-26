import 'package:flutter/material.dart';
import '../view/Login.dart';
import 'package:get/get.dart';
import 'ListMenu.dart';

class Login2 extends StatefulWidget {
  const Login2({super.key});

  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pramudya",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(ListMenu());
                          },
                          child: Text(
                            "Pramudya",
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Icon(Icons.star),
                        Text("50"),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWithText(
                      color: color,
                      icon: Icons.call,
                      label: 'CALL',
                      onTap: () {
                        print("halaman Call");
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ButtonWithText(
                      color: color,
                      icon: Icons.near_me,
                      label: 'ROUTE',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListMenu()));
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ButtonWithText(
                      color: color,
                      icon: Icons.share,
                      label: 'SHARE',
                      onTap: () {
                        print("halaman Share");
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
