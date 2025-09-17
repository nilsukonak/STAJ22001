import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/screens/login.dart';
import 'package:todoapp/screens/tasks.dart';
import 'package:todoapp/screens/signin.dart';

mixin LoginMixin on State<Login> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> LogInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (mounted) {
        //sadeec ekrandaysan calıstr
        //await ile çalışan uzun işlemler (örneğin Firebase ile giriş yapma) sırasında, kullanıcı başka sayfaya geçmiş olabilir. O zaman artık context geçersiz olur ve Navigator gibi şeyler çalıştırmak hata verir.
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Tasks()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';

      if (e.code == 'user-not-found') {
        errorMessage = 'bu e postayla kimse yok';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'yanlis sifre';
      } else {
        errorMessage = 'giris basarisiz:${e.message}';
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      }
    }
  }

  void navigateToSignIn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Signin()),
    );
  }
}
