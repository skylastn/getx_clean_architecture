// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../../../../shared/extension/string_ext.dart';
import '../product/product_user_response.dart';
import '../cabang/sub_cabang_user_response.dart';

UserResponse userResponseFromMap(String str) =>
    UserResponse.fromMap(json.decode(str));

String userResponseToMap(UserResponse data) => json.encode(data.toMap());

class UserResponse {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? point;
  String? verificationCode;
  DateTime? emailVerifiedAt;
  String? photo;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isAdmin;
  List<ProductUserResponse> productRule;
  List<SubCabangUserResponse>? subCabangUser;

  UserResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.point,
    required this.verificationCode,
    required this.emailVerifiedAt,
    required this.photo,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.isAdmin,
    required this.productRule,
    this.subCabangUser,
  });

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        point: json['point'],
        verificationCode: json['verification_code'],
        emailVerifiedAt: json['email_verified_at']?.toString().toDateTime,
        photo: json['photo'],
        imageUrl: json['imageUrl'],
        createdAt: json['created_at']?.toString().toDateTime,
        updatedAt: json['updated_at']?.toString().toDateTime,
        isAdmin: json['isAdmin'],
        productRule: List<ProductUserResponse>.from(
            ((json['product_rule'] ?? []) as List)
                .map((x) => ProductUserResponse.fromMap(x))),
        subCabangUser: List<SubCabangUserResponse>.from(
            ((json['sub_cabang_user'] ?? []) as List)
                .map((x) => SubCabangUserResponse.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'point': point,
        'verification_code': verificationCode,
        'email_verified_at': emailVerifiedAt?.toIso8601String(),
        'photo': photo,
        'imageUrl': imageUrl,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'isAdmin': isAdmin,
        'product_rule': List<dynamic>.from(productRule.map((x) => x.toMap())),
        'sub_cabang_user': subCabangUser == null
            ? null
            : List<dynamic>.from(subCabangUser?.map((x) => x.toMap()) ?? []),
      };

  UserResponse copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    int? point,
    String? verificationCode,
    DateTime? emailVerifiedAt,
    String? photo,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isAdmin,
    List<ProductUserResponse>? productRule,
    List<SubCabangUserResponse>? subCabangUser,
  }) {
    return UserResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      point: point ?? this.point,
      verificationCode: verificationCode ?? this.verificationCode,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      photo: photo ?? this.photo,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isAdmin: isAdmin ?? this.isAdmin,
      productRule:
          productRule ?? this.productRule.map((x) => x.copyWith()).toList(),
      subCabangUser: subCabangUser ??
          this.subCabangUser?.map((x) => x.copyWith()).toList(),
    );
  }
}
