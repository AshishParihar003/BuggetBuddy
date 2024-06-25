import 'package:flutter/material.dart';
import 'package:jar/HomePage/category_dropdown.dart';
// Ensure this file contains correct DropdownMenuItem

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({super.key});

  @override
  State<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  String type = "credit"; // Ensure this is one of the values in your DropdownButtonFormField
  String category = "Others"; // Make sure "Others" is a value in CategoryDropDown

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoader = false;
  var appValidator = AppValidator(); // Assuming this exists and is correctly implemented

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });
      // Simulate a network call or database operation
      await Future.delayed(Duration(seconds: 2));
      // Then, if successful or on error, you set loading to false
      setState(() {
        isLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 25),
                TextFormField(
                  validator: appValidator.isEmptyCheck,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: appValidator.isEmptyCheck,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Amount"),
                ),
                const SizedBox(height: 16),
                CategoryDropDown(
                    catType: category,
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          category = value;
                        });
                      }
                    }),
                DropdownButtonFormField<String>(
                    value: type,
                    items: const [
                      DropdownMenuItem(child: Text("Credit"), value: 'credit'),
                      DropdownMenuItem(child: Text("Debit"), value: 'debit'),
                    ],
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          type = value;
                        });
                      }
                    }),
                const SizedBox(height: 26),
                ElevatedButton(
                  onPressed: isLoader ? null : _submitForm,
                  child: isLoader
                      ? const Center(child: CircularProgressIndicator())
                      : const Text("Add Transaction"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Dummy class definition, ensure to replace it with your actual validation class
class AppValidator {
  String? isEmptyCheck(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }
}
