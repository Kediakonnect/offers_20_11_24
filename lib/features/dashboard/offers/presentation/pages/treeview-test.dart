import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/state_model.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/cubits/state_selector_cubit/state_selector_cubit.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/checkbox_treeview.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TreeViewTestPage extends StatefulWidget {
  const TreeViewTestPage({super.key});

  @override
  State<TreeViewTestPage> createState() => _TreeViewTestPageState();
}

class _TreeViewTestPageState extends State<TreeViewTestPage> {
  late List<TreeNode> nodes;
  late StateSelectorCubit _stateSelectorCubit;

  @override
  void initState() {
    _stateSelectorCubit = sl<StateSelectorCubit>();
    nodes = [];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _stateSelectorCubit.getStates();
    });
    super.initState();
  }

  List<TreeNode> _mapStateModelToTreeNodes(
      List<StateModel> stateModelResponse) {
    return [
      TreeNode(
          label: "All India",
          id: "India",
          children: stateModelResponse.map((state) {
            return TreeNode(
              id: state.id,
              label: state.name,
              children: state.districts.map((district) {
                return TreeNode(
                  id: state.id,
                  label: district.name,
                  children: district.talukas.map((taluka) {
                    return TreeNode(
                      id: state.id,
                      label: taluka.name,
                    );
                  }).toList(),
                );
              }).toList(),
            );
          }).toList()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "TREEVIEW TEST",
      body: _buildStatesSelector(),
    );
  }

  BlocConsumer<StateSelectorCubit, StateSelectorState> _buildStatesSelector() {
    return BlocConsumer<StateSelectorCubit, StateSelectorState>(
      bloc: _stateSelectorCubit,
      listener: (context, state) {
        if (state is StatesFailureState) {
          ScaffoldHelper.showFailureSnackBar(
              context: context, message: state.message);
        }

        setState(() {
          nodes = _mapStateModelToTreeNodes(_stateSelectorCubit.allStates);
        });
      },
      builder: (context, state) {
        if (state is StatesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StatesFailureState) {
          return Center(child: Text('Failed to load states: ${state.message}'));
        } else if (state is FilterStateSuccessState) {
          nodes = _mapStateModelToTreeNodes(_stateSelectorCubit.allStates);
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              CustomSpacers.height21,
              CheckboxTreeWidget(
                nodes: nodes,
                onNodeCheckChanged: _onNodeCheckChanged,
              ),
            ],
          ),
        );
      },
    );
  }

  void _onNodeCheckChanged(TreeNode node) {
    List<Map<String, dynamic>> selectedItems = [];

    for (var stateNode in nodes[0].children) {
      if (stateNode.isChecked) {
        Map<String, dynamic> selectedState = {
          "state": stateNode.id,
          "districts": []
        };

        for (var districtNode in stateNode.children) {
          if (districtNode.isChecked) {
            Map<String, dynamic> selectedDistrict = {
              "id": districtNode.id,
              "taluakas": []
            };

            for (var talukaNode in districtNode.children) {
              if (talukaNode.isChecked) {
                selectedDistrict["taluakas"].add(talukaNode.id);
              }
            }

            selectedState["districts"].add(selectedDistrict);
          }
        }

        selectedItems.add(selectedState);
      }
    }

    print(selectedItems);
  }
}
