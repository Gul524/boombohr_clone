import 'package:demo_app/app/data/models/models.dart';
import 'package:demo_app/app/modules/pages/table_controller.dart';
import 'package:flutter/material.dart';

class AddTablePage extends StatefulWidget {
  final TabModel tabModel;
  final Function(TabModel) onTableAdded;

  const AddTablePage({
    super.key,
    required this.tabModel,
    required this.onTableAdded,
  });

  @override
  _AddTablePageState createState() => _AddTablePageState();
}

class _AddTablePageState extends State<AddTablePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tableTitleController = TextEditingController();
  final TextEditingController _buttonLabelController = TextEditingController();

  final List<TableField> _fields = [];
  final Map<int, TextEditingController> _fieldLabelControllers = {};
  final Map<int, TextEditingController> _fieldKeyControllers = {};
  final Map<int, TextEditingController> _placeholderControllers = {};
  final Map<int, String> _fieldTypes = {};
  final Map<int, String> _displayFormats = {};
  final Map<int, bool> _requiredFields = {};

  @override
  void initState() {
    super.initState();
    _buttonLabelController.text = 'Add Entry';
    // Add one initial field
    _addField();
  }

  @override
  void dispose() {
    _tableTitleController.dispose();
    _buttonLabelController.dispose();

    // Dispose all field controllers
    for (var controller in _fieldLabelControllers.values) {
      controller.dispose();
    }
    for (var controller in _fieldKeyControllers.values) {
      controller.dispose();
    }
    for (var controller in _placeholderControllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  void _addField() {
    setState(() {
      int newIndex = _fields.length;
      _fields.add(TableField(index: newIndex));
      _fieldLabelControllers[newIndex] = TextEditingController();
      _fieldKeyControllers[newIndex] = TextEditingController();
      _placeholderControllers[newIndex] = TextEditingController();
      _fieldTypes[newIndex] = 'Text';
      _displayFormats[newIndex] = 'Default';
      _requiredFields[newIndex] = false;
    });
  }

  void _removeField(int index) {
    if (_fields.length <= 1) return; // Don't remove the last field

    setState(() {
      _fields.removeAt(index);
      _fieldLabelControllers.remove(index);
      _fieldKeyControllers.remove(index);
      _placeholderControllers.remove(index);
      _fieldTypes.remove(index);
      _displayFormats.remove(index);
      _requiredFields.remove(index);

      // Update indices
      for (int i = 0; i < _fields.length; i++) {
        _fields[i] = TableField(index: i);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Custom Table'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTableTitleField(),
                const SizedBox(height: 24),
                _buildButtonLabelField(),
                const SizedBox(height: 24),
                _buildDivider(),
                const SizedBox(height: 16),
                _buildFieldsSection(),
                const SizedBox(height: 16),
                _buildAddFieldButton(),
                const SizedBox(height: 24),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTableTitleField() {
    return TextFormField(
      controller: _tableTitleController,
      decoration: const InputDecoration(
        labelText: 'Table Title',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a table title';
        }
        return null;
      },
    );
  }

  Widget _buildButtonLabelField() {
    return TextFormField(
      controller: _buttonLabelController,
      decoration: const InputDecoration(
        labelText: 'Add Button Label',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a button label';
        }
        return null;
      },
    );
  }

  Widget _buildDivider() {
    return const Divider(thickness: 1);
  }

  Widget _buildFieldsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Table Fields',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ..._fields.map((field) => _buildFieldCard(field.index)).toList(),
      ],
    );
  }

  Widget _buildFieldCard(int index) {
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
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                if (_fields.length > 1)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeField(index),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _fieldKeyControllers[index],
              decoration: const InputDecoration(
                labelText: 'Field Key *',
                hintText: 'e.g., skillName, projectTitle',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a field key';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildFieldTypeDropdown(index),
            const SizedBox(height: 16),
            TextFormField(
              controller: _placeholderControllers[index],
              decoration: const InputDecoration(
                labelText: 'Placeholder',
                hintText: 'Enter placeholder text',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            _buildDivider(),
            const SizedBox(height: 16),
            const Text(
              'Additional Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _fieldLabelControllers[index],
              decoration: const InputDecoration(
                labelText: 'Field Label',
                hintText: 'e.g., Skill Name, Project Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a field label';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildDisplayFormatDropdown(index),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _requiredFields[index] ?? false,
                  onChanged: (value) {
                    setState(() {
                      _requiredFields[index] = value ?? false;
                    });
                  },
                ),
                const Text('Required Field'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldTypeDropdown(int index) {
    return DropdownButtonFormField<String>(
      value: _fieldTypes[index],
      decoration: const InputDecoration(
        labelText: 'Field Type',
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: 'Text', child: Text('Text')),
        DropdownMenuItem(value: 'Number', child: Text('Number')),
        DropdownMenuItem(value: 'Date', child: Text('Date')),
        DropdownMenuItem(value: 'Dropdown', child: Text('Dropdown')),
      ],
      onChanged: (value) {
        setState(() {
          _fieldTypes[index] = value ?? 'Text';
        });
      },
    );
  }

  Widget _buildDisplayFormatDropdown(int index) {
    return DropdownButtonFormField<String>(
      value: _displayFormats[index],
      decoration: const InputDecoration(
        labelText: 'Display Format',
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: 'Default', child: Text('Default')),
        DropdownMenuItem(value: 'Short', child: Text('Short')),
        DropdownMenuItem(value: 'Long', child: Text('Long')),
      ],
      onChanged: (value) {
        setState(() {
          _displayFormats[index] = value ?? 'Default';
        });
      },
    );
  }

  Widget _buildAddFieldButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _addField,
        icon: const Icon(Icons.add),
        label: const Text('Add Field'),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: _addTable,
          child: const Text('Add Table'),
        ),
      ],
    );
  }

  void _addTable() {
    if (_formKey.currentState!.validate()) {
      // Create column names and field models
      List<String> columns = [];
      List<FieldModel> fieldModels = [];

      for (int i = 0; i < _fields.length; i++) {
        columns.add(_fieldLabelControllers[i]!.text);

        fieldModels.add(FieldModel(
          label: _fieldLabelControllers[i]!.text,
          hint: _placeholderControllers[i]!.text,
          dataType:
              TableCreationLogic.getFieldDataTypeFromString(_fieldTypes[i]!),
          isRequired: _requiredFields[i] ?? false,
        ));
      }

      // Create the new table
      final newTable = TableModel(
        title: _tableTitleController.text,
        rowLabel: _buttonLabelController.text,
        columns: columns,
        rows: [fieldModels], // Add one initial row with the field models
        isPermanent: false,
      );

      // Add the table to the tab model using the logic class
      final updatedTabModel = TableCreationLogic.addTableToTab(
        tabModel: widget.tabModel,
        table: newTable,
      );

      // Notify parent about the new table
      widget.onTableAdded(updatedTabModel);

      // Navigate back
      Navigator.of(context).pop();
    }
  }
}

class TableField {
  final int index;

  TableField({required this.index});
}
