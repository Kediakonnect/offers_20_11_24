import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/state_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/state_selector_cubit/state_selector_cubit.dart';
import 'package:divyam_flutter/ui/atoms/loading.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_check_box_tile.dart';
import 'package:divyam_flutter/ui/moleclues/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class StateFilterWidget extends StatefulWidget {
  final Function(String? id) onItemPressed;
  final StateSelectorCubit stateSelectorCubit;
  final VoidCallback onFilterTap, onResetTap;
  const StateFilterWidget({
    super.key,
    required this.stateSelectorCubit,
    required this.onFilterTap,
    required this.onResetTap,
    required this.onItemPressed,
  });

  @override
  State<StateFilterWidget> createState() => _StateFilterWidgetState();
}

class _StateFilterWidgetState extends State<StateFilterWidget>
    with AutomaticKeepAliveClientMixin {
  late StateSelectorCubit _stateSelectorCubit;
  late TextEditingController _stateTC, _cityTC, _areaTC;

  @override
  void initState() {
    _stateSelectorCubit = widget.stateSelectorCubit;
    _stateTC = TextEditingController();
    _cityTC = TextEditingController();
    _areaTC = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _stateTC.dispose();
    _cityTC.dispose();
    _areaTC.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant StateFilterWidget oldWidget) {
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildStateDropDown();
  }

  Widget _buildStateDropDown() {
    return BlocBuilder<StateSelectorCubit, StateSelectorState>(
      bloc: _stateSelectorCubit,
      builder: (context, state) {
        if (state is StatesLoadingState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: const Loading(),
          );
        }

        if (state is FilterStateSuccessState) {
          return _buildStateSelectorForm(state.state);
        }
        return _buildStateSelectorForm(_stateSelectorCubit.selectedState);
      },
    );
  }

  Widget _buildStateSelectorForm(StateModel? state) {
    return Column(
      children: [
        CustomDropDown(
          groupValue: _stateSelectorCubit.selectedState?.name,
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
          options: _stateSelectorCubit.allStates.map((e) => e.name).toList(),
          controller: _stateTC,
        ),
        CustomSpacers.height20,
        CustomCheckBoxTile(
          onChanged: (option) {
            _stateSelectorCubit.filterDistricts(option);
          },
          option: "I live in metro city",
        ),
        CustomSpacers.height20,
        if (state?.districts != null && state!.districts.isNotEmpty) ...[
          CustomDropDown(
              groupValue: _stateSelectorCubit.selectedDistrict?.name,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please select your District';
                }
                return null;
              },
              onChanged: (idx) {
                _stateSelectorCubit.selectDistrict(
                  state.districts[idx!],
                );
              },
              hintText: 'District / Metro city',
              options: state.districts.map((e) => e.name).toList(),
              controller: _cityTC),
        ],
        if (_stateSelectorCubit.selectedDistrict != null &&
            _stateSelectorCubit.selectedDistrict!.talukas.isNotEmpty) ...[
          CustomSpacers.height20,
          CustomDropDown(
            groupValue: _stateSelectorCubit.selectedTaluka?.name,
            validator: (p0) {
              if (p0 == null || p0.isEmpty) {
                return 'Please select your area';
              }
              return null;
            },
            onChanged: (p0) {
              _stateSelectorCubit.selectTaluka(
                  _stateSelectorCubit.selectedDistrict!.talukas[p0!]);

              widget.onItemPressed(_stateSelectorCubit.selectedTaluka?.id);
            },
            hintText: 'Taluka / Area',
            options: _stateSelectorCubit.selectedDistrict?.talukas
                    .map((e) => e.name)
                    .toList() ??
                ['Taluka'],
            controller: _areaTC,
          ),
          CustomSpacers.height56,
          Visibility(
              visible: _stateSelectorCubit.selectedTaluka != null,
              child: CustomButton(
                  onPressed: widget.onFilterTap, btnText: 'Apply filter')),
          CustomSpacers.height20,
          Visibility(
              visible: _stateSelectorCubit.selectedTaluka != null,
              child: CustomButton(
                  onPressed: widget.onResetTap, btnText: 'Reset filter')),
          CustomSpacers.height56,
        ],
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
