import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Expense {
  final String id;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;
  final String? description;

  Expense(
    this.id,
    this.title,
    this.amount,
    this.category,
    this.date, {
    this.description,
  });

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      map['id'],
      map['title'],
      map['amount'],
      ExpenseCategoryExtension.fromString(map['category']),
      DateTime.parse(map['date']),
      description: map['description'],
    );
  }

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
        return Colors.green[400]!;
      case ExpenseCategory.transport:
        return Colors.blue[400]!;
      case ExpenseCategory.entertainment:
        return Colors.purple[400]!;
      case ExpenseCategory.housing:
        return Colors.orange[400]!;
      case ExpenseCategory.clothingAndAccessories:
        return Colors.pink[400]!;
      case ExpenseCategory.health:
        return Colors.red[400]!;
      case ExpenseCategory.education:
        return Colors.yellow[400]!;
      case ExpenseCategory.pets:
        return Colors.lime[400]!;
      case ExpenseCategory.gifts:
        return Colors.teal[400]!;
      case ExpenseCategory.other:
        return Colors.indigo;
    }
  }
}

class ExpenseDto {
  final String title;
  final double amount;
  final String category;
  final String date;
  final String? description;

  ExpenseDto(
    this.title,
    this.amount,
    this.category,
    this.date, {
    this.description,
  });
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

extension ExpenseCategoryExtension on ExpenseCategory {
  String toReadableString() {
    switch (this) {
      case ExpenseCategory.food:
        return 'Food';
      case ExpenseCategory.transport:
        return 'Transport';
      case ExpenseCategory.entertainment:
        return 'Entertainment';
      case ExpenseCategory.housing:
        return 'Housing';
      case ExpenseCategory.clothingAndAccessories:
        return 'Clothing and Accessories';
      case ExpenseCategory.health:
        return 'Health';
      case ExpenseCategory.education:
        return 'Education';
      case ExpenseCategory.pets:
        return 'Pets';
      case ExpenseCategory.gifts:
        return 'Gifts';
      case ExpenseCategory.other:
        return 'Other';
    }
  }

  static ExpenseCategory fromString(String value) {
    switch (value.toLowerCase()) {
      case 'food':
        return ExpenseCategory.food;
      case 'transport':
        return ExpenseCategory.transport;
      case 'entertainment':
        return ExpenseCategory.entertainment;
      case 'housing':
        return ExpenseCategory.housing;
      case 'clothing and accessories':
        return ExpenseCategory.clothingAndAccessories;
      case 'health':
        return ExpenseCategory.health;
      case 'education':
        return ExpenseCategory.education;
      case 'pets':
        return ExpenseCategory.pets;
      case 'gifts':
        return ExpenseCategory.gifts;
      default:
        return ExpenseCategory.other;
    }
  }
}
