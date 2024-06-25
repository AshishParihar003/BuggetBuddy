import 'package:flutter/material.dart';
import 'package:jar/HomePage/Dashboard.dart';
import 'package:jar/HomePage/database.dart';
import 'package:jar/Signup.dart/signup.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var authService = AuthService();
  var isLoader = false;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Future<void> _initAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _initAnimation = _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });
      var data = {
        "username": _userNameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "phone": _phoneController.text,
        'remainingAmount': 0,
        'totalCredit': 0,
        'totalDebit': 0,
      };
      // try {
      await authService.createUser(data, context);
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => Dashboard()));

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Form Submitted Successfully")));
      // } catch (e) {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
      // } finally {
      setState(() {
        isLoader = false;
      });
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.[\w-]{2,4})$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a username";
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a phone number";
    }
    if (value.length != 10) {
      return "Please enter a 10-digit phone number";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a password";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initAnimation,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 200,
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 0),
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: const SizedBox(
                                  width: 250,
                                  child: Text(
                                    "Create New Account",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 28,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              _buildAnimatedTextFormField(
                                controller: _userNameController,
                                label: "UserName",
                                icon: Icons.person,
                                validator: _validateUsername,
                              ),
                              const SizedBox(height: 20),
                              _buildAnimatedTextFormField(
                                controller: _emailController,
                                label: "Email",
                                icon: Icons.mail,
                                validator: _validateEmail,
                              ),
                              const SizedBox(height: 20),
                              _buildAnimatedTextFormField(
                                controller: _phoneController,
                                label: "Phone Number",
                                icon: Icons.phone,
                                validator: _validatePhoneNumber,
                                keyboardType: TextInputType.phone,
                              ),
                              const SizedBox(height: 20),
                              _buildAnimatedTextFormField(
                                controller: _passwordController,
                                label: "Password",
                                icon: Icons.password,
                                validator: _validatePassword,
                                obscureText: true,
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: const Color.fromARGB(
                                        255, 248, 247, 247),
                                    backgroundColor:
                                        const Color.fromARGB(255, 26, 42, 214),
                                  ),
                                  onPressed: () {
                                    if (!isLoader) _submitForm();
                                  },
                                  child: isLoader
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : const Text("Create"),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpPage()));
                                },
                                child: const Text("Login"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 120,
                    left: MediaQuery.of(context).size.width / 2 - 40,
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person,
                          size: 50, color: Colors.deepPurple),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildAnimatedTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: _buildInputDecoration(label, icon),
        validator: validator,
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
      labelText: label,
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0x35949494))),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(53, 236, 20, 20))),
      fillColor: const Color.fromARGB(31, 197, 193, 193),
      suffixIcon: Icon(
        suffixIcon,
        color: Colors.black,
      ),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var db = DB();
  Future<void> createUser(data, context) async {
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
}
