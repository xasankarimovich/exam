import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/expense/expense_bloc.dart';
import '../../blocs/expense/expense_event.dart';
import '../../blocs/expense/expense_state.dart';
import '../../data/models/catigories/expense_model.dart';
class ExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense'),
        actions: [
          CircleAvatar(
            child: Icon(Icons.emoji_people)
          )
        ],
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ExpenseLoaded) {
            if (state.expenses.isEmpty) {
              return Center(child: Text('No expenses found.'));
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.expenses.length,
                itemBuilder: (context, index) {
                  final expense = state.expenses[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GridTile(
                      header: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          expense.category,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '\$${expense.summa}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      footer: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, expense.id);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
          if (state is ExpenseError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Unexpected state.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddExpenseDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String expenseId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Expense'),
          content: Text('Xarajatlarni uchirmoqchimisz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<ExpenseBloc>().add(DeleteExpenses(expenseId));
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    // Create controllers for the text fields
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Expense'),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(labelText: 'Category'),
                ),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final String category = categoryController.text;
                final int amount = int.tryParse(amountController.text) ?? 0;
                final expense = ExpenseModel(
                  id: DateTime.now().toString(),
                  category: category,
                  summa: amount,
                  dateTime: DateTime.now(),
                  comment: '',
                );
                context.read<ExpenseBloc>().add(AddExpenses(expense));
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}