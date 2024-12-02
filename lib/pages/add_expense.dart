import 'package:finance_tracker/components/app_bar.dart';
import 'package:finance_tracker/components/form_btn.dart';
import 'package:finance_tracker/components/form_text_field.dart';
import 'package:finance_tracker/helper/date.dart';
import 'package:finance_tracker/helper/snack_bar.dart';
import 'package:finance_tracker/models/expense.dart';
import 'package:finance_tracker/providers/expenses_provider.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:finance_tracker/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExpensePage extends ConsumerStatefulWidget {
  const AddExpensePage(this.selectedDate, {super.key});

  final DateTime selectedDate;

  @override
  ConsumerState<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends ConsumerState<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedCategory = ExpenseCategory.food.toReadableString();
  late DateTime _selectedDate;
  String? _userId;

  void _saveExpense() async {
    if (_formKey.currentState!.validate()) {
      if (_userId == null) {
        SnackBarHelper.showSnackBar(context,
            'Something went wrong with your account creadential. Please login again');
        return;
      }

      final String title = _titleController.text;
      final String description = _descriptionController.text;
      final double? amount = double.tryParse(_amountController.text);

      if (amount == null || amount <= 0) {
        SnackBarHelper.showSnackBar(context, 'Please enter a valid amount');
        return;
      }

      final expense = ExpenseDto(
        title,
        amount,
        _selectedCategory,
        _selectedDate.toIso8601String(),
        description: description,
      );

      ref.read(expenseProvider.notifier).addExpense(expense, _userId!);

      SnackBarHelper.showSnackBar(context, 'Expense added successfully!',
          snackBarType: SnackBarType.success);
      _clearInputFields();
    } else {
      SnackBarHelper.showSnackBar(context, 'Please fix the errors in the form');
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _clearInputFields() {
    _formKey.currentState!.reset();
    _titleController.clear();
    _amountController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedCategory = ExpenseCategory.food.toReadableString();
      _selectedDate = DateTime.now();
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    _userId = ref.watch(userProvider)?.id;
    final categories = ExpenseCategory.values.map((ExpenseCategory category) {
      return category.toReadableString();
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar("Add new expense"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(controller: _titleController, labelText: "Title"),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      items: categories
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value.toString();
                        });
                      },
                      decoration: const InputDecoration(labelText: "Category"),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.24,
                    child: CustomTextField(
                      controller: _amountController,
                      labelText: "Amount",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _descriptionController,
                labelText: "Description",
                minLines: 3,
                maxLines: 5,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.56,
                    child: Text(
                      "Date: ${DateHelper.dateToText(_selectedDate)}",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectDate(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentColor,
                      ),
                      child: const Text(
                        "Select date",
                        style: TextStyle(color: AppColors.buttonTextColor),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Center(
                child:
                    FormButtonSubmit(text: "Submit", onPressed: _saveExpense),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
