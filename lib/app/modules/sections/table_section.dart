import 'package:demo_app/app/modules/home/tabWidgetController.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/app/data/models/models.dart';
import 'package:get/get.dart';

class TableSection extends StatelessWidget {
  final Section section;
  final TabControllerX controller;

  static TabControllerX? _findController(BuildContext context) {
    try {
      return context
          .findAncestorWidgetOfExactType<GetBuilder<TabControllerX>>()
          ?.init;
    } catch (_) {
      return null;
    }
  }

  const TableSection({
    super.key,
    required this.section,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (section.table == null) {
      return const SizedBox.shrink();
    }

    final table = section.table!;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Add Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _showAddRowDialog(context, table),
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(table.feildEntryButton),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Rows
            if (table.rows.isEmpty)
              const Text("No rows yet. Add a new row above."),
            if (table.rows.isNotEmpty) _DataTableWidget(table: table),
          ],
        ),
      ),
    );
  }

  void _showAddRowDialog(BuildContext context, TableModel table) {
    final Map<String, TextEditingController> controllers = {
      for (var col in table.columns) col.columnKey: TextEditingController(),
    };

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Row '),
        content: SingleChildScrollView(
          child: Column(
            children: table.columns.map((col) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: controllers[col.columnKey],
                  decoration: InputDecoration(
                    labelText: col.name,
                    border: const OutlineInputBorder(),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newRow = <String, dynamic>{};
              for (var col in table.columns) {
                newRow[col.columnKey] = controllers[col.columnKey]?.text ?? '';
              }
              table.rows.add(newRow);
              controller.update(); // refresh UI
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

class _DataTableWidget extends StatelessWidget {
  final TableModel table;

  const _DataTableWidget({required this.table});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          ...table.columns.map((col) => DataColumn(label: Text(col.name))),
          const DataColumn(label: Text("Actions")),
        ],
        rows: table.rows.asMap().entries.map((entry) {
          final index = entry.key;
          final row = entry.value;

          return DataRow(cells: [
            ...table.columns.map((col) {
              final value = row[col.columnKey]?.toString() ?? '';
              return DataCell(Text(value));
            }).toList(),

            // Actions
            DataCell(Row(
              children: [
                IconButton(
                  onPressed: () {
                    // TODO: Edit row logic
                  },
                  icon: const Icon(Icons.edit, size: 18),
                ),
                IconButton(
                  onPressed: () {
                    table.rows.removeAt(index);
                    // context is stateless here, so GetX controller updates UI
                    final ctrl = TableSection._findController(context);
                    ctrl?.update();
                  },
                  icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                ),
              ],
            )),
          ]);
        }).toList(),
      ),
    );
  }
}
