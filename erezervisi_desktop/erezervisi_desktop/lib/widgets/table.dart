import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> items;

  CustomTable({required this.headers, required this.items});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: headers.map((header) => DataColumn(label: Text(header))).toList(),
        rows: items.map((item) {
          return DataRow(
            cells: item.map((cell) => DataCell(Text(cell))).toList(),
          );
        }).toList(),
      ),
    );
  }
}
