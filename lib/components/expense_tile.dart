import 'package:finance_tracker/helper/color.dart';
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
        iconColor: expense.categoryColor.darken(0.3),
        collapsedIconColor: expense.categoryColor.darken(0.3),
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
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category: ${expense.categoryName}'),
                const SizedBox(height: 8),
                Text(expense.description?.isEmpty ?? true
                    ? 'Description: -'
                    : 'Description: ${expense.description}'),
                const SizedBox(height: 8),
                Text('Date: ${expense.formattedDate}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
