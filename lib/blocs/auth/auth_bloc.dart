import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/forum_status/form_status.dart';
import '../../data/models/user/user_model.dart';
import '../../data/services/database_helper/database.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initialValue()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: ForumStatus.loading));
    try {
      final user = await DatabaseHelper.instance.fetchUserById(event.email);
      if (user != null && user.password == event.password) {
        emit(state.copyWith(status: ForumStatus.success, user: user));
      } else {
        emit(state.copyWith(
            status: ForumStatus.error, errorMessage: 'Invalid credentials'));
      }
    } catch (e) {
      emit(state.copyWith(
          status: ForumStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
      RegisterRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: ForumStatus.loading));
    try {
      final newUser = UserModel(
        uid: event.email,
        email: event.email,
        password: event.password,
        name: event.userName,
        fcmToken: '',
      );
      await DatabaseHelper.instance.insertUser(newUser);
      emit(state.copyWith(status: ForumStatus.success, user: newUser));
    } catch (e) {
      emit(state.copyWith(
          status: ForumStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: ForumStatus.loggedOut));
  }
}
