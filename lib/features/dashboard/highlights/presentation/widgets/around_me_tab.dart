import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:flutter/material.dart';

class AroundMeTab extends StatefulWidget {
  const AroundMeTab({super.key});

  @override
  State<AroundMeTab> createState() => _AroundMeTabState();
}

class _AroundMeTabState extends State<AroundMeTab> {
  @override
  Widget build(BuildContext context) {
    return NeuroMorphicContainer(
      padding: const EdgeInsets.all(7),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorPalette.primaryColor,
            width: 2,
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            expansionTileTheme: const ExpansionTileThemeData(
              backgroundColor: Colors.transparent,
              collapsedBackgroundColor: Colors.transparent,
              tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
              childrenPadding: EdgeInsets.all(16.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ColorPalette.textDark,
                      width: 1,
                    ),
                  ),
                ),
                child: ExpansionTile(
                  dense: true,
                  childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                  title: Text(
                    "Ad Designers".toUpperCase(),
                    style: AppTextThemes.lightTextTheme.headlineLarge,
                  ),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Add me to this list",
                            textAlign: TextAlign.start,
                            style: AppTextThemes.lightTextTheme.headlineLarge!
                                .copyWith(
                              color: ColorPalette.primaryColor,
                            ),
                          ),
                          CustomSpacers.height10,
                          Text(
                            "1. Rahul Sharma - 9876543210",
                            style: AppTextThemes.lightTextTheme.bodyLarge,
                          ),
                          Text(
                            "2. Rahul Sharma - 9876543210",
                            style: AppTextThemes.lightTextTheme.bodyLarge,
                          ),
                          Text(
                            "3. Rahul Sharma - 9876543210",
                            style: AppTextThemes.lightTextTheme.bodyLarge,
                          ),
                          Text(
                            "4. Rahul Sharma - 9876543210",
                            style: AppTextThemes.lightTextTheme.bodyLarge,
                          ),
                          Text(
                            "5. Rahul Sharma - 9876543210",
                            style: AppTextThemes.lightTextTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ColorPalette.textDark,
                      width: 1,
                    ),
                  ),
                ),
                child: ExpansionTile(
                  dense: true,
                  childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                  title: Text(
                    "blood donors".toUpperCase(),
                    style: AppTextThemes.lightTextTheme.headlineLarge,
                  ),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Add me to this list",
                            textAlign: TextAlign.start,
                            style: AppTextThemes.lightTextTheme.headlineLarge!
                                .copyWith(
                              color: ColorPalette.primaryColor,
                            ),
                          ),
                          CustomSpacers.height10,
                          Text(
                            "1. Rahul Sharma - 9876543210",
                            style: AppTextThemes.lightTextTheme.bodyLarge,
                          ),
                          Text(
                            "2. Rahul Sharma - 9876543210",
                            style: AppTextThemes.lightTextTheme.bodyLarge,
                          ),
                          Text(
                            "3. Rahul Sharma - 9876543210",
                            style: AppTextThemes.lightTextTheme.bodyLarge,
                          ),
                          Text(
                            "4. Rahul Sharma - 9876543210",
                            style: AppTextThemes.lightTextTheme.bodyLarge,
                          ),
                          Text(
                            "5. Rahul Sharma - 9876543210",
                            style: AppTextThemes.lightTextTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide.none,
                  ),
                ),
                child: ExpansionTile(
                  dense: true,
                  childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                  title: Text(
                    "snake catchers".toUpperCase(),
                    style: AppTextThemes.lightTextTheme.headlineLarge,
                  ),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Add me to this list",
                            textAlign: TextAlign.start,
                            style: AppTextThemes.lightTextTheme.headlineLarge!
                                .copyWith(
                              color: ColorPalette.primaryColor,
                            ),
                          ),
                          CustomSpacers.height10,
                          Text(
                            "1. Rahul Sharma - 9876543210",
                            style: AppTextThemes.lightTextTheme.bodyLarge,
                          ),
                          Text(
                            "2. Rahul Sharma - 9876543210",
                            style: AppTextThemes.lightTextTheme.bodyLarge,
                          ),
                          Text(
                            "3. Rahul Sharma - 9876543210",
                            style: AppTextThemes.lightTextTheme.bodyLarge,
                          ),
                          Text(
                            "4. Rahul Sharma - 9876543210",
                            style: AppTextThemes.lightTextTheme.bodyLarge,
                          ),
                          Text(
                            "5. Rahul Sharma - 9876543210",
                            style: AppTextThemes.lightTextTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
