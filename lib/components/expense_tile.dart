import 'package:finance_tracker/helper/snack_bar.dart';
import 'package:finance_tracker/providers/expenses_provider.dart';
import 'package:finance_tracker/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/models/expense.dart';
import 'package:finance_tracker/helper/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseTile extends ConsumerWidget {
  const ExpenseTile({
    super.key,
    required this.expense,
    required this.onDelete,
  });

  final Expense expense;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(expense.id.toString()),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm delete'),
            content:
                const Text('Are you sure do you want to delete this expense?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        onDelete();
        ref.read(expenseProvider.notifier).deleteExpenseById(expense.id);
        SnackBarHelper.showSnackBar(
            context, 'This expense (${expense.title}) was deleted.',
            snackBarType: SnackBarType.success);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child:
            const Icon(Icons.delete_outlined, color: AppColors.darkAccentColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
      ),
    );
  }
}
