import 'package:intl/intl.dart';

class Expense {
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;

  Expense(this.title, this.amount, this.category, this.date);

  String get formattedDate => DateFormat('dd.MM.yyyy').format(date);
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
