import 'package:finance_tracker/components/app_bar.dart';
import 'package:finance_tracker/components/drawer.dart';
import 'package:finance_tracker/components/expense_tile.dart';
import 'package:finance_tracker/components/icon_btn.dart';
import 'package:finance_tracker/components/pie_chart.dart';
import 'package:finance_tracker/helper/color.dart';
import 'package:finance_tracker/helper/date.dart';
import 'package:finance_tracker/models/expense.dart';
import 'package:finance_tracker/pages/add_expense.dart';
import 'package:finance_tracker/providers/expenses_provider.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpensePage extends ConsumerStatefulWidget {
  const ExpensePage({super.key});

  @override
  ConsumerState<ExpensePage> createState() {
    return _ExpensePageState();
  }
}

class _ExpensePageState extends ConsumerState<ExpensePage> {
  String? _userId;
  DateTime _currentDate = DateTime.now();
  double _totalSumOfExpenses = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _userId = ref.watch(userProvider)?.id;
      if (_userId != null) {
        ref
            .read(expenseProvider.notifier)
            .loadExpensesByDate(_userId!, _currentDate);
      }
    });
  }

  void _changeDate(bool nextDay) {
    setState(() {
      _currentDate = nextDay
          ? _currentDate.add(const Duration(days: 1))
          : _currentDate.subtract(const Duration(days: 1));
    });
    if (_userId != null) {
      ref
          .read(expenseProvider.notifier)
          .loadExpensesByDate(_userId!, _currentDate);
    }
  }

  Future<List<PieChartSectionData>> _prepareChartData(
      List<Expense> expenses) async {
    _totalSumOfExpenses = 0;

    if (expenses.isEmpty) {
      return List.empty();
    }

    final Map<String, double> categoryTotals = {};
    for (var expense in expenses) {
      categoryTotals.update(
        expense.categoryName,
        (currentTotal) => currentTotal + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    _totalSumOfExpenses =
        categoryTotals.values.fold(0, (sum, amount) => sum + amount);

    final sections = categoryTotals.entries.map((entry) {
      final categoryName = entry.key;
      final categoryTotal = entry.value;

      final percentFromOverallAmount =
          categoryTotal / _totalSumOfExpenses * 100;
      final categoryColor = expenses
          .firstWhere((expense) => expense.categoryName == categoryName)
          .categoryColor;

      return PieChartSectionData(
        value: categoryTotal,
        color: categoryColor.adjustSaturation(1).darken(),
        title: percentFromOverallAmount > 3
            ? '${percentFromOverallAmount.toStringAsFixed(1)}%'
            : '',
        radius: 80,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: categoryColor
              .adjustSaturation(1)
              .darken()
              .textColorBasedOnBackground(),
        ),
      );
    }).toList();

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    final expenses = ref.watch(expenseProvider);

    return Scaffold(
      appBar:
          CustomAppBar('Expenses for ${DateHelper.dateToText(_currentDate)}'),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              FutureBuilder<List<PieChartSectionData>>(
                future: _prepareChartData(expenses),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Row(
                          children: [
                            AppIconBtn(
                              Icons.keyboard_arrow_left,
                              40,
                              AppColors.darkAccentColor,
                              onPressed: () => _changeDate(false),
                            ),
                            const Expanded(
                              child: Icon(
                                Icons.speaker_notes_off_outlined,
                                color: Color.fromARGB(255, 104, 149, 106),
                                size: 160,
                              ),
                            ),
                            AppIconBtn(
                              Icons.keyboard_arrow_right,
                              40,
                              AppColors.darkAccentColor,
                              onPressed: () => _changeDate(true),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppIconBtn(
                            Icons.keyboard_arrow_left,
                            40,
                            AppColors.darkAccentColor,
                            onPressed: () => _changeDate(false),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const SizedBox(height: 16),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    '₴ ${_totalSumOfExpenses.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                ExpensePieChart(sections: snapshot.data!),
                              ],
                            ),
                          ),
                          AppIconBtn(
                            Icons.keyboard_arrow_right,
                            40,
                            AppColors.darkAccentColor,
                            onPressed: () => _changeDate(true),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 28),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              builder: (context) =>
                                  AddExpensePage(_currentDate),
                            ),
                          ).then((_) {
                            if (_userId != null) {
                              ref
                                  .read(expenseProvider.notifier)
                                  .loadExpensesByDate(_userId!, _currentDate);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              expenses.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ExpenseTile(
                            expense: expenses[index],
                            onDelete: () {
                              setState(() {
                                expenses.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
