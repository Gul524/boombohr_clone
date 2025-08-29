import 'package:demo_app/app/modules/home/tabWidgetController.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/app/data/models/models.dart';

class FormSection extends StatelessWidget {
  final Section section;
  final TabControllerX controller;

  const FormSection({super.key, required this.section, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(section.sectionName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
            const SizedBox(height: 16),
            ...section.fields.map((field) => _buildFormField(field)),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(Field field) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        initialValue: field.value?.toString() ?? '',
        decoration: InputDecoration(
          labelText: field.fieldName,
          border: const OutlineInputBorder(),
        ),
        onChanged: (val) => controller.updateFieldValue(field, val),
        enabled: field.isEditable,
      ),
    );
  }
}
