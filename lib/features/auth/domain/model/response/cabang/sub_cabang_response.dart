// To parse this JSON data, do
//
//     final subCabangResponse = subCabangResponseFromMap(jsonString);

import 'dart:convert';

import '../../../../../../shared/extension/string_ext.dart';
import 'cabang_response.dart';

SubCabangResponse subCabangResponseFromMap(String str) =>
    SubCabangResponse.fromMap(json.decode(str));

String subCabangResponseToMap(SubCabangResponse data) =>
    json.encode(data.toMap());

class SubCabangResponse {
  int? id;
  String? cabangCode;
  String? code;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  CabangResponse? cabang;

  SubCabangResponse({
    this.id,
    this.cabangCode,
    this.code,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.cabang,
  });

  factory SubCabangResponse.fromMap(Map<String, dynamic> json) =>
      SubCabangResponse(
        id: json['id'],
        cabangCode: json['cabang_code'],
        code: json['code'],
        name: json['name'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
        deletedAt: json['deleted_at']?.toString().toDateTime,
        cabang: json['cabang'] == null
            ? null
            : CabangResponse.fromMap(json['cabang']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'cabang_code': cabangCode,
        'code': code,
        'name': name,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'deleted_at': deletedAt?.toIso8601String(),
        'cabang': cabang?.toMap(),
      };
}
