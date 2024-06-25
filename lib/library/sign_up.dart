import 'dart:js';

import 'package:flutter/material.dart';
import 'package:jar/library/auth.dart';
import 'package:jar/library/home.dart';

class MyForm extends StatefulWidget {
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  var authService = AuthService();
  var isLoader = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = false;
      });
      var data = {
        "email": _emailController.text,
        "password": _passwordController.text
      };
      await authService.createUser(data, context);
       setState(() {
        isLoader = true;
      });
      // ScaffoldMessenger.of(_formKey.currentContext!)
      //     .showSnackBar(const SnackBar(content: Text("Submited")));
    }
  }

  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return "Please Enter an Email";
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? _validatePassword(value) {
    if (value!.isEmpty) {
      return "Please Enter an Password";
    }
    // RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    // if (!emailRegExp.hasMatch(value)) {
    //   return "Please enter a valid email";
    // }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black38,
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 180,
              ),
              TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: _buildInputDecoration("Username", Icons.person),
                  validator: _validateEmail),
              SizedBox(height: 20), // Provides a space between the text fields
              TextFormField(
                  controller: _passwordController,
                  validator: _validatePassword,
                  decoration:
                      _buildInputDecoration("Password", Icons.password)),
              SizedBox(height: 20), // Provides space before the button
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                  },
                  child: Text("Let's Go"))
            ],
          ),
        ),
      ),
    );
  }
}

InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
  return InputDecoration(
      labelText: label,
      fillColor: Color.fromARGB(52, 248, 248, 249),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
      filled: true,
      labelStyle: TextStyle(color: Color.fromARGB(224, 252, 249, 249)),
      suffixIcon: Icon(
        suffixIcon,
        color: const Color.fromARGB(232, 255, 255, 255),
      ),
      hintText: "UserName",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)));
}
