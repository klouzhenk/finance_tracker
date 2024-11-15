import 'package:finance_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 0,
        ),
        backgroundColor: expense.categoryColor,
        collapsedBackgroundColor: expense.categoryColor,
        shape: const Border(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(expense.title),
            Text('\$${expense.amount.toStringAsFixed(2)}'),
          ],
        ),
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 16,
            ),
            title: Text('Category: ${expense.categoryName}'),
            subtitle: Text('Date: ${expense.formattedDate}'),
          ),
        ],
      ),
    );
  }
}
