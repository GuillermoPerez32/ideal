class AuthUser {
  final String id;
  final String email;
  final String role;
  final String token;

  const AuthUser({
    required this.id,
    required this.email,
    required this.role,
    required this.token,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'role': role, 'token': token};
  }
}
