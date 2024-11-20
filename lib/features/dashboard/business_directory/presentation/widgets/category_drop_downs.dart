import 'dart:async'; // Import for Timer

import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/enums/business_form_type.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/category_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/get_products_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_categories_cubit/business_category_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_directory_cubit/business_directory_cubit.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/ui/moleclues/custom_drop_down.dart';
import 'package:divyam_flutter/ui/moleclues/custom_multi_select.dart';
import 'package:divyam_flutter/ui/moleclues/custom_search_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesDropDown extends StatefulWidget {
  final BusinessDirectoryCubit businessDirectoryCubit;

  const CategoriesDropDown({super.key, required this.businessDirectoryCubit});

  @override
  State<CategoriesDropDown> createState() => _CategoriesDropDownState();
}

class _CategoriesDropDownState extends State<CategoriesDropDown> {
  late BusinessCategoryCubit _cubit;
  late TextEditingController controller;
  Timer? _debounce; // Debounce Timer

  List<String> categoriesLevel4 = [];
  CategoryEntity _entity = CategoryEntity(
    categorylevel: 1,
    level1Id: null,
  );

  final GetProductsEntity _productEntity = const GetProductsEntity(name: '');

  @override
  void initState() {
    super.initState();
    _cubit = sl<BusinessCategoryCubit>();
    controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _cubit.getCategories(_entity);
        _cubit.getProducts(_productEntity);
        if (!widget.businessDirectoryCubit.formType.isAdd) {
          final businessEntity = widget.businessDirectoryCubit.businessEntity;
          _cubit.selectProduct(
            categoryLevel1: businessEntity.categoryLevel1!,
            categoryLevel2: businessEntity.categoryLevel2!,
            categoryLevel3: businessEntity.categoryLevel3!.first,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel(); // Cancel the debounce timer
    controller.dispose();
    _cubit.category1 = null;
    _cubit.category2 = null;
    _cubit.category3 = null;

    _cubit.categoriesLevel2 = [];
    _cubit.categoriesLevel3 = [];
    _cubit.categoriesLevel4 = [];

    super.dispose();
  }

  void _onSearchTextChanged(String text) {}

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BusinessCategoryCubit, BusinessCategoryState>(
      listener: (context, state) {
        widget.businessDirectoryCubit.categoryLevel1Changed(
            _cubit.category1?.id ?? '', _cubit.category1?.name ?? '');
        widget.businessDirectoryCubit
            .categoryLevel2Changed(_cubit.category2?.id ?? '');
        widget.businessDirectoryCubit
            .categoryLevel3Changed([_cubit.category3?.id ?? '']);
      },
      bloc: _cubit,
      builder: (context, state) {
        return Column(
          children: [
            SearchableDropdown(
              options: _cubit.products.map((e) => e.name).toList(),
              controller: controller,
              onTextChange: (value) {
                if (_debounce?.isActive ?? false) {
                  _debounce?.cancel();
                }
                _debounce = Timer(const Duration(milliseconds: 300), () {
                  _cubit.getProducts(GetProductsEntity(name: value ?? ''));
                });
              }, // Debounced callback
              onSelect: (index) {
                if (index != null) {
                  _cubit.selectProduct(
                    categoryLevel1: _cubit.products[index].level1CategoryId,
                    categoryLevel2: _cubit.products[index].level2CategoryId,
                    categoryLevel3: _cubit.products[index].level3CategoryId,
                  );
                }
              },
            ),
            CustomSpacers.height20,
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorPalette.primaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              width: double.infinity,
              child: Column(
                children: [
                  CustomDropDown(
                    groupValue: _cubit.category1?.name,
                    validator: (val) =>
                        val == null ? 'Please Select Level 1 Category' : null,
                    hintText: state is GetCategoriesLevel1Loading
                        ? 'Getting Level 1 Categories...'
                        : 'Please Select Level 1 Category',
                    options:
                        _cubit.categoriesLevel1.map((e) => e.name).toList(),
                    onChanged: (p0) {
                      final category = _cubit.categoriesLevel1[p0!];
                      widget.businessDirectoryCubit
                          .categoryLevel1Changed(category.id, category.name);
                      _cubit.categoryLevel1(category);
                      _entity = _entity.copyWith(
                        level1Id: category.id,
                        categorylevel: 2,
                        level3Id: null,
                      );
                      _cubit.getCategories(_entity);
                    },
                    controller: TextEditingController(),
                  ),
                  CustomSpacers.height20,
                  Visibility(
                    visible: _cubit.categoriesLevel2.isNotEmpty ||
                        state is GetCategoriesLevel2Loading,
                    child: CustomDropDown(
                      groupValue: _cubit.category2?.name,
                      validator: (val) =>
                          val == null ? 'Please Select Level 2 Category' : null,
                      onChanged: (p0) {
                        final category = _cubit.categoriesLevel2[p0!];
                        _cubit.categoryLevel2(category);
                        _entity = _entity.copyWith(
                          level2Id: category.id,
                          categorylevel: 3,
                        );
                        widget.businessDirectoryCubit
                            .categoryLevel2Changed(category.id);
                        _cubit.getCategories(_entity);
                      },
                      hintText: state is GetCategoriesLevel2Loading
                          ? 'Getting Level 2 Categories...'
                          : 'Please Select Level 2 Category',
                      options:
                          _cubit.categoriesLevel2.map((e) => e.name).toList(),
                      controller: TextEditingController(),
                    ),
                  ),
                  CustomSpacers.height20,
                  Visibility(
                    visible: _cubit.categoriesLevel3.isNotEmpty ||
                        state is GetCategoriesLevel3Loading,
                    child: CustomMultiSelectDropDown(
                      groupValue: _cubit.category3?.name != null
                          ? [_cubit.category3!.name]
                          : [],
                      validator: (val) =>
                          val == null ? 'Please Select Level 3 Category' : null,
                      onChanged: (v) {
                        final categoriesLevel3Selected =
                            v.map((index) => _cubit.categoriesLevel3[index]);

                        debugPrint(categoriesLevel3Selected
                            .map((e) => e.id)
                            .toList()
                            .toString());

                        widget.businessDirectoryCubit.categoryLevel3Changed(
                          categoriesLevel3Selected.map((e) => e.id).toList(),
                        );
                      },
                      hintText: state is GetCategoriesLevel3Loading
                          ? 'Getting Level 3 Categories...'
                          : 'Please Select Level 3 Category',
                      options:
                          _cubit.categoriesLevel3.map((e) => e.name).toList(),
                      controller: TextEditingController(),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
