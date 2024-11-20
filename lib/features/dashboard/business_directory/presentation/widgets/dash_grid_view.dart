import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/enums/dasboard_options.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/category_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/category_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_categories_cubit/business_category_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_directory_cubit/business_directory_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/dashbord_option_card.dart';
import 'package:divyam_flutter/ui/atoms/shimmer_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashBoardGridView extends StatefulWidget {
  final BusinessCategoryCubit businessCategoryCubit;
  final Function(String categoryId) onItemPressed;
  const DashBoardGridView(
      {super.key,
      required this.onItemPressed,
      required this.businessCategoryCubit});

  @override
  State<DashBoardGridView> createState() => _DashBoardGridViewState();
}

class _DashBoardGridViewState extends State<DashBoardGridView> {
  late BusinessCategoryCubit _cubit;

  String selectedCategory = "";

  int count = 0;

  @override
  void initState() {
    _cubit = widget.businessCategoryCubit;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _cubit.getCategories(CategoryEntity());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BusinessCategoryCubit, BusinessCategoryState>(
      listenWhen: (previous, current) => current is GetCategoriesSuccess,
      listener: (context, state) {
        if (_cubit.categoriesLevel1.isNotEmpty && count == 0) {
          count = _cubit.categoriesLevel1.length;
          if (count > 16) {
            _cubit.setCategory1Count(15);
          }
        }
      },
      bloc: _cubit,
      buildWhen: (previous, current) =>
          current is Category1GridCountChangedState ||
          current is GetMyBusinessSuccessState,
      builder: (context, state) {
        if (state is GetCategoriesLevel1Loading) {
          return _buildShimmerGrid();
        }

        if (state is Category1GridCountChangedState) {
          return _buildGrid(
            categories: _cubit.categoriesLevel1,
            count: state.count,
            hasMore: _cubit.categoriesLevel1.length > state.count,
          );
        }
        return _buildGrid(
          categories: _cubit.categoriesLevel1,
          count: _cubit.category1Count,
          hasMore: _cubit.categoriesLevel1.length > count,
        );
      },
    );
  }

  Widget _buildShimmerGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20.0.w,
          mainAxisSpacing: 18.0.h,
          childAspectRatio: .9,
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          return ShimmerContainer(
            height: 65.h,
            width: 65.w,
            decoration: FigmaValueConstants.neuromorphicDecoration,
          );
        },
      ),
    );
  }

  Widget _buildGrid(
      {required List<CategoryModel> categories,
      required int count,
      bool? hasMore = true}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20.0.w,
          mainAxisSpacing: 18.0.h,
          childAspectRatio: .8,
        ),
        itemCount: hasMore! ? count + 1 : count,
        itemBuilder: (context, index) {
          if (count > index) {
            final assetName =
                'assets/gifs/${categories[index].name.replaceAll(' ', '').toLowerCase()}.gif';

            print(categories[index].name.replaceAll(' ', '').toLowerCase());

            return DashBoardOptionCard(
              isSelected: _cubit.category1?.id == categories[index].id,
              onPressed: () {
                _cubit.categoryLevel1(categories[index]);
                _cubit.getCategories(CategoryEntity(
                  level1Id: categories[index].id,
                  categorylevel: 2,
                ));
                selectedCategory = categories[index].id;
                widget.onItemPressed(selectedCategory);
                setState(() {});
              },
              assetName: assetName,
              text: categories[index].name,
            );
          } else {
            return DashBoardOptionCard(
              onPressed: () {
                _cubit.setCategory1Count(_cubit.categoriesLevel1.length);
              },
              assetName: DashBoardOptions.more.assetName,
              text: DashBoardOptions.more.title,
            );
          }
        },
      ),
    );
  }
}
