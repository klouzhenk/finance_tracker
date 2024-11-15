import 'package:finance_tracker/components/form_btn.dart';
import 'package:finance_tracker/components/form_text_field.dart';
import 'package:flutter/material.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  AddExpensePageState createState() => AddExpensePageState();
}

class AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedCategory = "Food";
  DateTime _selectedDate = DateTime.now();

  void _saveExpense() {
    if (_formKey.currentState!.validate()) {
      // Логіка для збереження
      print("Title: ${_titleController.text}");
      print("Amount: ${_amountController.text}");
      print("Category: $_selectedCategory");
      print("Date: $_selectedDate");
      print("Description: ${_descriptionController.text}");
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new expense"),
      ),
      body: SingleChildScrollView(
        // Додаємо SingleChildScrollView
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
                  Text("Date: ${_selectedDate.toLocal()}".split(' ')[0]),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text("Select date"),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: _amountController, labelText: "Amount"),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                value: _selectedCategory,
                items: ["Food", "Transport", "Entertainment"]
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
              const SizedBox(height: 10),
              CustomTextField(
                  controller: _descriptionController, labelText: "Description"),
              const SizedBox(height: 20),
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
