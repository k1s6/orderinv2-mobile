import 'package:flutter/material.dart';
import 'package:orderez/theme.dart';
import 'package:get/get.dart';
import 'package:orderez/view/ListMenu.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    const String appTitle = 'order-in';

    return MaterialApp(
        title: appTitle,
        debugShowCheckedModeBanner: true,
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(title: const Text(appTitle), backgroundColor: green1),
            body: const SingleChildScrollView(
                child: Column(
              children: [
                TitleSection(name: 'Pramudya', location: 'kediri'),
                ButtonSection(),
                CobaCoba(
                    description:
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys'
                        'standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled'
                        'it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic'
                        'typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, '
                        'and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.')
              ],
            )),
          ),
        ));
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.name,
    required this.location,
  });

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          const Text('41'),
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonWithText(
          color: color,
          icon: Icons.call,
          label: 'CALL',
          onTap: () {
            print("halaman Call");
          },
        ),
        ButtonWithText(
          color: color,
          icon: Icons.near_me,
          label: 'ROUTE',
          onTap: () async {
            Get.to(ListMenu());
          },
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
    ));
  }
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText(
      {super.key,
      required this.color,
      required this.icon,
      required this.label,
      required this.onTap});

  final Color color;
  final IconData icon;
  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              onTap;
            },
            child: Icon(icon, color: color)),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class CobaCoba extends StatelessWidget {
  const CobaCoba({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }
}
