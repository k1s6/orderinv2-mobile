import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    height: 140,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [Text('Username')],
                ),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    decoration: InputDecoration(
                        // icon: Icon(Icons.person),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan)),
                        prefixIcon: Icon(Icons.person)),
                  ))
            ],
          )),
        ),
      ),
    );
  }
}

class TextfieldLogin extends StatelessWidget {
  const TextfieldLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(children: [
      Text('Username'),
      // TextField(),
      Text('Password'),
    ]));
  }
}
