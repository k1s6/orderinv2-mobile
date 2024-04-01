import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class FakeAppUtil {


  static Future<void> signInAsAnonymous() async {
    try {
      final credential = await FirebaseAuth.instance.signInAnonymously();
      Logger().i(
          'Signed in with anonymous account -> UID : ${credential.user?.uid}');
    } catch (ex) {
      Logger().e(ex.toString());
    }
  }

}