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
    await loadExpensesByDate(userId, DateTime.parse(expense.date));
  }

  Future<void> loadExpensesByDate(int userId, DateTime date) async {
    final expenses =
        await DatabaseHelper.instance.getUserExpensesByDate(userId, date);
    state = expenses;
  }

  Future<void> deleteExpenseById(int expenseId) async {
    try {
      await DatabaseHelper.instance.deleteExpense(expenseId);
    } catch (e) {
      print('Error deleting expense: $e');
    }
  }
}

final expenseProvider =
    StateNotifierProvider<ExpenseNotifier, List<Expense>>((ref) {
  return ExpenseNotifier();
});
