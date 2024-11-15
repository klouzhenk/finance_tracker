import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Expense {
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;

  Expense(this.title, this.amount, this.category, this.date);

  String get formattedDate => DateFormat('dd.MM.yyyy').format(date);

  String get categoryName {
    switch (category) {
      case ExpenseCategory.food:
        return "Food";
      case ExpenseCategory.transport:
        return "Transport";
      case ExpenseCategory.entertainment:
        return "Entertainment";
      case ExpenseCategory.housing:
        return "Housing";
      case ExpenseCategory.clothingAndAccessories:
        return "Clothing & Accessories";
      case ExpenseCategory.health:
        return "Health";
      case ExpenseCategory.education:
        return "Education";
      case ExpenseCategory.pets:
        return "Pets";
      case ExpenseCategory.gifts:
        return "Gifts";
      case ExpenseCategory.other:
        return "Other";
    }
  }

  Color get categoryColor {
    switch (category) {
      case ExpenseCategory.food:
        return Colors.green[100]!;
      case ExpenseCategory.transport:
        return Colors.blue[100]!;
      case ExpenseCategory.entertainment:
        return Colors.purple[100]!;
      case ExpenseCategory.housing:
        return Colors.orange[100]!;
      case ExpenseCategory.clothingAndAccessories:
        return Colors.pink[100]!;
      case ExpenseCategory.health:
        return Colors.red[100]!;
      case ExpenseCategory.education:
        return Colors.yellow[100]!;
      case ExpenseCategory.pets:
        return Colors.brown[100]!;
      case ExpenseCategory.gifts:
        return Colors.teal[100]!;
      case ExpenseCategory.other:
        return Colors.grey[200]!;
    }
  }
}

enum ExpenseCategory {
  food,
  transport,
  entertainment,
  housing,
  clothingAndAccessories,
  health,
  education,
  pets,
  gifts,
  other
}
