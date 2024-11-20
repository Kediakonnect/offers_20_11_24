import 'package:divyam_flutter/core/enums/business_form_type.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/state_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/domain/entity/business_entity.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/business_directory_cubit/business_directory_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/state_selector_cubit/state_selector_cubit.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/utils/business_form_validators.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/profile_picture_selector.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/select_time_widget.dart';
import 'package:divyam_flutter/ui/moleclues/custom_check_box_tile.dart';
import 'package:divyam_flutter/ui/moleclues/custom_drop_down.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessFormStepOne extends StatefulWidget {
  final StateSelectorCubit stateSelectorCubit;
  final BusinessDirectoryCubit businessDirectoryCubit;
  const BusinessFormStepOne(
      {super.key,
      required this.stateSelectorCubit,
      required this.businessDirectoryCubit});

  @override
  State<BusinessFormStepOne> createState() => _BusinessFormStepOneState();
}

class _BusinessFormStepOneState extends State<BusinessFormStepOne> {
  bool isMetroCity = false;

  late TextEditingController _stateTC,
      _cityTC,
      _talukaTC,
      _businessNameTC,
      _mobileTC,
      _emailTC,
      _contactPersonTC,
      _websiteUrlTC,
      _whatsappNumberTC,
      _registeredAddressTC,
      _pinCodeTC,
      _googleMapLinkTC;

