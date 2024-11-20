import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/enums/bottom_navigation_options.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/presentation/widgets/bottom_navigation_item_widget.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/menu_button.dart';
import 'package:divyam_flutter/ui/moleclues/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScaffold extends StatefulWidget {
  final String appBarTitle;
  final Widget? body;
  final bool? enableBottomSheet;
  final bool? enableMenu;
  final Alignment? bodyAlignment;
  final Widget? floatingActionButton;

  final double? height;

  const CustomScaffold({
    super.key,
    this.floatingActionButton,
    this.enableMenu = true,
    this.bodyAlignment,
    this.enableBottomSheet = false,
    required this.appBarTitle,
    this.body,
    this.height,
  });

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _tween;
  bool isExpanded = false;

  @override
  void initState() {
    _controller = AnimationController(
      upperBound: 1,
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _tween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    super.initState();
  }

  _onMenuTap() {
    if (!isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.enableMenu!
        ? _buildAnimatedDashboard()
        : _buildScaffold(isBottomSheetEnabled: false);
  }

  Widget _buildAnimatedDashboard() {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorPalette.primaryDarkColor,
        body: Stack(
          children: [
            SideBar(
              onMenuTap: () => _onMenuTap(),
              onItemTap: () => _onMenuTap(),
            ),
            AnimatedBuilder(
              animation: _tween,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_tween.value * 265, 0),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, .001)
                      ..rotateY((_tween.value * 30) * 3.14 / 180),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(_tween.value * 20),
                        child: child!),
                  ),
                );
              },
              child: _buildScaffold(
                  isBottomSheetEnabled: widget.enableBottomSheet!),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScaffold({bool? isBottomSheetEnabled = false}) {
    Offset offset = const Offset(6, 6);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: widget.floatingActionButton,
        bottomNavigationBar: Visibility(
          visible: isBottomSheetEnabled!,
          child: Container(
            color: ColorPalette.primaryColor,
            margin: EdgeInsets.only(bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: BottomNavigationOptions.values
                  .map((e) => BottomNavigationItem(
                        onTap: () => CustomNavigator.pushReplace(
                          context,
                          e.routeName,
                        ),
                        assetName: e.assetName,
                        text: e.textValue,
                      ))
                  .toList(),
            ),
          ),
        ),
        backgroundColor: ColorPalette.primaryColor,
        appBar: AppBar(
          title: Text(widget.appBarTitle),
          toolbarHeight: 45.h, // Adjust this value to reduce the AppBar height
          actions: [
            Visibility(
              visible: widget.enableMenu!,
              child: MenuButton(
                onMenuTap: () => _onMenuTap(),
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Image.asset(
              AppIcons.appLogo2,
              height: 32.h,
            ),
          ),
        ),
        body: Container(
          alignment: widget.bodyAlignment,
          height: widget.height ?? MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          clipBehavior: Clip.none,
          margin: EdgeInsets.only(bottom: 13.h, top: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: ColorPalette.scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: ColorPalette.shadowOuterDark,
                blurRadius: 6,
                spreadRadius: 0,
                offset: offset,
              ),
              BoxShadow(
                color: ColorPalette.shadowOuterLight,
                blurRadius: 6,
                spreadRadius: 0,
                offset: -offset,
              )
            ],
          ),
          child: widget.body,
        ),
      ),
    );
  }
}
