import '../repository/repository_rule_response.dart';
import '../../../../../../shared/extension/string_ext.dart';

class ProductResponse {
  int? id;
  String? code;
  String? name;
  String? detail;
  double? price;
  int? point;
  int? qty;
  int? duration;
  String? coverPath;
  String? coverUrl;
  List<RepositoryRuleRespose>? repositoryRules;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  ProductResponse({
    required this.id,
    required this.code,
    required this.name,
    required this.detail,
    required this.price,
    required this.point,
    required this.qty,
    required this.coverPath,
    required this.coverUrl,
    required this.duration,
    required this.repositoryRules,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory ProductResponse.fromMap(Map<String, dynamic> json) => ProductResponse(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        detail: json['detail'],
        price: json['price'].toString().toDouble,
        point: json['point'],
        qty: json['qty'],
        duration: json['duration'],
        coverPath: json['cover_path'],
        coverUrl: json['coverUrl'],
        createdAt: json['created_at']?.toString().toDateTime,
        updatedAt: json['updated_at']?.toString().toDateTime,
        deletedAt: json['deleted_at']?.toString().toDateTime,
        repositoryRules: List<RepositoryRuleRespose>.from(
          (json['repository_rules'] ?? []).map(
            (x) => RepositoryRuleRespose.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'code': code,
        'name': name,
        'detail': detail,
        'price': price,
        'point': point,
        'qty': qty,
        'duration': duration,
        'cover_path': coverPath,
        'coverUrl': coverUrl,
        'repository_rules': repositoryRules == null
            ? []
            : repositoryRules?.map((x) => x.toJson()).toList(),
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'deleted_at': deletedAt?.toIso8601String(),
      };
}
