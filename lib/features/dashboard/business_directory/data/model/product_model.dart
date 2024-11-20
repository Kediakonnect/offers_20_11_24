class ProductModel {
  final String id;
  final int productCode;
  final String name;
  final String level1CategoryId;
  final String level2CategoryId;
  final String level3CategoryId;
  final DateTime updatedAt;
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.productCode,
    required this.name,
    required this.level1CategoryId,
    required this.level2CategoryId,
    required this.level3CategoryId,
    required this.updatedAt,
    required this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] as String,
      productCode: json['product_code'] as int,
      name: json['name'] as String,
      level1CategoryId: json['level1_category_id'] as String,
      level2CategoryId: json['level2_category_id'] as String,
      level3CategoryId: json['level3_category_id'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'product_code': productCode,
      'name': name,
      'level1_category_id': level1CategoryId,
      'level2_category_id': level2CategoryId,
      'level3_category_id': level3CategoryId,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
