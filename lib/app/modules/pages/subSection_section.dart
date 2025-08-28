import 'package:demo_app/app/data/models/models.dart';
import 'package:flutter/material.dart';

/// Page to reorder the FIELDS of a single Subsection (which is also a SectionModel).
class SubsectionFieldsReorderPage extends StatefulWidget {
  final SectionModel subSection;

  const SubsectionFieldsReorderPage({super.key, required this.subSection});

  @override
  State<SubsectionFieldsReorderPage> createState() => _SubsectionFieldsReorderPageState();
}

class _SubsectionFieldsReorderPageState extends State<SubsectionFieldsReorderPage> {
  late SectionModel subCopy;

  @override
  void initState() {
    super.initState();
    subCopy = SectionModel.fromJson(widget.subSection.toJson());
    subCopy.fields ??= [];
  }

  void _reindex(List<FieldModel> fields) {
    // If you add 'order' to FieldModel later, set it here.
  }

  @override
  Widget build(BuildContext context) {
    final fields = subCopy.fields!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Reorder Fields • ${subCopy.title}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => Navigator.pop(context, subCopy),
            tooltip: 'Save',
          ),
        ],
      ),
      body: fields.isEmpty
          ? const Center(child: Text('No fields in this subsection.'))
          : ReorderableListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              itemCount: fields.length,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex -= 1;
                  final item = fields.removeAt(oldIndex);
                  fields.insert(newIndex, item);
                  _reindex(fields);
                });
              },
              itemBuilder: (context, index) {
                final f = fields[index];
                return Card(
                  key: ValueKey('subfield_${index}_${f.label}_${f.dataType}'),
                  child: ListTile(
                    leading: const Icon(Icons.drag_indicator),
                    title: Text(f.label.isEmpty ? '(unnamed field)' : f.label),
                    subtitle: Text(_fieldTypeLabel(f)),
                  ),
                );
              },
            ),
    );
  }

  String _fieldTypeLabel(FieldModel f) {
    switch (f.dataType) {
      case FieldDataType.text:
        return 'Text';
      case FieldDataType.number:
        return 'Number';
      case FieldDataType.date:
        return 'Date';
      case FieldDataType.dropdown:
        return 'Dropdown';
      case FieldDataType.checkbox:
        return 'Checkbox (multi)';
      case FieldDataType.radio:
        return 'Radio (single)';
      case FieldDataType.file:
        return 'File';
    }
  }
}
