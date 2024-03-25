import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderez/Widget/TextFieldComponent.dart';
import 'package:orderez/Widget/ButtonLogs.dart';
import 'package:orderez/theme.dart';
import 'package:orderez/view/Pesanan.dart';

class LoginUser extends StatefulWidget {
  LoginUser({super.key});

  // text editing controller

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Function toPesanan = () => {};

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/images/bg.png'),
                opacity: 0.5,
                fit: BoxFit.cover)),
        child: Center(
          child: (Column(
            children: [
              const SizedBox(
                height: 90,
              ),
              Column(
                children: [
                  Image.asset(
                    'lib/images/app_logo.png',
                    height: 180,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo Admin!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          'Lakukan login untuk melanjutkan',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 14),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextFieldComponent(
                controller: usernameController,
                obscure: false,
                hinttxt: 'Username',
                icon: const Icon(Icons.person),
              ),
              const SizedBox(height: 25),
              TextFieldComponent(
                controller: passwordController,
                obscure: true,
                hinttxt: 'Password',
                icon: const Icon(Icons.lock),
              ),
              const SizedBox(
                height: 70,
              ),
              const ButtonLogs()
            ],
          )),
        ),
      ),
    );
  }
}
