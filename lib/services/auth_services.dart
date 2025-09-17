import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signin(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection('user').doc(userCredential.user!.uid).set({
        'email': email,
        'password': password,
      });
      await Fluttertoast.showToast(
        msg: 'kayıt basarılı',
        backgroundColor: Colors.green,
      );
    } catch (e) {
      await Fluttertoast.showToast(
        msg: 'kayıt basarısız :$e',
        backgroundColor: Colors.red,
      );
    }
  }
}
