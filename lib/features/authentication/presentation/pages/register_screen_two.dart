import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/core/utils/get-final-string.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/register_screen_three_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/register_screen_two_entity.dart';
import 'package:divyam_flutter/features/authentication/presentation/utils/register_form_validators.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/state_selector_cubit/state_selector_cubit.dart';
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
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class RegisterScreenTwo extends StatefulWidget {
  final RegisterScreenTwoEntity registerScreenTwoEntity;

  const RegisterScreenTwo({
    super.key,
    required this.registerScreenTwoEntity,
  });

  @override
  State<RegisterScreenTwo> createState() => _RegisterScreenTwoState();
}

class _RegisterScreenTwoState extends State<RegisterScreenTwo> {
  late StateSelectorCubit _stateSelectorCubit;
  late TextEditingController _firstNameTC,
      _lastNameTC,
      _dateOfBirthTC,
      _sexTC,
      _stateTC,
      _cityTC,
      _areaTC,
      _pinTC;

  String? _ageError;

  @override
  void initState() {
    super.initState();
    _stateSelectorCubit = sl<StateSelectorCubit>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _stateSelectorCubit.getStates();
    });
    _firstNameTC = TextEditingController();
    _lastNameTC = TextEditingController();
    _dateOfBirthTC = TextEditingController();
    _sexTC = TextEditingController();
    _stateTC = TextEditingController();
    _cityTC = TextEditingController();
    _areaTC = TextEditingController();
    _pinTC = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameTC.dispose();
    _lastNameTC.dispose();
    _dateOfBirthTC.dispose();
    _sexTC.dispose();
    _stateTC.dispose();
    _cityTC.dispose();
    _areaTC.dispose();
    _pinTC.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      CustomNavigator.pushTo(
        context,
        AppRouter.registerScreenThree,
        arguments: RegisterScreenThreeEntity(
          firstName: _firstNameTC.text,
          lastName: _lastNameTC.text,
          dob: _dateOfBirthTC.text,
          sex: _sexTC.text,
          state: _stateSelectorCubit.selectedState?.name ?? "",
          area: _stateSelectorCubit.selectedTaluka?.name,
          district: _stateSelectorCubit.selectedDistrict?.name,
          // pinCode: _pinTC.text,
          isMetroCity: true,
          phoneNumber: widget.registerScreenTwoEntity.mobileNumber,
          referralCode: widget.registerScreenTwoEntity.referralCode,
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: ColorPalette.primaryColor, // Header background color
            colorScheme: const ColorScheme.light(
              primary: ColorPalette.primaryColor, // Header text color
            ),
            dialogBackgroundColor:
                Colors.white, // Background color of the dialog
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      // Calculate the age based on the selected date
      int age = DateTime.now().year - pickedDate.year;
      if (DateTime.now().month < pickedDate.month ||
          (DateTime.now().month == pickedDate.month &&
              DateTime.now().day < pickedDate.day)) {
        age--;
      }

      // Check if the age is below 18
      if (age < 18) {
        setState(() {
          _ageError =
              'You agree that Below 18 years of age user can have access to limited pages of our app as "View only" rights with your parents consent.';
          _dateOfBirthTC.clear(); // Optionally clear the TextField
        });
        _dateOfBirthTC.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      } else {
        setState(() {
          _ageError = null;
          // Format the date to DD/MM/YYYY before setting it in the TextField
          _dateOfBirthTC.text = DateFormat('dd-MM-yyyy').format(pickedDate);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        appBarTitle: "REGISTER 2/3",
        height: MediaQuery.of(context).size.height,
        enableMenu: false,
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
      ),
    );
  }

  Widget _buildBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: FigmaValueConstants.defaultPaddingH.w, vertical: 20.h),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomSpacers.height20,
              CustomTextField(
                hintText: 'First Name',
                controller: _firstNameTC,
                keyboardType: TextInputType.text,
                validator: (v) => RegisterFormValidators.validateName(v),
              ),
              CustomSpacers.height20,
              CustomTextField(
                hintText: 'Last Name',
                controller: _lastNameTC,
                keyboardType: TextInputType.text,
                validator: (v) => RegisterFormValidators.validateName(v),
              ),
              CustomSpacers.height20,
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _selectDate(context), // Call the date picker
                    child: AbsorbPointer(
                      child: CustomTextField(
                        hintText: 'Date of Birth',
                        controller: _dateOfBirthTC,
                        keyboardType: TextInputType.datetime,
                        validator: (v) =>
                            RegisterFormValidators.validateDateOfBirth(
                          _dateOfBirthTC.text,
                        ),
                      ),
                    ),
                  ),
                  if (_ageError != null)
                    Text(
                      _ageError!,
                      style: AppTextThemes.theme(context).bodySmall!.copyWith(
                            color: ColorPalette.primaryColor,
                          ),
                    )
                ],
              ),
              CustomSpacers.height20,
              CustomDropDown(
                hintText: "Sex",
                options: const ["Male", "Female"],
                controller: _sexTC,
                width: double.maxFinite,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your sex';
                  }
                  return null;
                },
              ),
              CustomSpacers.height20,
              _buildStateDropDown(),
              // CustomSpacers.height20,
              // CustomTextField(
              //   hintText: 'PIN code',
              //   maxLength: 6,
              //   controller: _pinTC,
              //   keyboardType: TextInputType.number,
              //   validator: (v) => RegisterFormValidators.validatePinCode(v),
              // ),
              CustomSpacers.height30,
              CustomButton(
                onPressed: _onSubmit,
                btnText: getFinalLabel("Next"),
                height: 50,
                width: double.infinity,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildStateDropDown() {
    return BlocBuilder<StateSelectorCubit, StateSelectorState>(
      bloc: _stateSelectorCubit,
      builder: (context, state) {
        return Column(
          children: [
            CustomDropDown(
              groupValue: _stateSelectorCubit.selectedState?.name ?? "",
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please select your state';
                }
                return null;
              },
              width: double.infinity,
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
              onChanged: (option) {
                _stateSelectorCubit.filterDistricts(option);
              },
              option: "I live in metro city",
            ),
            if (_stateSelectorCubit.selectedState != null) ...[
              CustomSpacers.height20,
              CustomDropDown(
                  groupValue: _stateSelectorCubit.selectedDistrict?.name ?? "",
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
                  options: _stateSelectorCubit.selectedState!.districts
                      .map((e) => e.name)
                      .toList(),
                  controller: _cityTC),
            ],
            if (_stateSelectorCubit.selectedDistrict != null &&
                _stateSelectorCubit.selectedDistrict!.talukas.isNotEmpty) ...[
              CustomSpacers.height20,
              CustomDropDown(
                groupValue: _stateSelectorCubit.selectedTaluka?.name ?? "",
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
