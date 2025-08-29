// add_table_page.dart
import 'package:demo_app/app/data/models/models.dart';
import 'package:demo_app/app/modules/home/tab_controller.dart';
import 'package:flutter/material.dart' hide TabController;
import 'package:get/get.dart';

class AddTablePage extends StatefulWidget {
  const AddTablePage({super.key, required this.tabName});
  final String tabName;

  @override
  // ignore: library_private_types_in_public_api
  _AddTablePageState createState() => _AddTablePageState();
}

class _AddTablePageState extends State<AddTablePage> {
  final AppTabController tabController = Get.find();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController tableNameController = TextEditingController();
  final TextEditingController dataKeyController = TextEditingController();
  final TextEditingController addButtonLabelController =
      TextEditingController(text: 'Add Entry');
  final RxList<TableColumn> tableColumns = <TableColumn>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Custom Table'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTableConfiguration(),
              const SizedBox(height: 24),
              _buildAddButtonLabel(),
              const SizedBox(height: 24),
              _buildTableFields(),
              const SizedBox(height: 32),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableConfiguration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Table Configuration',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: tableNameController,
          decoration: const InputDecoration(
            labelText: 'Table Name',
            hintText: 'e.g., Employee Skills, Project History',
            border: OutlineInputBorder(),
          ),
          validator: (value) =>
              value?.isEmpty ?? true ? 'Table name is required' : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: dataKeyController,
          decoration: const InputDecoration(
            labelText: 'Data Key',
            hintText: 'e.g., skillsEntries, projectEntries',
            border: OutlineInputBorder(),
          ),
          validator: (value) =>
              value?.isEmpty ?? true ? 'Data key is required' : null,
        ),
        const SizedBox(height: 8),
        const Text(
          'Unique identifier for storing table data',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildAddButtonLabel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Button Label',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: addButtonLabelController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildTableFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Table Fields',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Obx(() => Column(
              children: tableColumns
                  .asMap()
                  .entries
                  .map((entry) => _buildTableFieldItem(entry.key, entry.value))
                  .toList(),
            )),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: _addTableField,
          icon: const Icon(Icons.add),
          label: const Text('Add Field'),
        ),
      ],
    );
  }

  Widget _buildTableFieldItem(int index, TableColumn column) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Field ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => tableColumns.removeAt(index),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: column.name,
              decoration: const InputDecoration(
                labelText: 'Field Label',
                hintText: 'e.g., Skill Name, Project Title',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                tableColumns[index] =
                    tableColumns[index].copyWith(columnName: value);
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: column.columnKey,
              decoration: const InputDecoration(
                labelText: 'Field Key',
                hintText: 'e.g., skillName, projectTitle',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // tableColumns[index] =
                //     tableColumns[index].copyWith(columnKey: value);
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: column.dataType,
                    decoration: const InputDecoration(
                      labelText: 'Field Type',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'text', child: Text('Text')),
                      DropdownMenuItem(value: 'number', child: Text('Number')),
                      DropdownMenuItem(value: 'date', child: Text('Date')),
                    ],
                    onChanged: (value) {
                      tableColumns[index] =
                          tableColumns[index].copyWith(dataType: value!);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: 'default',
                    decoration: const InputDecoration(
                      labelText: 'Display Format',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 'default', child: Text('Default')),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: _addTable,
          child: const Text('Add Table'),
        ),
      ],
    );
  }

  void _addTableField() {
    tableColumns.add(TableColumn(
      name: '',
      columnKey: '',
      dataType: 'text',
    ));
  }

  void _addTable() {
    if (_formKey.currentState!.validate() && tableColumns.isNotEmpty) {
      tabController.addCustomTable(
        tabName: widget.tabName,
        tableName: tableNameController.text,
        dataKey: dataKeyController.text,
        columns: tableColumns.toList(),
        addButtonLabel: addButtonLabelController.text,
      );
      Get.back();
    }
  }
}
