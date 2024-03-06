import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:orderez/tugas/halamandua.dart';

class gambarClass extends StatefulWidget {
  const gambarClass({super.key});

  @override
  State<gambarClass> createState() => _gambarClassState();
}

class _gambarClassState extends State<gambarClass> {
  final List<String> gambar = [
    "gbr1.jpg",
    "gbr2cp.jpg",
    "gbr3.jpg",
    "gbr4.jpg",
    "gbr5.jpg",
    "gbr6.jpg",
    "gbr7.jpg",
    "gbr8.jpg",
  ];

  static const Map<String, Color> colors = {
    "gbr1": Colors.teal,
    "gbr2": Colors.red,
    "gbr3": Colors.yellow,
    "gbr4": Colors.cyan,
    "gbr5": Colors.black,
    "gbr6": Colors.white,
    "gbr7": Colors.orange,
    "gbr8": Colors.blue,
  };

  @override
  Widget build(BuildContext context) {
    timeDilation = 2;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
              Colors.white,
              Colors.purpleAccent,
              Colors.deepPurple
            ])),
        child: PageView.builder(
            controller: PageController(viewportFraction: 0.8),
            itemCount: gambar.length,
            itemBuilder: (context, int i) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 50.0),
                child: Material(
                  elevation: 8.0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                          tag: gambar[i],
                          child: Material(
                            child: InkWell(
                              child: new Flexible(
                                  flex: 1,
                                  child: Container(
                                    color: colors.values.elementAt(i),
                                    child: Image.asset(
                                      "lib/imgtugas/${gambar[i]}",
                                    ),
                                  )),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => HalamanDua(
                                          gambar: gambar[i],
                                          colors: colors.values.elementAt(i),
                                        )),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
