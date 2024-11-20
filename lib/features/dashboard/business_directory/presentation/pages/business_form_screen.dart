import 'dart:async';

import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/enums/business_form_type.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_directory_cubit/business_directory_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/state_selector_cubit/state_selector_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/pages/business_preview_screen.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/business_form_step_one.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/business_form_step_two.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/ui/atoms/keyboard_dismiss.dart';
import 'package:divyam_flutter/ui/atoms/loading.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/full_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BusinessFormScreen extends StatefulWidget {
  final BusinessFormType businessFormType;
  final BusinessEntity? businessEntity;
  const BusinessFormScreen(
      {super.key, required this.businessFormType, this.businessEntity});

  @override
  State<BusinessFormScreen> createState() => _BusinessFormScreenState();
}

class _BusinessFormScreenState extends State<BusinessFormScreen> {
  late StreamController<int> _pageController;
  late StateSelectorCubit _stateSelectorCubit;

  late BusinessDirectoryCubit _directoryCubit;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _directoryCubit = sl<BusinessDirectoryCubit>();
    _pageController = StreamController<int>.broadcast();
    _stateSelectorCubit = sl<StateSelectorCubit>();
    _directoryCubit.setFormType(widget.businessFormType);
    if (widget.businessEntity != null) {
      _directoryCubit.setBusinessEntity(widget.businessEntity!);
    }

    super.initState();
  }

  @override
  void dispose() {
    _pageController.close();
    _directoryCubit.close();
    // _stateSelectorCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (c) {},
      child: CustomScaffold(
        appBarTitle: widget.businessFormType.appBarTitle,
        body: BlocConsumer<StateSelectorCubit, StateSelectorState>(
          listener: (context, state) {
            if (state is GetStatesSuccessState) {
              // String? selectedState = _stateSelectorCubit
              //     .filterStatesByQuery(widget.businessEntity?.state ?? "");
              // String? selectedCity = _stateSelectorCubit
              //     .filterDistrictsByQuery(widget.businessEntity?.district ?? "");
              // String? selectedTaluka = _stateSelectorCubit
              //     .filterTalukasByQuery(widget.businessEntity?.taluka ?? "");

              // if (selectedState != null) {
              //   _directoryCubit.stateChanged(selectedState);
              // }
              // if (selectedCity != null) {
              //   _directoryCubit.districtChanged(selectedCity);
              // }
              // if (selectedTaluka != null) {
              //   _directoryCubit.talukaChanged(selectedTaluka);
              // }
            }
          },
          bloc: _stateSelectorCubit,
          builder: (context, state) {
            return FullScreenProgressIndicator(
              isLoading: state is StatesLoadingState,
              child: KeyboardDismissOnTap(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                        horizontal: FigmaValueConstants.defaultPaddingH.w),
                    child: _buildBody(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<BusinessDirectoryCubit, BusinessDirectoryState>(
      buildWhen: (previous, current) =>
          current is EditBusinessFormLoadingState ||
          current is BusinessDirectoryInitial,
      bloc: _directoryCubit,
      builder: (context, state) {
        if (state is! EditBusinessFormLoadingState) {
          return widget.businessFormType.isAdd
              ? _buildNewBusinessForm()
              : _buildExistingBusinessForm();
        }
        return const Center(child: Loading());
      },
    );
  }

  Widget _buildExistingBusinessForm() {
    return StreamBuilder<int>(
      stream: _pageController.stream,
      initialData: 0,
      builder: (context, snapshot) {
        return Stack(
          children: [
            Column(
              children: [
                CustomSpacers.height20,
                snapshot.data == 0
                    ? BusinessFormStepOne(
                        businessDirectoryCubit: _directoryCubit,
                        stateSelectorCubit: _stateSelectorCubit,
                      )
                    : BusinessFormStepTwo(
                        businessDirectoryCubit: _directoryCubit,
                      ),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Assuming openingTime and closingTime are in 'HH:MM' format strings
                      final openingTimeStr =
                          _directoryCubit.businessEntity.openingTime;
                      final closingTimeStr =
                          _directoryCubit.businessEntity.closingTime;

                      // Define the format to parse the time strings
                      final timeFormat = DateFormat('HH:mm');

                      try {
                        final openingTime = timeFormat.parse(openingTimeStr);
                        final closingTime = timeFormat.parse(closingTimeStr);

                        // Validate if closing time is greater than opening time
                        if (closingTime.isBefore(openingTime)) {
                          ScaffoldHelper.showFailureSnackBar(
                              context: context,
                              message:
                                  "Closing time must be greater than opening time");

                          return;
                        }

                        // Proceed with the next step
                        if (snapshot.data == 0) {
                          _pageController.sink.add(1);
                        } else {
                          _navigate();
                        }
                      } catch (e) {
                        ScaffoldHelper.showFailureSnackBar(
                            context: context, message: "Invalid Date format");
                      }
                    }
                  },
                  btnText: snapshot.data == 0 ? 'Next' : 'Update',
                ),
                CustomSpacers.height20,
                Visibility(
                  visible: snapshot.data == 1,
                  child: CustomButton(
                      onPressed: () {
                        _pageController.sink.add(0);
                      },
                      btnText: 'Previous'),
                ),
                CustomSpacers.height120,
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildNewBusinessForm() {
    return Column(
      children: [
        CustomSpacers.height20,
        BusinessFormStepOne(
          businessDirectoryCubit: _directoryCubit,
          stateSelectorCubit: _stateSelectorCubit,
        ),
        CustomSpacers.height20,
        BusinessFormStepTwo(
          businessDirectoryCubit: _directoryCubit,
        ),
        CustomSpacers.height20,
        CustomButton(onPressed: () => _navigate(), btnText: 'Submit'),
        CustomSpacers.height120,
      ],
    );
  }

  Future<void> _navigateUpdate() async {}

  Future<void> _navigate() async {
    try {
      if (_formKey.currentState!.validate()) {
        if (_directoryCubit.businessEntity.primaryImage.isEmpty) {
          ScaffoldHelper.showFailureSnackBar(
              context: context, message: "Primary Image is required");

          return;
        }

        final openingTimeStr = _directoryCubit.businessEntity.openingTime;
        final closingTimeStr = _directoryCubit.businessEntity.closingTime;

        // Define the format to parse the time strings
        final timeFormat = DateFormat('HH:mm');

        final openingTime = timeFormat.parse(openingTimeStr);
        final closingTime = timeFormat.parse(closingTimeStr);

        if (closingTime.isBefore(openingTime)) {
          ScaffoldHelper.showFailureSnackBar(
              context: context,
              message: "Closing time must be greater than opening time");

          return;
        }

        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BusinessPreviewScreen(
                businessDirectoryCubit: _directoryCubit,
              );
            },
          ),
        );
      }
    } catch (e) {
      print('===========================>$e');
    }
  }
}
