import 'package:finance_tracker/components/expense_tile.dart';
import 'package:finance_tracker/components/pie_chart.dart';
import 'package:finance_tracker/database/helper.dart';
import 'package:finance_tracker/helper/color.dart';
import 'package:finance_tracker/models/expense.dart';
import 'package:finance_tracker/pages/add_expense.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:finance_tracker/styles/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpensePage extends ConsumerWidget {
  ExpensePage({super.key});

  int? _userId;

  Future<List<PieChartSectionData>> _prepareChartData() async {
    List<PieChartSectionData> sections = [];
    List<Expense>? expenses;
    double totalAmount = 0;

    if (_userId != null) {
      expenses = await DatabaseHelper.instance.getUserExpenses(_userId!);
    }

    if (expenses == null || expenses.isEmpty) {
      return List.empty();
    }

    for (var expense in expenses) {
      sections.add(
        PieChartSectionData(
          value: expense.amount,
          color: expense.categoryColor.adjustSaturation(1).darken(),
          title: expense.amount.toString(),
          radius: 60,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      );
    }

    return sections;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _userId = ref.watch(userIdProvider.notifier).state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Expenses'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<PieChartSectionData>>(
              future: _prepareChartData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Показуємо індикатор завантаження, поки чекаємо на дані
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Обробка помилки, якщо щось пішло не так
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // Якщо немає даних
                  return Center(child: Text('No expenses available'));
                } else {
                  // Відображаємо графік
                  return ExpensePieChart(sections: snapshot.data!);
                }
              },
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 28),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Expenses',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_box),
                      iconSize: 40,
                      color: AppColors.accentColor,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddExpensePage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder<List<Expense>>(
              future: DatabaseHelper.instance.getUserExpenses(_userId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No expenses available'));
                } else {
                  List<Expense> expenses = snapshot.data!;
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ExpenseTile(expense: expenses[index]),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
