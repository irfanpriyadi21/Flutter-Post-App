import 'package:meta/meta.dart';
import 'dart:convert';

class AuthResponseModel {
  final int code;
  final User user;
  final String token;

  AuthResponseModel({
    required this.code,
    required this.user,
    required this.token,
  });

  factory AuthResponseModel.fromRawJson(String str) => AuthResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) => AuthResponseModel(
    code: json["code"],
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "user": user.toJson(),
    "token": token,
  };
}

class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String roles;
  final dynamic emailVerifiedAt;
  final dynamic twoFactorSecret;
  final dynamic twoFactorRecoveryCodes;
  final dynamic twoFactorConfirmedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.roles,
    required this.emailVerifiedAt,
    required this.twoFactorSecret,
    required this.twoFactorRecoveryCodes,
    required this.twoFactorConfirmedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    roles: json["roles"],
    emailVerifiedAt: json["email_verified_at"],
    twoFactorSecret: json["two_factor_secret"],
    twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
    twoFactorConfirmedAt: json["two_factor_confirmed_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "roles": roles,
    "email_verified_at": emailVerifiedAt,
    "two_factor_secret": twoFactorSecret,
    "two_factor_recovery_codes": twoFactorRecoveryCodes,
    "two_factor_confirmed_at": twoFactorConfirmedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
