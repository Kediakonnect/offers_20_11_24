import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTable extends StatefulWidget {
  final List<double>? headersWidth;
  final List<String> headers;
  final List<List<String>> rows;
  final double? borderRadius, borderThickness;
  final Color? bordercolor;

  const CustomTable(
      {super.key,
      this.headersWidth,
      this.borderThickness,
      this.bordercolor = ColorPalette.primaryColor,
      this.borderRadius,
      required this.headers,
      required this.rows});

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  late List<double> headersWidth;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    headersWidth = widget.headersWidth ??
        List.generate(
            widget.headers.length,
            (index) => calculateTextWidth(widget.headers[index],
                AppTextThemes.theme(context).headlineLarge!));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
        border: widget.borderThickness != null
            ? null
            : Border.all(
                color: widget.bordercolor!,
                width: 1,
              ),
      ),
      width: double.maxFinite,
      child: Table(
        columnWidths: {
          for (int i = 0; i < headersWidth.length; i++)
            i: FixedColumnWidth(headersWidth[i]),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(
          color: widget.bordercolor!,
          style: BorderStyle.solid,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          width: widget.borderThickness ?? 1,
        ),
        children: [
          _buildTableHeader(widget.headers, context),
          for (List<String> row in widget.rows) _buildTableRow(row, context),
        ],
      ),
    );
  }

  TableRow _buildTableRow(List<String> rows, BuildContext context) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: ColorPalette.primaryColor,
          ),
        ),
      ),
      children: rows
          .map(
            (row) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Text(
                  row,
                  maxLines: 1,
                  style: AppTextThemes.theme(context).bodyMedium,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  TableRow _buildTableHeader(List<String> headers, BuildContext context) {
    return TableRow(
      children: headers
          .map(
            (header) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  header,
                  style: AppTextThemes.theme(context).headlineLarge,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  double calculateTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size.width > 80 ? 80 : textPainter.size.width;
  }
}
