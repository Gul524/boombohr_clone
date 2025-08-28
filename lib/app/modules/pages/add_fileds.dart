import 'package:demo_app/app/data/models/models.dart';
import 'package:flutter/material.dart';

class AddFieldPage extends StatefulWidget {
  final TabModel tab;

  const AddFieldPage({super.key, required this.tab});

  @override
  State<AddFieldPage> createState() => _AddFieldPageState();
}

class _AddFieldPageState extends State<AddFieldPage> {
  String? selectedSection;
  String? newSectionName;
  String? selectedSubsection;
  String? newSubsectionName;
  String? fieldName;
  String? fieldHint;
  String? fieldType;
  bool isRequired = false;

  final List<String> dataTypes = ["Text", "Number", "Date", "Dropdown"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Field")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Section Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Section",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: [
                ...widget.tab.sections!.map((s) =>
                    DropdownMenuItem(value: s.title, child: Text(s.title))),
                const DropdownMenuItem(
                    value: "new", child: Text("➕ Create New Section")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedSection = value;
                });
              },
            ),

            if (selectedSection == "new") ...[
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: "New Section Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onChanged: (val) => newSectionName = val,
              ),
            ],

            const SizedBox(height: 16),

            // Subsection Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Subsection",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: [
                const DropdownMenuItem(
                    value: "none", child: Text("No Subsection")),
                ..._getAvailableSubsections().map(
                  (sub) => DropdownMenuItem(value: sub, child: Text(sub)),
                ),
                const DropdownMenuItem(
                    value: "new", child: Text("➕ Create New Subsection")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedSubsection = value;
                });
              },
            ),

            if (selectedSubsection == "new") ...[
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: "New Subsection Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onChanged: (val) => newSubsectionName = val,
              ),
            ],

            const SizedBox(height: 16),

            // Field Name
            TextField(
              decoration: InputDecoration(
                labelText: "Field Name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (val) => fieldName = val,
            ),

            const SizedBox(height: 16),

            // Field Type
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Field Type",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: dataTypes
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (val) => fieldType = val,
            ),

            const SizedBox(height: 16),

            // Field Hint
            TextField(
              decoration: InputDecoration(
                labelText: "Field Hint",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (val) => fieldHint = val,
            ),

            const SizedBox(height: 16),

            // Required Checkbox
            CheckboxListTile(
              title: const Text("Required Field"),
              value: isRequired,
              onChanged: (val) => setState(() => isRequired = val ?? false),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel")),
                ElevatedButton(
                  onPressed: _saveField,
                  child: const Text("Save"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<String> _getAvailableSubsections() {
    if (selectedSection == null || selectedSection == "new") return [];
    final section =
        widget.tab.sections!.firstWhere((s) => s.title == selectedSection);
    return section.subSections!.map((ss) => ss.title).toList();
  }

  void _saveField() {
    if ((selectedSection == null || selectedSection!.isEmpty) &&
        (newSectionName == null || newSectionName!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select or create a section")),
      );
      return;
    }

    if (fieldName == null || fieldName!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a field name")),
      );
      return;
    }

    if (fieldType == null || fieldType!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a field type")),
      );
      return;
    }

    // Convert fieldType string to FieldDataType enum
    FieldDataType dataTypeEnum = FieldDataType.values.firstWhere(
      (e) =>
          e.toString().split('.').last.toLowerCase() ==
          fieldType!.toLowerCase(),
      orElse: () => FieldDataType.text,
    );

    // Create FieldModel
    final newField = FieldModel(
      label: fieldName!,
      hint: fieldHint ?? "",
      dataType: dataTypeEnum,
      isPermanent: false,
    );

    // 1. Handle Section
    SectionModel targetSection;

    if (selectedSection == "new") {
      targetSection = SectionModel(
        icon: Icons.add,
        title: newSectionName ?? "",
        order: widget.tab.sections?.length ?? 0,
        isPermanent: false,
        subSections: [],
        fields: [],
        tables: [],
      );
      widget.tab.sections ??= [];
      widget.tab.sections!.add(targetSection);
    } else {
      targetSection =
          widget.tab.sections!.firstWhere((s) => s.title == selectedSection);
    }

    // 2. Handle Subsection
    if (selectedSubsection == "new") {
      final newSub = SubsectionModel(
        title: newSubsectionName ?? "",
        order: targetSection.subSections?.length ?? 0,
        isPermanent: false,
        fields: [newField],
        tables: [],
      );
      targetSection.subSections ??= [];
      targetSection.subSections!.add(newSub);
    } else if (selectedSubsection == "none" || selectedSubsection == null) {
      targetSection.fields ??= [];
      targetSection.fields!.add(newField);
    } else {
      final sub = targetSection.subSections!
          .firstWhere((ss) => ss.title == selectedSubsection);
      sub.fields ??= [];
      sub.fields!.add(newField);
    }

    // 3. Return updated TabModel
    Navigator.pop(context, widget.tab);
  }
}
