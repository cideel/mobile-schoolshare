// lib/data/models/auth_response_model.dart
import 'package:schoolshare/data/models/users_model.dart';

class AuthResponseModel {
  final UserModel user;
  final String token;
  final String? tokenType;
  final int? expiresIn;

  const AuthResponseModel({
    required this.user,
    required this.token,
    this.tokenType,
    this.expiresIn,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      user: UserModel.fromJson(json['user']),
      token: json['token'] ?? '',
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": user.toJson(),
      "token": token,
      "token_type": tokenType,
      "expires_in": expiresIn,
    };
  }
}
