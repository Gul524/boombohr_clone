// table_entry_page.dart
import 'package:demo_app/app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableEntryPage extends StatefulWidget {
  final Section section;
  final Function(Map<String, dynamic>) onSave;

  const TableEntryPage({
    Key? key,
    required this.section,
    required this.onSave,
  }) : super(key: key);

  @override
  _TableEntryPageState createState() => _TableEntryPageState();
}

class _TableEntryPageState extends State<TableEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add ${widget.section.sectionName} Entry'),
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
              ..._buildFormFields(),
              const SizedBox(height: 24),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return widget.section.table!.columns.map((column) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: _buildFieldInput(column),
      );
    }).toList();
  }

  Widget _buildFieldInput(TableColumn column) {
    switch (column.dataType) {
      case 'text':
        return TextFormField(
          decoration: InputDecoration(
            labelText: column.name,
            border: const OutlineInputBorder(),
          ),
          onChanged: (value) => _formData[column.columnKey] = value,
        );

      case 'number':
        return TextFormField(
          decoration: InputDecoration(
            labelText: column.name,
            border: const OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) =>
              _formData[column.columnKey] = num.tryParse(value),
        );

      case 'date':
        return TextFormField(
          decoration: InputDecoration(
            labelText: column.name,
            border: const OutlineInputBorder(),
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          onTap: () => _selectDate(column),
          readOnly: true,
          controller: TextEditingController(
              text: _formData[column.columnKey]?.toString()),
        );

      case 'datetime':
        return TextFormField(
          decoration: InputDecoration(
            labelText: column.name,
            border: const OutlineInputBorder(),
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          onTap: () => _selectDateTime(column),
          readOnly: true,
          controller: TextEditingController(
              text: _formData[column.columnKey]?.toString()),
        );

      default:
        return TextFormField(
          decoration: InputDecoration(
            labelText: column.name,
            border: const OutlineInputBorder(),
          ),
          onChanged: (value) => _formData[column.columnKey] = value,
        );
    }
  }

  Future<void> _selectDate(TableColumn column) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _formData[column.columnKey] = picked;
      });
    }
  }

  Future<void> _selectDateTime(TableColumn column) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _formData[column.columnKey] = fullDateTime;
        });
      }
    }
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
          onPressed: _saveEntry,
          child: const Text('Add Entry'),
        ),
      ],
    );
  }

  void _saveEntry() {
    if (_formKey.currentState!.validate()) {
      widget.onSave(_formData);
      Get.back();
    }
  }
}
