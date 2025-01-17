import 'package:flutter/material.dart';
import 'package:jar/data/icon_data.dart';

class CategoryDropDown extends StatelessWidget {
  CategoryDropDown(
      {super.key,
      this.cattype,
      required this.onChanged,
      required String catType});
  final String? cattype;
  final ValueChanged<String?> onChanged;
  final AppIcons appIcons = AppIcons();

  @override
  Widget build(BuildContext context) {
    Map<String, IconData> categoryMap = {};
    for (var category in appIcons.homeExpensesCategories) {
      categoryMap[category["name"]] = category["icon"];
    }

    List<DropdownMenuItem<String>> menuItems = categoryMap.entries.map((e) {
      return DropdownMenuItem<String>(
        value: e.key,
        child: Row(
          children: [
            Icon(e.value,
                color: Colors.black45,
                size: 24), // Ensure icons are not too large
            const SizedBox(width: 10),
            Expanded(
              // Allows text to adjust within available space
              child: Text(e.key,
                  style: const TextStyle(
                      color: Colors.black45, overflow: TextOverflow.ellipsis)),
            ),
          ],
        ),
      );
    }).toList();

    return DropdownButton<String>(
      value:
          cattype != null && categoryMap.containsKey(cattype) ? cattype : null,
      isExpanded: true,
      hint: const Text("Select Category"),
      items: menuItems,
      onChanged: onChanged,
      dropdownColor: Colors.white,
    );
  }
}

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({super.key});

  @override
  State<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  var type = "credit";
  var category = "Others";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Amount"),
              ),
              CategoryDropDown(
                cattype: category,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      category = value;
                    });
                  }
                },
                catType: '',
              ),
              DropdownButtonFormField(
                value: type,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      type = value;
                    });
                  }
                },
                items: const [
                  DropdownMenuItem(value: 'credit', child: Text("Credit")),
                  DropdownMenuItem(value: 'debit', child: Text("Debit")),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {}, child: const Text("Add Transaction")),
            ],
          ),
        ),
      ),
    );
  }
}
