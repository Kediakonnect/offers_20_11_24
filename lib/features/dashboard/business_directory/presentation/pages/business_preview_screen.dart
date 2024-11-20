import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_directory_cubit/business_directory_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/state_selector_cubit/state_selector_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/pages/my_business_screen.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/market_card.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusinessPreviewScreen extends StatefulWidget {
  final BusinessDirectoryCubit businessDirectoryCubit;

  const BusinessPreviewScreen(
      {super.key, required this.businessDirectoryCubit});

  @override
  State<BusinessPreviewScreen> createState() => _BusinessPreviewScreenState();
}

class _BusinessPreviewScreenState extends State<BusinessPreviewScreen> {
  late StateSelectorCubit stateSelectorCubit;
  @override
  void initState() {
    stateSelectorCubit = sl<StateSelectorCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'Business Preview'.toUpperCase(),
      body: BlocConsumer<BusinessDirectoryCubit, BusinessDirectoryState>(
        bloc: widget.businessDirectoryCubit,
        listener: (context, state) {
          if (state is BusinessDirectoryFailure) {
            ScaffoldHelper.showFailureSnackBar(
                context: context, message: state.message);
          }
          if (state is BusinessDirectorySuccess) {
            ScaffoldHelper.showSuccessSnackBar(
              context: context,
              message: state.message,
            );

            stateSelectorCubit.resetSelections();

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) {
                return const MyBusinessScreen();
              }),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomSpacers.height20,
                  Text(
                    'Preview',
                    style: AppTextThemes.theme(context).displayMedium,
                  ),
                  CustomSpacers.height20,
                  MarketCard(
                    onShareTaped: () {},
                    onRate: (entity) {},
                    onFavoriteTapped: () {},
                    onTap: () => CustomNavigator.pushTo(
                        context, AppRouter.businessDetailScreen,
                        arguments: widget.businessDirectoryCubit.businessEntity
                            .copyWith(isNeworkImages: false)),
                    businessEntity: widget.businessDirectoryCubit.businessEntity
                        .copyWith(isNeworkImages: false),
                  ),
                  CustomSpacers.height40,
                  CustomButton(
                    isLoading: state is BusinessDirectoryLoading,
                    onPressed: () =>
                        widget.businessDirectoryCubit.addBusiness(),
                    btnText: 'Confirm',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
