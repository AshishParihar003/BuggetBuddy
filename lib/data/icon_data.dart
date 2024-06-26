import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppIcons {
  final List<Map<String, dynamic>> homeExpensesCategories = [
    {"name": "Gas", "icon": FontAwesomeIcons.gasPump},
    {"name": "Car", "icon": FontAwesomeIcons.car},
    {"name": "Food", "icon": FontAwesomeIcons.bowlFood},
    {"name": "Other", "icon": FontAwesomeIcons.database}
  ];

  IconData getExpenseCategoryIcons(String categoryName) {
    final category = homeExpensesCategories.firstWhere(
        (category) => category['name'] == categoryName,
        orElse: () => {"icon": FontAwesomeIcons.shoppingCart});
    return category['icon'];
  }
}
