import 'dart:convert';

import '../../../../../../shared/extension/string_ext.dart';
import 'sub_cabang_response.dart';

List<SubCabangUserResponse> subCabangUserResponseFromMap(String str) =>
    List<SubCabangUserResponse>.from(
        json.decode(str).map((x) => SubCabangUserResponse.fromMap(x)));

String subCabangUserResponseToMap(List<SubCabangUserResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SubCabangUserResponse {
  int? id;
  int? userId;
  String? subCabangCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? memberCode;
  SubCabangResponse? subCabang;

  SubCabangUserResponse({
    this.id,
    this.userId,
    this.subCabangCode,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.memberCode,
    this.subCabang,
  });

  SubCabangUserResponse copyWith({
    int? id,
    int? userId,
    String? subCabangCode,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? memberCode,
    SubCabangResponse? subCabang,
  }) =>
      SubCabangUserResponse(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        subCabangCode: subCabangCode ?? this.subCabangCode,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        memberCode: memberCode ?? this.memberCode,
        subCabang: subCabang ?? this.subCabang,
      );

  factory SubCabangUserResponse.fromMap(Map<String, dynamic> json) =>
      SubCabangUserResponse(
        id: json['id'],
        userId: json['user_id'],
        subCabangCode: json['sub_cabang_code'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
        deletedAt: json['deleted_at']?.toString().toDateTime,
        memberCode: json['member_code'],
        subCabang: json['sub_cabang'] == null
            ? null
            : SubCabangResponse.fromMap(json['sub_cabang']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'sub_cabang_code': subCabangCode,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'deleted_at': deletedAt?.toIso8601String(),
        'member_code': memberCode,
        'sub_cabang': subCabang?.toMap(),
      };
}
