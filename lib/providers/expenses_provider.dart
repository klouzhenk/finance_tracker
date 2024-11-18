import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/helper.dart';
import '../models/expense.dart';

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  ExpenseNotifier() : super([]);

  // Завантажуємо всі витрати для користувача
  Future<void> loadExpenses(int userId) async {
    final expenses = await DatabaseHelper.instance.getUserExpenses(userId);
    state = expenses;
  }

  // Додаємо нову витрату і оновлюємо стан
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
}

final expenseProvider =
    StateNotifierProvider<ExpenseNotifier, List<Expense>>((ref) {
  return ExpenseNotifier();
});
