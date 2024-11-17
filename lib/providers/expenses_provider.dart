import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/helper.dart';
import '../models/expense.dart';

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  ExpenseNotifier() : super([]);

  Future<void> loadExpenses(int userId) async {
    final expenses = await DatabaseHelper.instance.getUserExpenses(userId);
    state = expenses;
  }

  Future<void> addExpense(ExpenseDto expense, int userId) async {
    await DatabaseHelper.instance.insertExpense(
      userId,
      expense.title,
      expense.description ?? '',
      expense.amount,
      expense.category,
      expense.date,
    );
    await loadExpenses(userId); // do reload user expenses
  }
}

final expenseProvider =
    StateNotifierProvider<ExpenseNotifier, List<Expense>>((ref) {
  return ExpenseNotifier();
});
