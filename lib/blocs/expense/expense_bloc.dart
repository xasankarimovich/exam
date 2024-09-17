import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/database_expense_services.dart';
import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final DatabaseHelper databaseHelper;

  ExpenseBloc(this.databaseHelper) : super(ExpenseInitial()) {
    on<FetchExpenses>(_onFetchExpenses);
    on<AddExpenses>(_onAddExpense);
    on<EditExpenses>(_onEditExpense);
    on<DeleteExpenses>(_onDeleteExpense);
  }

  Future<void> _onFetchExpenses(
      FetchExpenses event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoading());
    try {
      final expenses = await databaseHelper.getExpenses();
      emit(ExpenseLoaded(expenses));
    } catch (e) {
      emit(ExpenseError("Failed to load expenses"));
    }
  }

  Future<void> _onAddExpense(
      AddExpenses event, Emitter<ExpenseState> emit) async {
    await databaseHelper.insertExpense(event.expense);
    await _refreshExpenses(emit);
  }

  Future<void> _onEditExpense(
      EditExpenses event, Emitter<ExpenseState> emit) async {
    await databaseHelper.updateExpense(event.expense);
    await _refreshExpenses(emit);
  }

  Future<void> _onDeleteExpense(
      DeleteExpenses event, Emitter<ExpenseState> emit) async {
    await databaseHelper.deleteExpense(event.id);
    await _refreshExpenses(emit);
  }

  Future<void> _refreshExpenses(Emitter<ExpenseState> emit) async {
    try {
      final expenses = await databaseHelper.getExpenses();
      emit(ExpenseLoaded(expenses));
    } catch (e) {
      emit(ExpenseError("Failed to refresh expenses"));
    }
  }
}
