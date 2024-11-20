import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/category_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_categories_cubit/business_category_cubit.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_drop_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class CategoryFilterWidget extends StatefulWidget {
  final bool? isOffersSheet;
  final BusinessCategoryCubit businessCategoryCubit;
  final VoidCallback onApplyFilterTap, onResetFilterTap;
  final Function(String? categoryId2, String? categoryId3, String? categoryId4)
      onItemPressed;
  const CategoryFilterWidget(
      {super.key,
      required this.onApplyFilterTap,
      required this.onResetFilterTap,
      this.isOffersSheet = false,
      required this.businessCategoryCubit,
      required this.onItemPressed});

  @override
  State<CategoryFilterWidget> createState() => _CategoryFilterWidgetState();
}

class _CategoryFilterWidgetState extends State<CategoryFilterWidget> {
  late BusinessCategoryCubit _cubit;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _cubit = widget.businessCategoryCubit;

    if (widget.isOffersSheet == true) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _cubit.getCategories(CategoryEntity());
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessCategoryCubit, BusinessCategoryState>(
      bloc: _cubit,
      builder: (context, state) {
        if ((_cubit.categoriesLevel2.isEmpty &&
                _cubit.categoriesLevel2.isEmpty) &&
            !widget.isOffersSheet!) {
          return Center(
            child: Text(
              textAlign: TextAlign.center,
              'No Categories Found based on the\nselected filters ☹️',
              style: AppTextThemes.theme(context).headlineLarge?.copyWith(
                    color: ColorPalette.primaryColor,
                  ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: _cubit.categoriesLevel2.isNotEmpty ||
                  state is GetCategoriesLevel1Loading ||
                  widget.isOffersSheet!,
              child: CustomDropDown(
                groupValue: _cubit.category1?.name ?? '',
                validator: (val) =>
                    val == null ? 'Please Select Level 1 Category' : null,
                // groupValue: widget
                //     .businessDirectoryCubit.businessEntity.categoryLevel1,
                onChanged: (p0) {
                  final category = _cubit.categoriesLevel1[p0!];
                  _cubit.categoryLevel1(category);
                  widget.onItemPressed(_cubit.category2?.id,
                      _cubit.category2?.id, _cubit.category3?.id);
                  _cubit.getCategories(
                      CategoryEntity(level1Id: category.id, categorylevel: 2));
                },
                hintText: state is GetCategoriesLevel1Loading
                    ? 'Getting Level 1 Categories...'
                    : 'Please Select Level 1 Category',
                options: _cubit.categoriesLevel1.map((e) => e.name).toList(),
                controller: TextEditingController(),
              ),
            ),
            CustomSpacers.height20,
            Visibility(
              visible: _cubit.categoriesLevel2.isNotEmpty ||
                  state is GetCategoriesLevel2Loading,
              child: CustomDropDown(
                groupValue: _cubit.category2?.name ?? '',
                validator: (val) =>
                    val == null ? 'Please Select Level 2 Category' : null,
                // groupValue: widget
                //     .businessDirectoryCubit.businessEntity.categoryLevel1,
                onChanged: (p0) {
                  final category = _cubit.categoriesLevel2[p0!];
                  _cubit.categoryLevel2(category);
                  widget.onItemPressed(_cubit.category2?.id,
                      _cubit.category2?.id, _cubit.category3?.id);
                  _cubit.getCategories(
                      CategoryEntity(level2Id: category.id, categorylevel: 3));
                },
                hintText: state is GetCategoriesLevel2Loading
                    ? 'Getting Level 2 Categories...'
                    : 'Please Select Level 2 Category',
                options: _cubit.categoriesLevel2.map((e) => e.name).toList(),
                controller: TextEditingController(),
              ),
            ),
            CustomSpacers.height20,
            Visibility(
              visible: _cubit.categoriesLevel3.isNotEmpty ||
                  state is GetCategoriesLevel3Loading,
              child: CustomDropDown(
                groupValue: _cubit.category3?.name ?? '',
                validator: (val) =>
                    val == null ? 'Please Select Level 3 Category' : null,
                // groupValue:
                //     widget.businessDirectoryCubit.businessEntity.categoryLevel1,
                onChanged: (p0) {
                  final category = _cubit.categoriesLevel3[p0!];
                  _cubit.categoryLevel3(category);
                  _cubit.getCategories(
                      CategoryEntity(level3Id: category.id, categorylevel: 4));

                  widget.onItemPressed(_cubit.category2?.id,
                      _cubit.category2?.id, _cubit.category3?.id);
                },
                hintText: state is GetCategoriesLevel3Loading
                    ? 'Getting Level 3 Categories...'
                    : 'Please Select Level 3 Category',

                options: _cubit.categoriesLevel3.map((e) => e.name).toList(),
                controller: TextEditingController(),
              ),
            ),
            CustomSpacers.height20,
            Visibility(
              visible: _cubit.categoriesLevel4.isNotEmpty ||
                  state is GetCategoriesLevel4Loading,
              child: CustomDropDown(
                groupValue: _cubit.category4?.name ?? '',
                validator: (val) =>
                    val == null ? 'Please Select Level 4 Category' : null,
                // groupValue:
                //     widget.businessDirectoryCubit.businessEntity.categoryLevel1,
                onChanged: (p0) {
                  final category = _cubit.categoriesLevel4[p0!];

                  _cubit.categoryLevel4(category);
                  widget.onItemPressed(_cubit.category2?.id,
                      _cubit.category2?.id, _cubit.category3?.id);
                },
                hintText: state is GetCategoriesLevel3Loading
                    ? 'Getting Level 4 Categories...'
                    : 'Please Select Level 4 Category',
                options: _cubit.categoriesLevel4.map((e) => e.name).toList(),
                controller: TextEditingController(),
              ),
            ),
            CustomSpacers.height56,
            Visibility(
              visible: _cubit.category2 != null ||
                  _cubit.category3 != null ||
                  _cubit.category4 != null ||
                  (widget.isOffersSheet! && _cubit.category1 != null),
              child: CustomButton(
                  onPressed: widget.onApplyFilterTap, btnText: 'Apply filter'),
            ),
            CustomSpacers.height20,
            Visibility(
              visible: _cubit.category2 != null ||
                  _cubit.category3 != null ||
                  _cubit.category4 != null ||
                  (widget.isOffersSheet! && _cubit.category1 != null),
              child: CustomButton(
                  onPressed: widget.onResetFilterTap, btnText: 'Reset filters'),
            ),
          ],
        );
      },
    );
  }
}
