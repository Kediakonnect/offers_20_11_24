import 'package:bloc/bloc.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/category_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/product_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/category_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/get_products_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/get_categories_use_case.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/usecases/get_product_use_case.dart';
import 'package:divyam_flutter/features/dashboard/offers/data/model/offer_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

part 'business_category_state.dart';

class BusinessCategoryCubit extends Cubit<BusinessCategoryState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProductUseCase _getProductUseCase;
  BusinessCategoryCubit({
    required GetCategoriesUseCase getCategoriesUseCase,
    required GetProductUseCase getProductUseCase,
  })  : _getCategoriesUseCase = getCategoriesUseCase,
        _getProductUseCase = getProductUseCase,
        super(BusinessCategoryInitial());

  int category1Count = 0;

  List<CategoryModel> categoriesLevel1 = [];
  List<CategoryModel> categoriesLevel2 = [];
  List<CategoryModel> categoriesLevel3 = [];
  List<CategoryModel> categoriesLevel4 = [];

  List<ProductModel> products = [];

  CategoryModel? category1, category2, category3, category4;
  // List<CategoryModel>? category3 = [];

  ProductModel? product;

  void updateCategories(OfferModel model) {
    selectProduct(
      categoryLevel1: model.categoryLevel1.id,
      categoryLevel2: model.categoryLevel2.id,
      categoryLevel3: model.categoryLevel3.id,
      categoryLevel4: model.productId.id,
    );
  }

  Future<void> updateBusinessCategories(BusinessEntity entity) async {
    emit(BusinessCategoryInitial());
    try {
      for (var element in categoriesLevel1) {
        if (element.id == entity.categoryLevel1) {
          category1 = element;
          break;
        }
      }

      for (var element in categoriesLevel2) {
        if (element.id == entity.categoryLevel2) {
          category2 = element;
          break;
        }
      }

      debugPrint('category1: ${category1?.name}');
      debugPrint('category1: ${category2?.name}');
      debugPrint('category3: ${entity.categoryLevel3}');
    } catch (e) {
      debugPrint(e.toString());
    }
    emit(OptionSelectedState());
  }

  void resetCategories() {
    // Clear the lists
    categoriesLevel1.clear();
    categoriesLevel2.clear();
    categoriesLevel3.clear();
    categoriesLevel4.clear();

    // Reset the category variables
    category1 = null;
    category2 = null;
    category3 = null;
    category4 = null;

    emit(BusinessCategoryInitial());
  }

  void categoryLevel1(CategoryModel? categoryModel) {
    emit(BusinessCategoryInitial());
    category1 = categoryModel;
    category2 = null;
    category3 = null;
    category4 = null;
    categoriesLevel3 = [];
    categoriesLevel4 = [];
    emit(OptionSelectedState());
  }

  void categoryLevel2(CategoryModel? categoryModel) {
    emit(BusinessCategoryInitial());
    category2 = categoryModel;
    category3 = null;
    categoriesLevel3 = [];
    emit(OptionSelectedState());
  }

  void categoryLevel3(CategoryModel? categoryModel) {
    category3 = categoryModel;
    // if (!category3!.contains(categoryModel)) {
    //   category3?.add(categoryModel!);
    // } else {
    //   category3?.remove(categoryModel);
    // }
  }

  void categoryLevel4(CategoryModel? categoryModel) {
    category4 = categoryModel;
  }

  void resetCategoryLevel2() {
    categoriesLevel2 = [];
    emit(BusinessCategoryInitial());
  }

  void setCategory1Count(int count) {
    emit(BusinessCategoryInitial());
    category1Count = count;
    emit(Category1GridCountChangedState(count: count));
  }

  void resetCategoryLevel3({List<CategoryModel>? categories = const []}) {
    emit(Trying());
    categoriesLevel3 = categories!;
    emit(BusinessCategoryInitial());
  }

  Future<void> selectProduct(
      {required String categoryLevel1,
      required String categoryLevel2,
      required String categoryLevel3,
      String? categoryLevel4}) async {
    CategoryEntity entity = CategoryEntity(
      level1Id: categoryLevel1,
      categorylevel: 1,
    );

    category1 = categoriesLevel1.firstWhere(
      (element) => element.id == categoryLevel1,
    );

    try {
      await getCategories(
          entity.copyWith(categorylevel: 2, level1Id: category1?.id));
      category2 = categoriesLevel2.firstWhere(
        (element) => element.id == categoryLevel2,
      );

      await getCategories(entity.copyWith(
        categorylevel: 3,
        level2Id: category2?.id,
      ));
      category3 = categoriesLevel3.firstWhere(
        (element) => element.id == categoryLevel3,
      );

      await getCategories(entity.copyWith(
        categorylevel: 4,
        level3Id: category3?.id,
      ));

      if (categoryLevel4 != null) {
        category4 = categoriesLevel4.firstWhere(
          (element) => element.id == categoryLevel4,
        );
      }
      debugPrint('category1: ${category1?.name}');
      debugPrint('category2: ${category2?.name}');
      debugPrint('category3: ${category3?.name}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getProducts(GetProductsEntity entity) async {
    emit(const GetProductLoading());
    final result = await _getProductUseCase.call(entity);
    result.fold(
      (failure) {
        emit(
          GetCategoriesFailure(
            message: failure.message ?? 'Something went wrong..',
          ),
        );
      },
      (response) {
        products = response.data ?? [];
        emit(
          GetProductSuccess(products: response.data!),
        );
      },
    );
  }

  Future<void> getCategories(CategoryEntity entity) async {
    switch (entity.categorylevel!) {
      case 1:
        emit(const GetCategoriesLevel1Loading());
        break;
      case 2:
        emit(const GetCategoriesLevel2Loading());
        break;
      case 3:
        emit(const GetCategoriesLevel3Loading());
      case 4:
        emit(const GetCategoriesLevel4Loading());
        break;
      default:
    }
    final result = await _getCategoriesUseCase.call(entity);

    debugPrint(result.isRight().toString());
    result.fold(
      (failure) {
        emit(GetCategoriesFailure(
            message: failure.message ?? 'Something went wrong..'));
      },
      (response) {
        switch (entity.categorylevel!) {
          case 1:
            categoriesLevel1 = response.data!;
          case 2:
            categoriesLevel2 = response.data!;
          case 3:
            categoriesLevel3 = response.data!;
          case 4:
            categoriesLevel4 = response.data!;
          default:
        }

        emit(GetCategoriesSuccess(
          categorysLevel1: categoriesLevel1,
          categorysLevel2: categoriesLevel2,
          categorysLevel3: categoriesLevel3,
          categorysLevel4: categoriesLevel4,
        ));
      },
    );
  }
}
