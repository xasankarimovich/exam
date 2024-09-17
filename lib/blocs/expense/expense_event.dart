

import '../../data/models/catigories/expense_model.dart';

abstract class ExpenseEvent {}

class AddExpenses extends ExpenseEvent {
  final ExpenseModel expense;

  AddExpenses(this.expense);
}

class EditExpenses extends ExpenseEvent {
  final ExpenseModel expense;

  EditExpenses(this.expense);
}

class DeleteExpenses extends ExpenseEvent {
  final String id;

  DeleteExpenses(this.id);
}

class FetchExpenses extends ExpenseEvent {}