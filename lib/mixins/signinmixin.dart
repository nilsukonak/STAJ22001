import 'package:flutter/material.dart';
import 'package:todoapp/screens/login.dart';
import 'package:todoapp/screens/signin.dart';

mixin SigninMixin on State<Signin> {
  void initState() {
    super.initState();
  }

  Future<void> SigninWithEmailAndPassword(String email, String password) async {
    try {
      await services.signin(emailcont.text, passcontroller.text);

      ///auth_services.dart ta signin fonksiyonuyla beraber firebaseye kaydediyorum
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("kayit olma basarısz  ${e.toString()}")),
      );
    }
  }

  void navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }
}
