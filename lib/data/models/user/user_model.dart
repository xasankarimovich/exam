class UserModel {
  final String uid;
  final String name;
  final String email;
  final String password;
  final String fcmToken;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.fcmToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json['uid'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    fcmToken: json['fcmToken'] as String,
  );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'email': email,
    'password': password,
    'fcmToken': fcmToken,
  };

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? password,
    String? fcmToken,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        fcmToken: fcmToken ?? this.fcmToken,
      );

  static UserModel initialValue() => UserModel(
    uid: '',
    name: '',
    email: '',
    password: '',
    fcmToken: '',
  );
}
