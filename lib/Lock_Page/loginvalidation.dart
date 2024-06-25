import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jar/HomePage/Dashboard.dart';
import 'package:jar/HomePage/database.dart';

class AppValidatior {
  var db = DB();
  createUser(data, context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: data["email"], password: data['password']);
      await db.addUser(data, context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Sign Up Failed"),
              content: Text(e.toString()),
            );
          });
    }
  }

  login(data, context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: data["email"], password: data['password']);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Sign Up Failed"),
              content: Text(e.toString()),
            );
          });
    }
  }
}