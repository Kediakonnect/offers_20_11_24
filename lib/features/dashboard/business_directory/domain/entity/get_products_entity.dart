import 'package:equatable/equatable.dart';

class GetProductsEntity extends Equatable {
  final String name;

  const GetProductsEntity({
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {"search": name};
  }

  @override
  List<Object?> get props => [name];
}
