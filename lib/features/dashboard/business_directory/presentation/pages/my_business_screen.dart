import 'package:divyam_flutter/core/enums/business_form_type.dart';
import 'package:divyam_flutter/core/enums/business_status.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_directory_cubit/business_directory_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/business_card.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/atoms/loading.dart';
import 'package:divyam_flutter/ui/moleclues/custom_floating_action_btn.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBusinessScreen extends StatefulWidget {
  const MyBusinessScreen({super.key});

  @override
  State<MyBusinessScreen> createState() => _MyBusinessScreenState();
}

class _MyBusinessScreenState extends State<MyBusinessScreen> {
  late BusinessDirectoryCubit _businessDirectoryCubit;

  @override
  void initState() {
    _businessDirectoryCubit = sl<BusinessDirectoryCubit>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _businessDirectoryCubit.getMyBusiness();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'My Business',
      enableBottomSheet: false,
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () => CustomNavigator.pushTo(
          context,
          AppRouter.addNewBusiness,
          arguments: BusinessFormType.add,
        ),
        label: 'Add New Business',
        icon: Icons.add,
      ),
      body: BlocConsumer<BusinessDirectoryCubit, BusinessDirectoryState>(
        bloc: _businessDirectoryCubit,
        listener: (context, state) {
          if (state is BusinessDirectoryFailure) {
            ScaffoldHelper.showFailureSnackBar(
                context: context, message: state.message);
          }
        },
        buildWhen: (previous, current) =>
            current is GetAllBusinessDirectoryFailure ||
            current is GetALlBusinessLoadingState ||
            current is GetMyBusinessSuccessState,
        builder: (context, state) {
          if (state is GetMyBusinessSuccessState) {
            if (state.data.isEmpty) {
              return const Center(
                child: Text(
                    'No business found. Create a new one by tapping the ➕ button!'),
              );
            }

            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 21.h),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 20.w, // Horizontal spacing between items
                    mainAxisSpacing: 20.h, // Vertical spacing between items
                    childAspectRatio:
                        0.5, // Adjust this based on the aspect ratio of your BusinessCard
                  ),
                  itemCount: state.data.length, // Number of items
                  itemBuilder: (context, index) {
                    final business = state.data[index];
                    return BusinessCard(
                      status: BusinessStatusType.live,
                      onTap: () => CustomNavigator.pushTo(
                        context,
                        AppRouter.businessInfoScreen,
                        arguments: business.toEntity(),
                      ),
                      data: business.toEntity(),
                    );
                  },
                ));
          }

          return const Loading();
        },
      ),
    );
  }
}
