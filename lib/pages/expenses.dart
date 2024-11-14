import 'package:finance_tracker/components/expense_tile.dart';
import 'package:finance_tracker/components/pie_chart.dart';
import 'package:finance_tracker/models/expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensePage extends StatelessWidget {
  ExpensePage({super.key});

  final List<Expense> expenses = [
    Expense('Food', 50, 'Food and drinks', '2024-11-12'),
    Expense('Transport', 30, 'Bus ticket', '2024-11-12'),
    Expense('Entertainment', 20, 'Movie ticket', '2024-11-12'),
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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
