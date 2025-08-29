import 'package:get/get.dart';
import 'package:demo_app/app/data/models/models.dart';

class TabControllerX extends GetxController {
  final TabModel tab;

  TabControllerX(this.tab);

  void updateFieldValue(Field field, dynamic newValue) {
    final sectionIndex = tab.sections.indexWhere((s) => s.fields.contains(field));
    if (sectionIndex != -1) {
      final fieldIndex = tab.sections[sectionIndex].fields
          .indexWhere((f) => f.fieldKey == field.fieldKey);

      if (fieldIndex != -1) {
        tab.sections[sectionIndex].fields[fieldIndex] =
            tab.sections[sectionIndex].fields[fieldIndex].copyWith(value: newValue);
        update(); // notify UI
      }
    }
  }

  void addCustomField(String fieldName, String fieldKey, String fieldType) {
    final formSection = tab.sections.firstWhere(
      (s) => s.sectionType == 'form',
      orElse: () => Section(
        sectionName: 'Custom Fields',
        sectionType: 'form',
        fields: [],
      ),
    );

    final newField = Field(
      fieldName: fieldName,
      fieldKey: fieldKey,
      fieldType: fieldType,
      isEditable: true,
    );

    final updatedSection = formSection.copyWith(
      fields: [...formSection.fields, newField],
    );

    final sectionIndex = tab.sections.indexWhere((s) => s.sectionName == updatedSection.sectionName);
    if (sectionIndex != -1) {
      tab.sections[sectionIndex] = updatedSection;
    } else {
      tab.sections.add(updatedSection);
    }
    update();
  }

  String formatDate(DateTime date) => '${date.month}/${date.day}/${date.year}';
}
