part of 'business_category_cubit.dart';

sealed class BusinessCategoryState extends Equatable {
  const BusinessCategoryState();

  @override
  List<Object> get props => [];
}

final class BusinessCategoryInitial extends BusinessCategoryState {}

final class Trying extends BusinessCategoryState {}

final class GetCategoriesLevel1Loading extends BusinessCategoryState {
  final String? message;

  const GetCategoriesLevel1Loading(
      {this.message = 'Getting level 1 categories'});
}

final class GetCategoriesLevel2Loading extends BusinessCategoryState {
  final String? message;

  const GetCategoriesLevel2Loading(
      {this.message = 'Getting level 2 categories'});
}

final class GetCategoriesLevel3Loading extends BusinessCategoryState {
  final String? message;

  const GetCategoriesLevel3Loading(
      {this.message = 'Getting level 3 categories'});
}

final class GetCategoriesLevel4Loading extends BusinessCategoryState {
  final String? message;

  const GetCategoriesLevel4Loading(
      {this.message = 'Getting level 3 categories'});
}

final class GetProductLoading extends BusinessCategoryState {
  final String? message;

  const GetProductLoading({this.message = 'Getting level 3 categories'});
}

final class GetProductSuccess extends BusinessCategoryState {
  final List<ProductModel> products;

  const GetProductSuccess({required this.products});
}

final class GetCategoriesSuccess extends BusinessCategoryState {
  final List<CategoryModel> categorysLevel1;
  final List<CategoryModel> categorysLevel2;
  final List<CategoryModel> categorysLevel3;
  final List<CategoryModel> categorysLevel4;

  const GetCategoriesSuccess({
    required this.categorysLevel1,
    required this.categorysLevel2,
    required this.categorysLevel3,
    required this.categorysLevel4,
  });
}

final class GetCategoriesFailure extends BusinessCategoryState {
  final String message;

  const GetCategoriesFailure({required this.message});
}

final class Category1GridCountChangedState extends BusinessCategoryState {
  final int count;

  const Category1GridCountChangedState({required this.count});
}

final class OptionSelectedState extends BusinessCategoryState {}
