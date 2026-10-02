// To parse this JSON data, do
//
//     final cabangResponse = cabangResponseFromMap(jsonString);

import 'dart:convert';

import '../../../../../../shared/extension/string_ext.dart';

CabangResponse cabangResponseFromMap(String str) =>
    CabangResponse.fromMap(json.decode(str));

String cabangResponseToMap(CabangResponse data) => json.encode(data.toMap());

class CabangResponse {
  int? id;
  String? code;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  CabangResponse({
    this.id,
    this.code,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory CabangResponse.fromMap(Map<String, dynamic> json) => CabangResponse(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
        deletedAt: json['deleted_at']?.toString().toDateTime,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'code': code,
        'name': name,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'deleted_at': deletedAt?.toIso8601String(),
      };
}
