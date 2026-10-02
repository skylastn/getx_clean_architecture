// To parse this JSON data, do
//
//     final cabangRuleResponse = cabangRuleResponseFromMap(jsonString);

import 'dart:convert';

CabangRuleResponse cabangRuleResponseFromMap(String str) =>
    CabangRuleResponse.fromMap(json.decode(str));

String cabangRuleResponseToMap(CabangRuleResponse data) =>
    json.encode(data.toMap());

class CabangRuleResponse {
  int? id;
  String? cabangCode;
  String? repositoryCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  CabangRuleResponse({
    this.id,
    this.cabangCode,
    this.repositoryCode,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory CabangRuleResponse.fromMap(Map<String, dynamic> json) =>
      CabangRuleResponse(
        id: json['id'],
        cabangCode: json['cabang_code'],
        repositoryCode: json['repository_code'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
        deletedAt: json['deleted_at'] == null
            ? null
            : DateTime.parse(json['deleted_at']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'cabang_code': cabangCode,
        'repository_code': repositoryCode,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'deleted_at': deletedAt,
      };
}
