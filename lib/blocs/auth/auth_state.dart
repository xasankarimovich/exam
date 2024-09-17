import '../../data/models/forum_status/form_status.dart';
import '../../data/models/user/user_model.dart'; // UserModel sinfini ishlatamiz

class AuthState {
  final ForumStatus status;
  final UserModel? user;
  final String errorMessage;

  const AuthState({
    required this.status,
    required this.user,
    required this.errorMessage,
  });

  AuthState copyWith({
    String? errorMessage,
    ForumStatus? status,
    UserModel? user,
  }) =>
      AuthState(
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status,
        user: user ?? this.user,
      );

  factory AuthState.fromJson(Map<String, dynamic> json) => AuthState(
        status: ForumStatus.values[json['status']],
        user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
        errorMessage: json['errorMessage'] as String? ?? '',
      );

  // SQLFlite uchun saqlash uchun toJson method
  Map<String, dynamic> toJson() {
    return {
      'status': status.index,
      // ForumStatus'ni saqlash
      'user': user != null ? user!.toJson() : null,
      // user ma'lumotlarini saqlash
      'errorMessage': errorMessage,
    };
  }

  // AuthState boshlang'ich qiymatlari
  static AuthState initialValue() => const AuthState(
        errorMessage: '',
        status: ForumStatus.initial,
        user: null,
      );
}
