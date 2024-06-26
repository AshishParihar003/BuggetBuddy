import 'package:flutter/material.dart';
import 'package:jar/HomePage/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jar/Lock_Page/Login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoader = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

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

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      isLoader = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Dashboard()));
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login Failed"),
          content: Text(e.message ?? "An unexpected error occurred."),
        ),
      );
    } finally {
      setState(() {
        isLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 100),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text("Login",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple)),
                ),
                const SizedBox(height: 40),
                buildTextFormField(
                    controller: _emailController,
                    label: "Email",
                    icon: Icons.email,
                    validator: _validateEmail),
                const SizedBox(height: 20),
                buildTextFormField(
                    controller: _passwordController,
                    label: "Password",
                    icon: Icons.lock,
                    obscureText: true,
                    validator: _validatePassword),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple, // text color
                  ),
                  onPressed: isLoader ? null : _login,
                  child: isLoader
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Log In"),
                ),
                TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage())),
                    child: const Text("New Account",
                        style: TextStyle(color: Colors.deepPurple))),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.deepPurpleAccent),
        ),
      ),
      keyboardType: obscureText
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      obscureText: obscureText,
      validator: validator,
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter an email';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.[\w-]{2,4})$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Please enter a password";
    return null;
  }
}
