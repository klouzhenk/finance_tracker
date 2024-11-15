import 'package:finance_tracker/components/expense_tile.dart';
import 'package:finance_tracker/components/pie_chart.dart';
import 'package:finance_tracker/helper/color.dart';
import 'package:finance_tracker/models/expense.dart';
import 'package:finance_tracker/pages/add_expense.dart';
import 'package:finance_tracker/styles/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensePage extends StatelessWidget {
  ExpensePage({super.key});

  final List<Expense> expenses = [
    Expense(
      0,
      'Coca Cola',
      0.5,
      ExpenseCategory.food,
      DateTime(2024, 11, 15),
    ),
    Expense(
      1,
      'City Card',
      2,
      ExpenseCategory.transport,
      DateTime(2024, 11, 15),
    ),
    Expense(
      2,
      'Cinema',
      4,
      ExpenseCategory.entertainment,
      DateTime(2024, 11, 15),
    ),
  ];

  List<PieChartSectionData> _prepareChartData() {
    List<PieChartSectionData> sections = [];
    double totalAmount = 0;
    Map<int, String> data = {};
    for (var expense in expenses) {
      data[expense.id] = expense.title;
      totalAmount += expense.amount;
    }

    data.forEach((id, title) {
      Expense expense = expenses.firstWhere((e) => e.id == id);

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
              separatorBuilder: (context, index) => const SizedBox(height: 12),
            ),
          ],
        ),
      ),
    );
  }
}
