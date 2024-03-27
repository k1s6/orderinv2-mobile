import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderez/Widget/TextFieldComponent.dart';
import 'package:orderez/Widget/ButtonLogs.dart';
import 'package:orderez/theme.dart';
import 'package:orderez/view/Pesanan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> _login() async {
    print('dahlah');
    final String apiUrl =
        'http://localhost/apimobileorderin/login.php'; // Ganti dengan alamat API login Anda
    final response = await http.post(Uri.parse(apiUrl),
        body: jsonEncode({
          'username': usernameController.text,
          'password': passwordController.text,
        }));

    final responseData = jsonDecode(response.body);
    if (responseData['status'] == 'success') {
      // Navigasi ke halaman setelah login berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Pesanan()),
      );
    } else {
      // Tampilkan pesan kesalahan jika login gagal
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Gagal'),
            content: Text(responseData['message']),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

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
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
