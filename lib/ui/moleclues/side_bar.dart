import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/core/utils/side_bar_utils.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SideBar extends StatefulWidget {
  final VoidCallback onMenuTap, onItemTap;
  const SideBar({super.key, required this.onMenuTap, required this.onItemTap});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPalette.primaryDarkColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * .75,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * .75,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSpacers.height26,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MenuButton(
                  icon: Icons.close,
                  onMenuTap: widget.onMenuTap,
                ),
                Image.asset(
                  AppIcons.appLogo2,
                  height: 25.h,
                ),
              ],
            ),
            CustomSpacers.height56,
            _buildOptions(),
          ],
        ),
      ),
    );
  }

  Widget _buildSideBarOption(
      {required String assetName, required String text, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            color: ColorPalette.scaffoldBackgroundColor,
            assetName,
            height: 24.h,
            width: 24.w,
          ),
          CustomSpacers.width10,
          Text(
            text,
            style: AppTextThemes.theme(context).bodyLarge?.copyWith(
                  color: ColorPalette.scaffoldBackgroundColor,
                  fontSize: 16.sp,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptions() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        if (SideBarUtils.sideBarOptions[index].expandedItems!.isEmpty) {
          return _buildSideBarOption(
            assetName: SideBarUtils.sideBarOptions[index].assetName,
            text: SideBarUtils.sideBarOptions[index].title,
            onTap: () {
              if (SideBarUtils.sideBarOptions[index].onItemTap != null) {
                SideBarUtils.sideBarOptions[index].onItemTap!();
              } else if (SideBarUtils
                  .sideBarOptions[index].routeName.isNotEmpty) {
                widget.onItemTap();
                CustomNavigator.pushTo(
                  context,
                  SideBarUtils.sideBarOptions[index].routeName,
                  arguments: SideBarUtils.sideBarOptions[index].arguments,
                );
              }
            },
          );
        } else {
          return _buildExpandedTile(
              options: SideBarUtils.sideBarOptions[index]);
        }
      },
      separatorBuilder: (_, index) =>
          SideBarUtils.sideBarOptions[index].canAddSpacer!
              ? CustomSpacers.height16
              : const SizedBox.shrink(),
      itemCount: SideBarUtils.sideBarOptions.length,
    );
  }

  Widget _buildExpandedTile({required SideBarEntity options}) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        iconColor: ColorPalette.scaffoldBackgroundColor,
        collapsedIconColor: ColorPalette.scaffoldBackgroundColor,
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.only(left: 30.w),
        title: Row(
          children: [
            SvgPicture.asset(
              options.assetName,
              color: ColorPalette.scaffoldBackgroundColor,
              height: 24.h,
              width: 24.w,
            ),
            CustomSpacers.width10,
            GestureDetector(
              onTap: () {
                if (options.routeName.isNotEmpty) {
                  widget.onItemTap();
                  CustomNavigator.pushTo(
                    context,
                    options.routeName,
                  );
                }
              },
              child: Text(
                options.title,
                style: AppTextThemes.theme(context).bodyLarge?.copyWith(
                      color: ColorPalette.scaffoldBackgroundColor,
                      fontSize: 16.sp,
                    ),
              ),
            ),
          ],
        ),
        children: List.generate(
          options.expandedItems!.length,
          (index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (options.expandedItems![index].routeName.isNotEmpty) {
                    widget.onItemTap();
                    CustomNavigator.pushTo(
                      context,
                      options.expandedItems![index].routeName,
                      arguments: options.expandedItems![index].arguments,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    options.expandedItems![index].title,
                    style: AppTextThemes.theme(context).bodyLarge?.copyWith(
                          color: ColorPalette.scaffoldBackgroundColor,
                          fontSize: 16.sp,
                        ),
                  ),
                ),
              ),
              if (index == options.expandedItems!.length - 1)
                CustomSpacers.height16,
            ],
          ),
        ),
      ),
    );
  }
}