  @override
  void initState() {
    super.initState();
    _stateTC = TextEditingController();
    _cityTC = TextEditingController();
    _businessNameTC = TextEditingController();
    _mobileTC = TextEditingController();
    _emailTC = TextEditingController();
    _contactPersonTC = TextEditingController();
    _websiteUrlTC = TextEditingController();
    _whatsappNumberTC = TextEditingController();
    _registeredAddressTC = TextEditingController();
    _pinCodeTC = TextEditingController();
    _talukaTC = TextEditingController();
    _googleMapLinkTC = TextEditingController();
    if (!widget.businessDirectoryCubit.formType.isAdd) {
      BusinessEntity entity = widget.businessDirectoryCubit.businessEntity;
      StateModel stateModel = widget.stateSelectorCubit.allStates.firstWhere(
        (element) => element.name == entity.stateName,
      );
      District district = stateModel.districts.firstWhere(
        (element) => element.name == entity.districtName,
      );
      Taluka taluka = district.talukas.firstWhere(
        (element) => element.name == entity.talukaName,
      );

      widget.stateSelectorCubit.filterStates(stateModel);
      widget.stateSelectorCubit.selectDistrict(district);
      widget.stateSelectorCubit.selectTaluka(taluka);
      _stateTC.text = entity.stateValue ?? '';
      _cityTC.text =
          entity.metroCity; // Assuming 'city' is represented by 'metroCity'
      _talukaTC.text = entity.talukaValue ?? '';
      _businessNameTC.text = entity.name;
      _mobileTC.text = entity.mobile;
      _emailTC.text = entity.email;
      _contactPersonTC.text = entity.contactPerson;
      _websiteUrlTC.text = entity.websiteUrl;
      _whatsappNumberTC.text = entity.whatsappNumber ?? '';
      _registeredAddressTC.text = entity.registeredAddress;
      _pinCodeTC.text = entity.pinCode;
      _googleMapLinkTC.text = entity.googleMapLink;
    } else {
      widget.stateSelectorCubit.resetSelections();
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.stateSelectorCubit.getStates();
    });
  }

  @override
  void dispose() {
    _stateTC.dispose();
    _cityTC.dispose();
    _businessNameTC.dispose();
    _mobileTC.dispose();
    _emailTC.dispose();
    _contactPersonTC.dispose();
    _websiteUrlTC.dispose();
    _whatsappNumberTC.dispose();
    _registeredAddressTC.dispose();
    _pinCodeTC.dispose();
    _googleMapLinkTC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextField(
          hintText: 'Name of Business',
          onChanged: (val) => widget.businessDirectoryCubit.nameChanged(val),
          controller: _businessNameTC,
          validator: (val) => BusinessFormValidator.validateName(
              widget.businessDirectoryCubit.businessEntity.name),
        ),
        CustomSpacers.height20,
        ProfilePicViewerOrSelectorWidget(
          networkUrl: widget.businessDirectoryCubit.businessEntity.logoImage,
          onChanged: (file) {
            if (file != null) {
              widget.businessDirectoryCubit.logoImageChanged(file);
            }
          },
          label: 'Upload logo image Ideal resolution ',
          changeImageText: 'Change logo image',
        ),
        CustomSpacers.height20,
        CustomTextField(
          onChanged: (val) => widget.businessDirectoryCubit.mobileChanged(val),
          validator: (val) => BusinessFormValidator.validateMobile(
              widget.businessDirectoryCubit.businessEntity.mobile),
          hintText: 'Mobile',
          controller: _mobileTC,
          maxLength: 10,
          keyboardType: TextInputType.number,
        ),
        CustomSpacers.height20,
        CustomTextField(
          onChanged: (val) => widget.businessDirectoryCubit.emailChanged(val),
          validator: (val) => BusinessFormValidator.validateEmail(
              widget.businessDirectoryCubit.businessEntity.email),
          hintText: 'Email',
          controller: _emailTC,
        ),
        CustomSpacers.height20,
        CustomTextField(
          onChanged: (val) =>
              widget.businessDirectoryCubit.contactPersonChanged(val),
          hintText: 'Contact person',
          controller: _contactPersonTC,
          validator: (val) => BusinessFormValidator.validateContactPerson(
              widget.businessDirectoryCubit.businessEntity.contactPerson),
        ),
        CustomSpacers.height20,
        CustomTextField(
          onChanged: (val) =>
              widget.businessDirectoryCubit.websiteUrlChanged(val),
          hintText: 'Website URL (optional)',
          controller: _websiteUrlTC,
        ),
        CustomSpacers.height20,
        CustomTextField(
          onChanged: (val) =>
              widget.businessDirectoryCubit.whatsappNumberChanged(val),
          validator: (val) => BusinessFormValidator.validateWhatsappNumber(val),
          hintText: 'WhatsApp number (optional)',
          controller: _whatsappNumberTC,
          maxLength: 10,
          keyboardType: TextInputType.number,
        ),
        CustomSpacers.height20,
        _buildStateDropDown(),
        CustomSpacers.height20,
        CustomTextField(
          onChanged: (val) =>
              widget.businessDirectoryCubit.registeredAddressChanged(val),
          maxLines: 5,
          hintText: 'Registered address',
          validator: (val) => BusinessFormValidator.validateRegisteredAddress(
              widget.businessDirectoryCubit.businessEntity.registeredAddress ??
                  ''),
          controller: _registeredAddressTC,
        ),
        CustomSpacers.height20,
        CustomTextField(
          onChanged: (val) => widget.businessDirectoryCubit.pinCodeChanged(val),
          hintText: 'Pincode',
          keyboardType: TextInputType.number,
          validator: (val) => BusinessFormValidator.validatePinCode(
              widget.businessDirectoryCubit.businessEntity.pinCode),
          controller: _pinCodeTC,
          maxLength: 6,
        ),
        CustomSpacers.height20,
        CustomTextField(
          onChanged: (val) =>
              widget.businessDirectoryCubit.googleMapLinkChanged(val),
          hintText: 'Google Map link',
          controller: _googleMapLinkTC,
        ),
        CustomSpacers.height20,
        SelectTimeWidget(
          openingTime: widget.businessDirectoryCubit.businessEntity.openingTime,
          closingTime: widget.businessDirectoryCubit.businessEntity.closingTime,
          onClosingTimeChanged: (closingTime) => closingTime != null
              ? widget.businessDirectoryCubit.closingTimeChanged(closingTime)
              : null,
          onOpeningTimeChanged: (openningTime) => openningTime != null
              ? widget.businessDirectoryCubit.openingTimeChanged(openningTime)
              : null,
        ),
      ],
    );
  }

  Widget _buildStateDropDown() {
    return BlocBuilder<StateSelectorCubit, StateSelectorState>(
      bloc: widget.stateSelectorCubit,
      builder: (context, state) {
        return Column(
          children: [
            CustomDropDown(
              groupValue: widget.stateSelectorCubit.selectedState?.name,
              onChanged: (idx) {
                widget.stateSelectorCubit
                    .filterStates(widget.stateSelectorCubit.allStates[idx!]);
                widget.businessDirectoryCubit
                    .stateChanged(widget.stateSelectorCubit.allStates[idx]);
              },
              hintText: 'State',
              options: widget.stateSelectorCubit.allStates
                  .map((e) => e.name)
                  .toList(),
              controller: _stateTC,
              validator: (value) => BusinessFormValidator.validateState(value),
            ),
            CustomSpacers.height20,
            CustomCheckBoxTile(
              option: 'Business is located in a metro city',
              onChanged: (v) {
                widget.stateSelectorCubit.filterDistricts(v);
              },
            ),
            CustomSpacers.height20,
            Visibility(
              visible:
                  (widget.stateSelectorCubit.selectedState?.districts != null &&
                          widget.stateSelectorCubit.selectedState!.districts
                              .isNotEmpty) ||
                      widget.businessDirectoryCubit.businessEntity.district
                          .isNotEmpty,
              child: CustomDropDown(
                groupValue: widget.stateSelectorCubit.selectedDistrict?.name,
                onChanged: (idx) {
                  widget.stateSelectorCubit.selectDistrict(
                    widget.stateSelectorCubit.selectedState!.districts[idx!],
                  );
                  widget.businessDirectoryCubit.districtChanged(
                      widget.stateSelectorCubit.selectedState!.districts[idx]);
                },
                hintText: 'District / Metro city',
                options: widget.stateSelectorCubit.selectedState?.districts
                        .map((e) => e.name)
                        .toList() ??
                    [],
                controller: _cityTC,
                validator: (value) =>
                    BusinessFormValidator.validateDistrict(value),
              ),
            ),
            CustomSpacers.height20,
            Visibility(
              visible: (widget.stateSelectorCubit.selectedDistrict != null &&
                      widget.stateSelectorCubit.selectedDistrict!.talukas
                          .isNotEmpty) ||
                  widget
                      .businessDirectoryCubit.businessEntity.taluka.isNotEmpty,
              child: CustomDropDown(
                groupValue: widget.stateSelectorCubit.selectedTaluka?.name,
                onChanged: (idx) {
                  widget.stateSelectorCubit.selectTaluka(
                    widget.stateSelectorCubit.selectedDistrict!.talukas[idx!],
                  );
                  widget.businessDirectoryCubit.talukaChanged(
                      widget.stateSelectorCubit.selectedDistrict!.talukas[idx]);
                },
                hintText: 'Taluka / Area',
                options: widget.stateSelectorCubit.selectedDistrict?.talukas
                        .map((e) => e.name)
                        .toList() ??
                    ['Taluka / Area'],
                controller: _talukaTC,
                validator: (value) =>
                    BusinessFormValidator.validateTaluka(value),
              ),
            ),
          ],
        );
      },
    );
  }
}
