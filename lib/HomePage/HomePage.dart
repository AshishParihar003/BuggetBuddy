import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jar/HomePage/Card/herocard.dart';
import 'package:jar/HomePage/Drawer%20and%20Appbar/Drawer.dart';
import 'package:jar/HomePage/Transaction/AddTransactionForm.dart';
import 'package:jar/HomePage/Transaction/TransitionPage.dart';
import 'package:jar/Signup.dart/signup.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var isLogoutLoading = false;

  Future<void> logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignUpPage()));
    setState(() {
      isLogoutLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddTransactionForm()),
        ),
        backgroundColor: Colors.deepOrange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.orange],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
        title: const Text("Welcome"),
        actions: [
          IconButton(
            onPressed: isLogoutLoading ? null : logOut,
            icon: isLogoutLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.exit_to_app, color: Colors.white),
          )
        ],
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(

        child: Column(
          children: [

            HeroCard(userId: userId),
            TransactionScreen(),
          ],
        ),
      ),
    );
  }
}
