import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SalesHistoryScreen extends StatelessWidget {
  const SalesHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'Sales History'.toUpperCase(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: NeuroMorphicContainer(
          padding: const EdgeInsets.all(0),
          child: Container(
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
                        "25-12-2023 to 31-12-2023",
                        style: AppTextThemes.lightTextTheme.headlineLarge,
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 1,
                                color: ColorPalette.grey,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(2),
                                  1: FlexColumnWidth(1),
                                },
                                border: const TableBorder(
                                  horizontalInside: BorderSide(
                                      color: ColorPalette.grey, width: 1),
                                  verticalInside: BorderSide(
                                      color: ColorPalette.grey, width: 1),
                                ),
                                children: [
                                  _buildRow('Digital Boost Solutions',
                                      '₹ 3,500', true),
                                  _buildRow('Infinite Impressions Marketing',
                                      '₹ 5,250', true),
                                  _buildRow('Epic Exposure Enterprises',
                                      '₹ 3,500', true),
                                  _buildRow('Total', '₹ 12,250', false,
                                      isBold: true),
                                ],
                              ),
                            ),
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
                        "25-12-2023 to 31-12-2023",
                        style: AppTextThemes.lightTextTheme.headlineLarge,
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 1,
                                color: ColorPalette.grey,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(2),
                                  1: FlexColumnWidth(1),
                                },
                                border: const TableBorder(
                                  horizontalInside: BorderSide(
                                      color: ColorPalette.grey, width: 1),
                                  verticalInside: BorderSide(
                                      color: ColorPalette.grey, width: 1),
                                ),
                                children: [
                                  _buildRow('Digital Boost Solutions',
                                      '₹ 3,500', true),
                                  _buildRow('Infinite Impressions Marketing',
                                      '₹ 5,250', true),
                                  _buildRow('Epic Exposure Enterprises',
                                      '₹ 3,500', true),
                                  _buildRow('Total', '₹ 12,250', false,
                                      isBold: true),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    child: ExpansionTile(
                      dense: true,
                      childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                      title: Text(
                        "25-12-2023 to 31-12-2023",
                        style: AppTextThemes.lightTextTheme.headlineLarge,
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 1,
                                color: ColorPalette.grey,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(2),
                                  1: FlexColumnWidth(1),
                                },
                                border: const TableBorder(
                                  horizontalInside: BorderSide(
                                      color: ColorPalette.grey, width: 1),
                                  verticalInside: BorderSide(
                                      color: ColorPalette.grey, width: 1),
                                ),
                                children: [
                                  _buildRow('Digital Boost Solutions',
                                      '₹ 3,500', true),
                                  _buildRow('Infinite Impressions Marketing',
                                      '₹ 5,250', true),
                                  _buildRow('Epic Exposure Enterprises',
                                      '₹ 3,500', true),
                                  _buildRow('Total', '₹ 12,250', false,
                                      isBold: true),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TableRow _buildRow(String description, String amount, bool isDataRow,
      {bool isBold = false}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            description,
            style: AppTextThemes.lightTextTheme.bodyMedium!.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color:
                  isDataRow ? ColorPalette.primaryColor : ColorPalette.textDark,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            amount,
            textAlign: TextAlign.right,
            style: AppTextThemes.lightTextTheme.bodyMedium!.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
