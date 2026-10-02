class RepositoryRuleRespose {
  final int? id;
  final String? productCode;
  final String? repositoryCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  RepositoryRuleRespose({
    this.id,
    this.productCode,
    this.repositoryCode,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory RepositoryRuleRespose.fromJson(Map<String, dynamic> json) {
    return RepositoryRuleRespose(
      id: json['id'],
      productCode: json['product_code'],
      repositoryCode: json['repository_code'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_code': productCode,
      'repository_code': repositoryCode,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}
