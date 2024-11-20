import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;

  CategoryModel({
    required this.id,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  factory CategoryModel.toEmpty() {
    return CategoryModel(
      id: '',
      name: '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryModel && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
