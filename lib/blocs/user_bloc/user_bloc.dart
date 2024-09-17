import 'package:exam_6_oy/data/models/user/user_model_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/forum_status/form_status.dart';
import '../../data/models/user/user_model.dart';
import '../../data/services/database_helper/database.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState.initialValue()) {
    on<InsertUserEvent>(_onInsertUser);
    on<FetchUserDocIdEvent>(_onFetchUserDocId);
    on<UpdateUserEvent>(_onUpdateUser);
  }

  Future<void> _onInsertUser(
      InsertUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: ForumStatus.loading));
      await DatabaseHelper.instance.insertUser(event.userModel);
      emit(state.copyWith(
          status: ForumStatus.success, userData: event.userModel));
    } catch (e) {
      emit(state.copyWith(
          status: ForumStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onFetchUserDocId(
      FetchUserDocIdEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: ForumStatus.loading));
      UserModel? userModel =
          await DatabaseHelper.instance.fetchUserById(UserModelConstants.uid);
      if (userModel != null) {
        emit(state.copyWith(status: ForumStatus.success, userData: userModel));
      } else {
        emit(state.copyWith(
            status: ForumStatus.error, errorMessage: 'User not found'));
      }
    } catch (e) {
      emit(state.copyWith(
          status: ForumStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdateUser(
      UpdateUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: ForumStatus.loading));
      await DatabaseHelper.instance.updateUser(event.userModel);
      emit(state.copyWith(
          status: ForumStatus.success, userData: event.userModel));
    } catch (e) {
      emit(state.copyWith(
          status: ForumStatus.error, errorMessage: e.toString()));
    }
  }
}
