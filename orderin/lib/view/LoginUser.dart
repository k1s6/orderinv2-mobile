import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderin/Widget/TextFieldComponent.dart';
import 'package:orderin/Widget/ButtonLogs.dart';
import 'package:orderin/configuration/Constant.dart';
import 'package:orderin/theme.dart';
import 'package:orderin/view/Pesanan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  // text editing controller

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Function toPesanan = () => {};

  static Future<void> signIn(
      String username, String password, BuildContext context) async {
    // Ganti URL sesuai dengan URL endpoint Anda
    final String apiUrl = '${OrderinAppConstant.baseURL}/login';

    try {
      // Kirim permintaan HTTP POST ke server
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'username': username,
          'password': password,
        },
      );

      // Periksa status code respons dari server
      if (response.statusCode == 200) {
        // Decode respons JSON
        final responseData = json.decode(response.body);

        // Periksa status dalam respons
        if (responseData['status'] == 'success') {
          // Jika login berhasil, dapatkan response message
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Pesanan()),
          );

          // Lakukan apa yang perlu dilakukan setelah login berhasil, misalnya navigasi ke halaman beranda
        } else {
          // Jika login gagal, dapatkan pesan error
          String errorMessage = responseData['message'];
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
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Gagal'),
              content: Text('username atau password salah'),
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
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Gagal'),
            content: Text('server error'),
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

  Future<void> _login() async {
    print('login func called');
    final String apiUrl = '${OrderinAppConstant.baseURL}/login';
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
              GestureDetector(
                onTap: () async {
                  // parameter 1 mengambil value username, parameter 2 mengambil value password
                  await signIn(usernameController.text, passwordController.text,
                      context);
                },
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  splashColor: Colors.transparent,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                          color: yellowcustom2,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
