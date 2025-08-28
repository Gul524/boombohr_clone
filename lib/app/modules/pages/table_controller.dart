import 'package:demo_app/app/data/models/models.dart';
import 'package:flutter/material.dart';


class TableCreationLogic {
  // Create a new table model based on input parameters
  static TableModel createTable({
    required String title,
    required String rowLabel,
    required List<String> columns,
    List<List<FieldModel>> rows = const [],
    bool isPermanent = false,
  }) {
    return TableModel(
      title: title,
      rowLabel: rowLabel,
      columns: columns,
      rows: rows,
      isPermanent: isPermanent,
    );
  }

  // Add table to a tab model
  static TabModel addTableToTab({
    required TabModel tabModel,
    required TableModel table,
    int sectionIndex = 0,
  }) {
    // Create a copy of the tab model to avoid direct mutation
    final updatedTabModel = TabModel(
      title: tabModel.title,
      order: tabModel.order,
      isPermanent: tabModel.isPermanent,
      tabType: tabModel.tabType,
      icon: tabModel.icon,
      sections: tabModel.sections != null 
          ? List<SectionModel>.from(tabModel.sections!) 
          : null,
      documents: tabModel.documents != null 
          ? List<DocumentItem>.from(tabModel.documents!) 
          : null,
      notes: tabModel.notes != null 
          ? List<NoteModel>.from(tabModel.notes!) 
          : null,
    );

    updatedTabModel.sections ??= [];

    if (updatedTabModel.sections!.length <= sectionIndex) {
      // Create new sections if needed
      for (int i = updatedTabModel.sections!.length; i <= sectionIndex; i++) {
        updatedTabModel.sections!.add(SectionModel(
          title: 'Section ${i + 1}',
          order: i,
          icon: Icons.list,
        ));
      }
    }

    // Initialize tables list if null
    updatedTabModel.sections![sectionIndex].tables ??= [];
    
    // Add the table
    updatedTabModel.sections![sectionIndex].tables!.add(table);

    return updatedTabModel;
  }

  // Validate table creation form
  static Map<String, String> validateTableForm({
    required String tableTitle,
    required String buttonLabel,
    required List<String> fieldKeys,
    required List<String> fieldLabels,
  }) {
    final errors = <String, String>{};

    if (tableTitle.isEmpty) {
      errors['tableTitle'] = 'Table title is required';
    }

    if (buttonLabel.isEmpty) {
      errors['buttonLabel'] = 'Button label is required';
    }

    for (int i = 0; i < fieldKeys.length; i++) {
      if (fieldKeys[i].isEmpty) {
        errors['fieldKey$i'] = 'Field key is required for field ${i + 1}';
      }
    }

    for (int i = 0; i < fieldLabels.length; i++) {
      if (fieldLabels[i].isEmpty) {
        errors['fieldLabel$i'] = 'Field label is required for field ${i + 1}';
      }
    }

    return errors;
  }

  // Create a field model for table columns
  static FieldModel createFieldModel({
    required String label,
    required String hint,
    required FieldDataType dataType,
    bool isRequired = false,
    dynamic value,
    Map<String, dynamic>? validations,
    List<String>? options,
    bool allowMultiple = false,
    bool isPermanent = false,
  }) {
    return FieldModel(
      label: label,
      hint: hint,
      dataType: dataType,
      isRequired: isRequired,
      value: value,
      validations: validations,
      options: options,
      allowMultiple: allowMultiple,
      isPermanent: isPermanent,
    );
  }

  // Convert field type string to FieldDataType enum
  static FieldDataType getFieldDataTypeFromString(String type) {
    switch (type.toLowerCase()) {
      case 'text':
        return FieldDataType.text;
      case 'number':
        return FieldDataType.number;
      case 'date':
        return FieldDataType.date;
      case 'dropdown':
        return FieldDataType.dropdown;
      case 'checkbox':
        return FieldDataType.checkbox;
      case 'radio':
        return FieldDataType.radio;
      case 'file':
        return FieldDataType.file;
      default:
        return FieldDataType.text;
    }
  }

  // Generate a unique identifier for storing table data
  static String generateTableId() {
    return 'table_${DateTime.now().millisecondsSinceEpoch}';
  }
}