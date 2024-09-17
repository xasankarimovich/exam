import '../../data/models/catigories/expense_model.dart';

class ExpenseState {
  final List<ExpenseModel> expenses;

  ExpenseState(this.expenses);
}

class ExpenseInitial extends ExpenseState {
  ExpenseInitial() : super([]);
}
class ExpenseLoading extends ExpenseState {
  ExpenseLoading() : super([]);
}

class ExpenseLoaded extends ExpenseState {
  ExpenseLoaded(List<ExpenseModel> expenses) : super(expenses);
}

class ExpenseError extends ExpenseState {
  final String message;

  ExpenseError(this.message) : super([]);
}