import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/core/utils/get-final-string.dart';
import 'package:divyam_flutter/features/authentication/presentation/utils/register_form_validators.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/state_selector_cubit/state_selector_cubit.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
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

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late StateSelectorCubit _stateSelectorCubit;
  late TextEditingController _firstNameTC,
      _lastNameTC,
      _dateOfBirthTC,
      _sexTC,
      _stateTC,
      _cityTC,
      _areaTC,
      _pinTC;

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

  void _onSubmit() {}

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dateOfBirthTC.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        appBarTitle: "EDIT PROFILE",
        height: MediaQuery.of(context).size.height,
        enableMenu: true,
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
        padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 20.h),
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
              GestureDetector(
                onTap: () => _selectDate(context), // Call the date picker
                child: AbsorbPointer(
                  child: CustomTextField(
                    hintText: 'Date of Birth',
                    controller: _dateOfBirthTC,
                    keyboardType: TextInputType.datetime,
                    validator: (v) =>
                        RegisterFormValidators.validateDateOfBirth(v),
                  ),
                ),
              ),
              CustomSpacers.height20,
              CustomDropDown(
                hintText: "Sex",
                options: const ["Male", "Female"],
                controller: _sexTC,
                width: double.infinity,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your sex';
                  }
                  return null;
                },
              ),
              CustomSpacers.height20,
              _buildStateDropDown(),
              CustomSpacers.height20,
              CustomTextField(
                hintText: 'PIN code',
                maxLength: 6,
                controller: _pinTC,
                keyboardType: TextInputType.number,
                validator: (v) => RegisterFormValidators.validatePinCode(v),
              ),
              CustomSpacers.height20,
              CustomTextField(
                hintText: 'Secondary Phone Number',
                maxLength: 10,
                controller: _pinTC,
                keyboardType: TextInputType.phone,
              ),
              CustomSpacers.height20,
              CustomTextField(
                hintText: 'Email',
                controller: _pinTC,
                keyboardType: TextInputType.emailAddress,
              ),
              CustomSpacers.height20,
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
