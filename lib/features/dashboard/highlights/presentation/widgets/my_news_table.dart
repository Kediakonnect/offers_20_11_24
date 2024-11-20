import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:flutter/material.dart';

class MyNewsTable extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> rows;
  const MyNewsTable({super.key, required this.headers, required this.rows});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Table(
        defaultColumnWidth: const IntrinsicColumnWidth(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(
          color: Colors.black,
          style: BorderStyle.solid,
          borderRadius: BorderRadius.circular(10),
          width: 1,
        ),
        children: [
          _buildTableHeader(headers, context),
          for (List<String> row in rows) _buildTableRow(row, context),
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
            color: Colors.black,
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
}
