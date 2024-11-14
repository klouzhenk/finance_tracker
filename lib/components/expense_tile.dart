import 'package:finance_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense});

  final Expense expense;

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
          title: Text('Category: ${expense.categoryName}'),
          subtitle: Text('Date: ${expense.formattedDate}'),
        ),
      ],
    );
  }
}
