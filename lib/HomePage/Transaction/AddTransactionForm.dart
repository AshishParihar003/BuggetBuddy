import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jar/HomePage/HomePage.dart';

import 'package:jar/HomePage/category_dropdown.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({Key? key}) : super(key: key);

  @override
  State<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoader = false;
  String type = "credit";
  String category = "Others";
  Uuid uuid = Uuid();

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => isLoader = true);

    try {
      String userId = _auth.currentUser!.uid;
      int amount = int.parse(_amountController.text);
      String id = uuid.v4();
      DateTime now = DateTime.now();
      String monthYear = DateFormat('MMM y').format(now);
      int timestamp = now.microsecondsSinceEpoch;

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      int newAmount = type == 'credit'
          ? userData['remainingAmount'] + amount
          : userData['remainingAmount'] - amount;
      int totalCredit =
          userData['totalCredit'] + (type == 'credit' ? amount : 0);
      int totalDebit = userData['totalDebit'] + (type == 'debit' ? amount : 0);

      await _firestore.collection('users').doc(userId).update({
        'remainingAmount': newAmount,
        'totalCredit': totalCredit,
        'totalDebit': totalDebit,
      });

      await _firestore.collection('transactions').add({
        'userId': userId,
        'id': id,
        'title': _titleController.text,
        'amount': amount,
        'type': type,
        'category': category,
        'monthYear': monthYear,
        'timestamp': timestamp,
        'remainingAmount': newAmount,
        'totalCredit': totalCredit,
        'totalDebit': totalDebit,
      });

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Dashboard()));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      setState(() => isLoader = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Amount"),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter an amount' : null,
              ),
              const SizedBox(height: 20),
              CategoryDropDown(
                catType: category,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() => category = newValue);
                  }
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: type,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() => type = newValue);
                  }
                },
                items: const [
                  DropdownMenuItem(value: "credit", child: Text("Credit")),
                  DropdownMenuItem(value: "debit", child: Text("Debit")),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: isLoader ? null : _submitForm,
                child: isLoader
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Add Transaction"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
