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
      default:
        return "Unknown";
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
