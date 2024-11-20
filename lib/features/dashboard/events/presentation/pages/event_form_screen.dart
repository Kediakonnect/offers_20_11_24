import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/enums/event_form_type.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/state_selector_cubit/state_selector_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/attach_or_review_image_widget.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_check_box_tile.dart';
import 'package:divyam_flutter/ui/moleclues/custom_drop_down.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:divyam_flutter/ui/moleclues/full_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventFormScreen extends StatefulWidget {
  final EventFormType formType;
  const EventFormScreen({super.key, required this.formType});

  @override
  State<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  late StateSelectorCubit _stateSelectorCubit;
  late TextEditingController _titleTC,
      _categoryTC,
      _startDateTC,
      _endDateTC,
      _organizerTC,
      _cheifGuestTC,
      _descriptionTC,
      _stateTC,
      _cityTC,
      _contactInfoTC,
      _venueTC;

  @override
  void initState() {
    _stateSelectorCubit = sl<StateSelectorCubit>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _stateSelectorCubit.getStates();
    });
    _titleTC = TextEditingController();
    _categoryTC = TextEditingController();
    _startDateTC = TextEditingController();
    _endDateTC = TextEditingController();
    _organizerTC = TextEditingController();
    _cheifGuestTC = TextEditingController();
    _descriptionTC = TextEditingController();
    _stateTC = TextEditingController();
    _cityTC = TextEditingController();
    _contactInfoTC = TextEditingController();
    _venueTC = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: widget.formType.title,
      body: BlocBuilder<StateSelectorCubit, StateSelectorState>(
        bloc: _stateSelectorCubit,
        builder: (context, state) {
          return FullScreenProgressIndicator(
            isLoading: state is StatesLoadingState,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: FigmaValueConstants.defaultPaddingH.w),
              child: Column(
                children: [
                  CustomSpacers.height20,
                  CustomCheckBoxTile(
                    onChanged: (v) {},
                    option: 'This event is for MLM downline members',
                  ),
                  CustomSpacers.height20,
                  CustomTextField(
                    controller: _titleTC,
                    hintText: 'Event title',
                  ),
                  CustomSpacers.height20,
                  CustomDropDown(
                    hintText: 'Event category',
                    options: const [
                      'Music Show',
                      'Dance Show',
                    ],
                    controller: _categoryTC,
                  ),
                  CustomSpacers.height20,
                  CustomDropDown(
                    hintText: 'Language',
                    options: const [
                      'English',
                      'Hindi',
                    ],
                    controller: _categoryTC,
                  ),
                  CustomSpacers.height20,
                  CustomTextField(
                    onTap: () {},
                    hintText: 'Start date & time',
                    controller: _startDateTC,
                    readOnly: true,
                  ),
                  CustomSpacers.height20,
                  CustomTextField(
                    onTap: () {},
                    readOnly: true,
                    hintText: 'End date & time',
                    controller: _endDateTC,
                  ),
                  CustomSpacers.height20,
                  CustomTextField(
                    hintText: 'Organizer',
                    controller: _organizerTC,
                  ),
                  CustomSpacers.height20,
                  CustomTextField(
                    hintText: 'Chief guest',
                    controller: _cheifGuestTC,
                  ),
                  CustomSpacers.height20,
                  CustomTextField(
                    hintText: 'Description',
                    maxLines: 6,
                    controller: _descriptionTC,
                  ),
                  CustomSpacers.height20,
                  const AttachOrReviewShopPicWidget(
                    secondaryImageLabel: 'Add images ',
                    onlyPickSecondaryImages: true,
                    maxSecondaryImages: 3,
                  ),
                  CustomSpacers.height20,
                  CustomCheckBoxTile(
                    onChanged: (v) {},
                    option: 'This is a paid event',
                  ),
                  CustomSpacers.height20,
                  _buildStateDropDown(),
                  CustomSpacers.height20,
                  CustomTextField(
                    hintText: 'Venue',
                    maxLines: 6,
                    controller: _venueTC,
                  ),
                  CustomSpacers.height20,
                  CustomTextField(
                    hintText: 'Contact information',
                    maxLines: 6,
                    controller: _contactInfoTC,
                  ),
                  CustomSpacers.height20,
                  CustomButton(
                      onPressed: () => CustomNavigator.pushTo(
                            context,
                            AppRouter.eventPreviewScreen,
                          ),
                      btnText: 'Submit'),
                  CustomSpacers.height56,
                ],
              ),
            ),
          );
        },
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
              option: "I live in metro city",
            ),
            if (_stateSelectorCubit.selectedState?.districts != null &&
                _stateSelectorCubit.selectedState!.districts.isNotEmpty) ...[
              CustomSpacers.height20,
              CustomDropDown(
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
                onChanged: (p0) {
                  _stateSelectorCubit.selectTaluka(
                      _stateSelectorCubit.selectedDistrict!.talukas[p0!]);
                },
                hintText: 'Taluka / Area',
                options: _stateSelectorCubit.selectedDistrict?.talukas
                        .map((e) => e.name)
                        .toList() ??
                    ['Taluka / Area'],
                controller: TextEditingController(),
              ),
            ]
          ],
        );
      },
    );
  }
}
