import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/custom_check_box_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TreeNode {
  String label;
  String id;
  bool isChecked;
  List<TreeNode> children;
  bool isExpanded;
  int? userCount;
  int? offerRate;

  TreeNode({
    required this.label,
    required this.id,
    this.isChecked = false,
    this.children = const [],
    this.isExpanded = false,
    this.userCount,
    this.offerRate,
  });
}

class CheckboxTreeWidget extends StatefulWidget {
  final List<TreeNode> nodes;
  final Function(TreeNode) onNodeCheckChanged;

  const CheckboxTreeWidget({
    super.key,
    required this.nodes,
    required this.onNodeCheckChanged,
  });

  @override
  _CheckboxTreeWidgetState createState() => _CheckboxTreeWidgetState();
}

class _CheckboxTreeWidgetState extends State<CheckboxTreeWidget> {
  @override
  void initState() {
    super.initState();
  }

  void _onNodeCheckChanged(TreeNode node, bool? isChecked) {
    setState(() {
      node.isChecked = isChecked ?? false;
      _updateChildrenCheckState(node, node.isChecked);
      _updateParentCheckState(node);
    });

    widget.onNodeCheckChanged(node);
  }

  void _updateChildrenCheckState(TreeNode node, bool isChecked) {
    for (var child in node.children) {
      child.isChecked = isChecked;
      _updateChildrenCheckState(child, isChecked);
    }
  }

  void _updateParentCheckState(TreeNode node) {
    bool allChecked = node.children.isNotEmpty &&
        node.children.every((child) => child.isChecked);
    bool anyChecked = node.children.any((child) => child.isChecked);

    if (node.children.isNotEmpty) {
      node.isChecked = allChecked || anyChecked;
    }

    for (var parent in widget.nodes) {
      if (_updateParentBasedOnChildren(parent, node)) {
        _updateParentCheckState(parent);
      }
    }
  }

  bool _updateParentBasedOnChildren(TreeNode parent, TreeNode node) {
    if (parent.children.contains(node)) {
      parent.isChecked = parent.children.any((child) => child.isChecked);
      return true;
    }
    for (var child in parent.children) {
      if (_updateParentBasedOnChildren(child, node)) {
        parent.isChecked = parent.children.any((child) => child.isChecked);
        return true;
      }
    }
    return false;
  }

  void _toggleNodeExpansion(TreeNode node) {
    setState(() {
      node.isExpanded = !node.isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: widget.nodes.map((node) => _buildTreeNode(node)).toList(),
    );
  }

  Widget _buildTreeNode(TreeNode node, {double paddingLeft = 0}) {
    return Padding(
      padding: EdgeInsets.only(left: paddingLeft),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _toggleNodeExpansion(node),
            child: Row(
              children: [
                SizedBox(
                  width: 30.w,
                  height: 30.h,
                  child: CustomCheckBoxTile(
                    value: node.isChecked,
                    onChanged: (isChecked) =>
                        _onNodeCheckChanged(node, isChecked),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            node.label,
                            style: AppTextThemes.theme(context).titleLarge,
                          ),
                        ),
                        CustomSpacers.width10,
                        if (node.userCount != null)
                          Expanded(
                            child: Text(
                              '(${node.userCount}, ₹${node.offerRate})',
                              style: AppTextThemes.theme(context)
                                  .titleLarge!
                                  .copyWith(
                                    color: ColorPalette.textPlaceholder,
                                  ),
                            ),
                          ),
                      ],
                    ),
                    trailing: node.children.isNotEmpty
                        ? ExpandIcon(
                            isExpanded: node.isExpanded,
                            onPressed: (_) => _toggleNodeExpansion(node),
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) => ClipRect(
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0.0,
                child: child,
              ),
            ),
            child: node.isExpanded
                ? Column(
                    key: ValueKey(node.isExpanded),
                    children: node.children
                        .map((child) => _buildTreeNode(
                              child,
                              paddingLeft: paddingLeft + 7.0,
                            ))
                        .toList(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
