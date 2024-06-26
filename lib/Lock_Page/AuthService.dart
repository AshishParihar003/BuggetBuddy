
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jar/HomePage/HomePage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(Map<String, dynamic> data, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: data["email"], password: data['password']);

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        "username": data["username"],
        "email": data["email"],
        "phone": data["phone"],
        "remainingAmount": data['remainingAmount'],
        "totalCredit": data['totalCredit'],
        "totalDebit": data['totalDebit'],
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard()));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Sign Up Failed"),
              content: Text(e.toString()),
            );
          });
    }
  }
}

