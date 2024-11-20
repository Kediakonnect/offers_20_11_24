import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/category_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/category_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_categories_cubit/business_category_cubit.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/cubit/offers_cubit.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/ui/moleclues/custom_drop_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class OffersCategoriesDropDown extends StatefulWidget {
  final bool? isBuy;
  final List<CategoryModel>? categories;
  final OffersCubit offersCubit;
  const OffersCategoriesDropDown({
    super.key,
    this.isBuy = false,
    this.categories,
    required this.offersCubit,
  });

  @override
  State<OffersCategoriesDropDown> createState() =>
      _OffersCategoriesDropDownState();
}

class _OffersCategoriesDropDownState extends State<OffersCategoriesDropDown> {
  late BusinessCategoryCubit _cubit;
  late OffersCubit _offersCubit;
  late TextEditingController controller;

  CategoryEntity _entity = CategoryEntity(
    categorylevel: 1,
    level1Id: null,
  );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _offersCubit = widget.offersCubit;
    _cubit = sl<BusinessCategoryCubit>();
    controller = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BusinessCategoryCubit, BusinessCategoryState>(
      listener: (context, state) {
        if (_cubit.category1 != null) {
          _offersCubit.categoryLevel1Changed(_cubit.category1!.id);
        }

        if (_cubit.category2 != null) {
          _offersCubit.categoryLevel2Changed(_cubit.category2!.id);
        }

        if (_cubit.category3 != null) {
          _offersCubit.categoryLevel3Changed(_cubit.category3!.id);
        }

        if (_cubit.category4 != null) {
          _offersCubit.categoryLevel4Changed(_cubit.category4!.id);
        }
      },
      bloc: _cubit,
      builder: (context, state) {
        return Column(
          children: [
            CustomDropDown(
              disabled: widget.isBuy,
              groupValue: _cubit.category1?.name,
              validator: (val) =>
                  val == null ? 'Please Select Level 1 Category' : null,
              hintText: state is GetCategoriesLevel1Loading
                  ? 'Getting Level 1 Categories...'
                  : 'Please Select Level 1 Category',
              options: _cubit.categoriesLevel1.map((e) => e.name).toList(),
              onChanged: (p0) {
                final category = _cubit.categoriesLevel1[p0!];
                _offersCubit.categoryLevel1Changed(category.id);
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
                  disabled: widget.isBuy,
                  groupValue: _cubit.category2?.name,
                  validator: (val) =>
                      val == null ? 'Please Select Level 2 Category' : null,
                  onChanged: (p0) {
                    final category = _cubit.categoriesLevel2[p0!];

                    _offersCubit.categoryLevel2Changed(category.id);
                    _cubit.categoryLevel2(category);
                    _entity = _entity.copyWith(
                      level2Id: category.id,
                      categorylevel: 3,
                    );

                    _cubit.getCategories(_entity);
                  },
                  hintText: state is GetCategoriesLevel2Loading
                      ? 'Getting Level 2 Categories...'
                      : 'Please Select Level 2 Category',
                  options: _cubit.categoriesLevel2.map((e) => e.name).toList(),
                  controller: TextEditingController()),
            ),
            CustomSpacers.height20,
            Visibility(
              visible: _cubit.categoriesLevel3.isNotEmpty ||
                  state is GetCategoriesLevel3Loading,
              child: CustomDropDown(
                groupValue: _cubit.category3?.name,
                validator: (val) =>
                    val == null ? 'Please Select Level 3 Category' : null,
                onChanged: (v) {
                  final category = _cubit.categoriesLevel3[v!];
                  _cubit.categoryLevel3(category);
                  _offersCubit.categoryLevel3Changed(category.id);
                  _entity = _entity.copyWith(
                    level3Id: category.id,
                    categorylevel: 4,
                  );
                  _cubit.getCategories(_entity);
                },
                hintText: state is GetCategoriesLevel3Loading
                    ? 'Getting Level 3 Categories...'
                    : 'Please Select Level 3 Category',
                options: widget.categories != null
                    ? widget.categories!.map((e) => e.name).toList()
                    : _cubit.categoriesLevel3.map((e) => e.name).toList(),
                controller: TextEditingController(),
              ),
            ),
            CustomSpacers.height20,
            Visibility(
              visible: _cubit.categoriesLevel4.isNotEmpty,
              child: CustomDropDown(
                groupValue: _cubit.category4?.name,
                options: _cubit.categoriesLevel4.map((e) => e.name).toList(),
                controller: TextEditingController(),
                onChanged: (v) {
                  final category = _cubit.categoriesLevel4[v!];
                  _cubit.categoryLevel4(category);
                  _offersCubit.categoryLevel4Changed(category.id);
                },
              ),
            )
          ],
        );
      },
    );
  }
}
