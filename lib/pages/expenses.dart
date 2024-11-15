import 'package:finance_tracker/components/expense_tile.dart';
import 'package:finance_tracker/components/pie_chart.dart';
import 'package:finance_tracker/models/expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensePage extends StatelessWidget {
  ExpensePage({super.key});

  final List<Expense> expenses = [
    Expense('Coca Cola', 50, ExpenseCategory.food, DateTime(2024, 11, 15)),
    Expense('City Card', 30, ExpenseCategory.transport, DateTime(2024, 11, 15)),
    Expense(
        'Cinema', 20, ExpenseCategory.entertainment, DateTime(2024, 11, 15)),
  ];

  List<PieChartSectionData> _prepareChartData() {
    List<PieChartSectionData> sections = [];
    double totalAmount = 0;
    Map<String, double> data = {};
    for (var expense in expenses) {
      data[expense.title] = expense.amount;
      totalAmount += expense.amount;
    }

    data.forEach((title, amount) {
      sections.add(
        PieChartSectionData(
          value: amount,
          color: Colors.primaries[sections.length % Colors.primaries.length],
          title: amount.toString(),
          radius: 60,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    });
    return sections;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Expenses'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpensePieChart(sections: _prepareChartData()),
            ListView.separated(
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
                      borderRadius:
                          BorderRadius.circular(16), // Заокруглення контейнера
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
              separatorBuilder: (context, index) => const SizedBox(height: 12),
            ),
          ],
        ),
      ),
    );
  }
}
