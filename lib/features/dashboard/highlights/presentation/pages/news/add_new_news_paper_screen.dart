import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/state_selector_cubit/state_selector_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/attach_or_review_image_widget.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_check_box_tile.dart';
import 'package:divyam_flutter/ui/moleclues/custom_drop_down.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:divyam_flutter/ui/moleclues/full_progress_indicator.dart';
import 'package:divyam_flutter/ui/moleclues/pdf_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewsPaperScreen extends StatefulWidget {
  const AddNewsPaperScreen({super.key});

  @override
  State<AddNewsPaperScreen> createState() => _AddNewsPaperScreenState();
}

class _AddNewsPaperScreenState extends State<AddNewsPaperScreen> {
  late StateSelectorCubit _stateSelectorCubit;
  late TextEditingController _stateTC, _cityTC, _areaTC;

  @override
  void initState() {
    super.initState();
    _stateSelectorCubit = sl<StateSelectorCubit>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _stateSelectorCubit.getStates();
    });
    _stateTC = TextEditingController();
    _cityTC = TextEditingController();
    _areaTC = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'Add New Newspaper'.toUpperCase(),
      body: BlocConsumer<StateSelectorCubit, StateSelectorState>(
        bloc: _stateSelectorCubit,
        listener: (context, state) {
          if (state is StatesFailureState) {
            ScaffoldHelper.showFailureSnackBar(
                context: context, message: state.message);
          }
        },
        builder: (context, state) {
          return FullScreenProgressIndicator(
            isLoading: state is StatesLoadingState,
            child: _buildBody(),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: FigmaValueConstants.defaultPaddingH.w,
      ),
      child: Column(
        children: [
          CustomSpacers.height20,
          CustomTextField(
            hintText: 'Name of the newspaper',
            controller: TextEditingController(),
          ),
          CustomSpacers.height20,
          _buildStateDropDown(),
          CustomSpacers.height20,
          CustomTextField(
            hintText: 'Registered address',
            maxLines: 6,
            controller: TextEditingController(),
          ),
          CustomSpacers.height20,
          CustomTextField(
            hintText: 'Registered contact number',
            controller: TextEditingController(),
          ),
          CustomSpacers.height20,
          CustomTextField(
            hintText: 'Registered email address',
            controller: TextEditingController(),
          ),
          CustomSpacers.height20,
          const AttachOrReviewShopPicWidget(
            maxSecondaryImages: 1,
            onlyPickSecondaryImages: true,
            secondaryImageLabel: 'Upload license photo',
          ),
          CustomSpacers.height20,
          const PdfPickerWidget(),
          //! add PDF upload
          CustomSpacers.height20,
          CustomTextField(
            hintText: 'User ID of authorized uploader',
            controller: TextEditingController(),
          ),
          CustomSpacers.height20,
          CustomTextField(
            hintText: 'Mobile of authorized uploader',
            controller: TextEditingController(),
          ),
          CustomSpacers.height20,
          const AttachOrReviewShopPicWidget(
            maxSecondaryImages: 1,
            onlyPickSecondaryImages: true,
            secondaryImageLabel: 'Upload newspaper logo',
          ),
          CustomSpacers.height20,
          CustomCheckBoxTile(
            onChanged: (option) {},
            option: "I agree with terms & conditions",
          ),
          CustomSpacers.height20,
          CustomButton(
            onPressed: () {},
            btnText: 'Submit',
          ),
          CustomSpacers.height20,
        ],
      ),
    );
  }

  Widget _buildStateDropDown() {
    return BlocBuilder<StateSelectorCubit, StateSelectorState>(
      bloc: _stateSelectorCubit,
      builder: (context, state) {
        debugPrint('state is ${_stateSelectorCubit.selectedState?.name}');
        debugPrint(
            'talukas is ${_stateSelectorCubit.selectedDistrict?.talukas.length}');
        return Column(
          children: [
            CustomDropDown(
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please select your state';
                }
                return null;
              },
              onChanged: (idx) {
                _stateSelectorCubit
                    .filterStates(_stateSelectorCubit.allStates[idx!]);
              },
              hintText: 'State',
              options:
                  _stateSelectorCubit.allStates.map((e) => e.name).toList(),
              controller: _stateTC,
            ),
            CustomSpacers.height20,
            CustomCheckBoxTile(
              onChanged: (option) {},
              option: "Circulation is in a metro city",
            ),
            if (_stateSelectorCubit.selectedState?.districts != null &&
                _stateSelectorCubit.selectedState!.districts.isNotEmpty) ...[
              CustomSpacers.height20,
              CustomDropDown(
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Please select your District';
                    }
                    return null;
                  },
                  onChanged: (idx) {
                    _stateSelectorCubit.selectDistrict(
                      _stateSelectorCubit.selectedState!.districts[idx!],
                    );
                  },
                  hintText: 'District / Metro city',
                  options: _stateSelectorCubit.selectedState?.districts
                          .map((e) => e.name)
                          .toList() ??
                      [],
                  controller: _cityTC),
            ],
            if (_stateSelectorCubit.selectedDistrict != null &&
                _stateSelectorCubit.selectedDistrict!.talukas.isNotEmpty) ...[
              CustomSpacers.height20,
              CustomDropDown(
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Please select your area';
                  }
                  return null;
                },
                onChanged: (p0) {
                  _stateSelectorCubit.selectTaluka(
                      _stateSelectorCubit.selectedDistrict!.talukas[p0!]);
                },
                hintText: 'Taluka / Area',
                options: _stateSelectorCubit.selectedDistrict?.talukas
                        .map((e) => e.name)
                        .toList() ??
                    ['Taluka'],
                controller: _areaTC,
              ),
            ],
          ],
        );
      },
    );
  }
}
