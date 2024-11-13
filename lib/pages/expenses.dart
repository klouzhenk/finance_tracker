import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpensePage extends StatelessWidget {
  ExpensePage({super.key});

  final List<Expense> expenses = [
    Expense('Food', 50, 'Food and drinks', '2024-11-12'),
    Expense('Transport', 30, 'Bus ticket', '2024-11-12'),
    Expense('Entertainment', 20, 'Movie ticket', '2024-11-12'),
  ];

  @override
  Widget build(BuildContext context) {
    // Підготовка даних для пайчарту
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
          title: '${((amount / totalAmount) * 100).toStringAsFixed(1)}%',
          radius: 40,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Expenses'),
      ),
      body: SingleChildScrollView(
        // Використовуємо SingleChildScrollView для прокручування
        child: Column(
          children: [
            // Пайчарт
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 250, // Встановлюємо висоту пайчарту
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 50,
                  ),
                ),
              ),
            ),
            // Список витрат
            ListView.builder(
              shrinkWrap:
                  true, // Задаємо shrinkWrap для ListView, щоб він займав лише необхідний простір
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return ExpenseTile(expense: expenses[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Expense {
  final String title;
  final double amount;
  final String category;
  final String date;

  Expense(this.title, this.amount, this.category, this.date);
}

class ExpenseTile extends StatelessWidget {
  final Expense expense;

  const ExpenseTile({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(expense.title),
          Text('\$${expense.amount.toStringAsFixed(2)}'),
        ],
      ),
      children: [
        ListTile(
          title: Text('Category: ${expense.category}'),
          subtitle: Text('Date: ${expense.date}'),
        ),
      ],
    );
  }
}
