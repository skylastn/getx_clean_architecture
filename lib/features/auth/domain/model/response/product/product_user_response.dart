// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../../../shared/extension/string_ext.dart';
import 'product_response.dart';

class ProductUserResponse {
  int? id;
  int? userId;
  String? productCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  DateTime? expiredAt;
  ProductResponse? product;

  ProductUserResponse({
    required this.id,
    required this.userId,
    required this.productCode,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.expiredAt,
    required this.product,
  });

  factory ProductUserResponse.fromMap(Map<String, dynamic> json) =>
      ProductUserResponse(
        id: json['id'],
        userId: json['user_id'],
        productCode: json['product_code'],
        createdAt: json['created_at']?.toString().toDateTime,
        updatedAt: json['updated_at']?.toString().toDateTime,
        deletedAt: json['deleted_at']?.toString().toDateTime,
        expiredAt: json['expired_at']?.toString().toDateTime,
        product: json['product'] == null
            ? null
            : ProductResponse.fromMap(json['product']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'product_code': productCode,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'deleted_at': deletedAt?.toIso8601String(),
        'expired_at': expiredAt?.toIso8601String(),
        'product': product?.toMap(),
      };

  ProductUserResponse copyWith({
    int? id,
    int? userId,
    String? productCode,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    DateTime? expiredAt,
    ProductResponse? product,
  }) {
    return ProductUserResponse(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productCode: productCode ?? this.productCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      expiredAt: expiredAt ?? this.expiredAt,
      product: product ?? this.product,
    );
  }
}
