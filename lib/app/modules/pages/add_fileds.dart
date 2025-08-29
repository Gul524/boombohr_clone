// add_field_page.dart
import 'package:demo_app/app/modules/home/tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFieldPage extends StatefulWidget {
  final String tabName;
  const AddFieldPage({super.key, required this.tabName});

  @override
  // ignore: library_private_types_in_public_api
  _AddFieldPageState createState() => _AddFieldPageState();
}

class _AddFieldPageState extends State<AddFieldPage> {
  final AppTabController tabController = Get.find();
  final _formKey = GlobalKey<FormState>();

  String? selectedSection;
  String? selectedSubSection;
  String? newSectionName;
  String? newSubSectionName;
  final TextEditingController fieldNameController = TextEditingController();
  final TextEditingController fieldKeyController = TextEditingController();
  String selectedFieldType = 'text';
  final TextEditingController placeholderController = TextEditingController();
  bool isRequired = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Custom Field'),
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
              _buildSectionDropdown(),
              const SizedBox(height: 16),
              _buildSubSectionDropdown(),
              const SizedBox(height: 16),
              _buildFieldNameInput(),
              const SizedBox(height: 16),
              _buildFieldTypeDropdown(),
              const SizedBox(height: 16),
              _buildPlaceholderInput(),
              const SizedBox(height: 16),
              _buildRequiredCheckbox(),
              const SizedBox(height: 32),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionDropdown() {
    final sections = tabController.tabs
        .where((t) => t.tabName == widget.tabName)
        .first
        .sections;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Section', style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          initialValue: selectedSection,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: [
            ...sections
                .map((section) => DropdownMenuItem(
                      value: section.sectionName,
                      child: Text(section.sectionName),
                    ))
                .toList(),
            const DropdownMenuItem(
              value: 'create_new',
              child: Text('Create New Section'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedSection = value;
              selectedSubSection = null;
              if (value == 'create_new') {
                newSectionName = '';
              }
            });
          },
        ),
        if (selectedSection == 'create_new') ...[
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'New Section Name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => newSectionName = value,
            validator: (value) =>
                value?.isEmpty ?? true ? 'Section name is required' : null,
          ),
        ],
      ],
    );
  }

  Widget _buildSubSectionDropdown() {
    if (selectedSection == null || selectedSection == 'create_new') {
      return Container();
    }

    final section = tabController.tabs
        .where((t) => t.tabName == widget.tabName)
        .first
        .sections
        .firstWhere(
          (s) => s.sectionName == selectedSection,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Sub-section',
            style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          value: selectedSubSection,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: [
            const DropdownMenuItem(
              value: 'main_section',
              child: Text('Main Section'),
            ),
            ...section.subSections
                .map((sub) => DropdownMenuItem(
                      value: sub.name,
                      child: Text(sub.name),
                    ))
                .toList(),
            const DropdownMenuItem(
              value: 'create_new',
              child: Text('Create New Sub-section'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedSubSection = value;
              if (value == 'create_new') {
                newSubSectionName = '';
              }
            });
          },
        ),
        if (selectedSubSection == 'create_new') ...[
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'New Sub-section Name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => newSubSectionName = value,
            validator: (value) =>
                value?.isEmpty ?? true ? 'Sub-section name is required' : null,
          ),
        ],
      ],
    );
  }

  Widget _buildFieldNameInput() {
    return TextFormField(
      controller: fieldNameController,
      decoration: const InputDecoration(
        labelText: 'Field Name',
        border: OutlineInputBorder(),
      ),
      validator: (value) =>
          value?.isEmpty ?? true ? 'Field name is required' : null,
    );
  }

  Widget _buildFieldTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Field Type', style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          value: selectedFieldType,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: 'text', child: Text('Text')),
            DropdownMenuItem(value: 'number', child: Text('Number')),
            DropdownMenuItem(value: 'date', child: Text('Date')),
            DropdownMenuItem(value: 'email', child: Text('Email')),
            DropdownMenuItem(value: 'select', child: Text('Select')),
            DropdownMenuItem(value: 'checkbox', child: Text('Checkbox')),
          ],
          onChanged: (value) => setState(() => selectedFieldType = value ?? ""),
        ),
      ],
    );
  }

  Widget _buildPlaceholderInput() {
    return TextFormField(
      controller: placeholderController,
      decoration: const InputDecoration(
        labelText: 'Placeholder',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildRequiredCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: isRequired,
          onChanged: (value) => setState(() => isRequired = value ?? false),
        ),
        const Text('Required Field'),
      ],
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
          onPressed: _addField,
          child: const Text('Add Field'),
        ),
      ],
    );
  }

  void _addField() {
    if (_formKey.currentState?.validate() ?? false) {
      final sectionName =
          selectedSection == 'create_new' ? newSectionName : selectedSection;
      String subSectionName = '';
      if (selectedSubSection == 'create_new') {
        // If user wants to create a new subsection, use the provided name (can be blank)
        subSectionName = newSubSectionName ?? '';
      } else if (selectedSubSection == 'main_section' ||
          selectedSubSection == null) {
        // If user chooses main section or nothing, leave subSectionName blank
        subSectionName = '';
      } else {
        // Otherwise, use the selected subsection name
        subSectionName = selectedSubSection ?? '';
      }

      tabController.addCustomField(
        tabName: widget.tabName,
        sectionName: sectionName ?? "",
        subSectionName: subSectionName,
        fieldName: fieldNameController.text,
        fieldKey: fieldKeyController.text,
        fieldType: selectedFieldType,
        placeholder: placeholderController.text,
        isRequired: isRequired,
      );

      Get.back();
    }
  }
}
