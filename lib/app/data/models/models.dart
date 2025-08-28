import 'package:flutter/material.dart';

enum TabType { form, documents, notes }

enum DocumentType { file, folder }

class TabModel {
  String title;
  int order;
  bool isPermanent;
  TabType tabType;
  IconData icon; // Added IconData for tabs

  // Nullable: only one will be filled depending on tabType
  List<SectionModel>? sections; // for form tabs
  List<DocumentItem>? documents; // for document tabs
  List<NoteModel>? notes; // for notes tabs

  TabModel({
    required this.title,
    required this.order,
    this.isPermanent = false,
    required this.tabType,
    required this.icon, // Added required icon parameter
    this.sections,
    this.documents,
    this.notes,
  });

  factory TabModel.fromJson(Map<String, dynamic> json) {
    return TabModel(
      title: json['title'] ?? '',
      order: json['order'] ?? 0,
      isPermanent: json['isPermanent'] ?? false,
      tabType: TabType.values.firstWhere(
        (e) => e.toString().split('.').last == (json['tabType'] ?? 'form'),
        orElse: () => TabType.form,
      ),
      icon: _parseIconFromJson(json['icon']), // Parse icon from JSON
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => SectionModel.fromJson(e))
          .toList(),
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => DocumentItem.fromJson(e))
          .toList(),
      notes: (json['notes'] as List<dynamic>?)
          ?.map((e) => NoteModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'order': order,
      'isPermanent': isPermanent,
      'tabType': tabType.toString().split('.').last,
      'icon': _iconToJson(icon), // Convert icon to JSON
      if (sections != null)
        'sections': sections!.map((e) => e.toJson()).toList(),
      if (documents != null)
        'documents': documents!.map((e) => e.toJson()).toList(),
      if (notes != null) 'notes': notes!.map((e) => e.toJson()).toList(),
    };
  }

  // Helper method to parse icon from JSON (you might want to customize this)
  static IconData _parseIconFromJson(dynamic iconJson) {
    if (iconJson is String) {
      // You can map string names to actual icons
      switch (iconJson) {
        case 'person':
          return Icons.person;
        case 'work':
          return Icons.work;
        case 'school':
          return Icons.school;
        case 'event':
          return Icons.event;
        case 'folder':
          return Icons.folder;
        case 'description':
          return Icons.description;
        case 'health_and_safety':
          return Icons.health_and_safety;
        case 'devices':
          return Icons.devices;
        case 'emergency':
          return Icons.emergency;
        case 'medical_services':
          return Icons.medical_services;
        case 'checklist':
          return Icons.checklist;
        case 'note':
          return Icons.note;
        default:
          return Icons.category;
      }
    }
    return Icons.category; // Default icon
  }

  // Helper method to convert icon to JSON (you might want to customize this)
  static String _iconToJson(IconData icon) {
    // Convert icon to string representation
    if (icon == Icons.person) return 'person';
    if (icon == Icons.work) return 'work';
    if (icon == Icons.school) return 'school';
    if (icon == Icons.event) return 'event';
    if (icon == Icons.folder) return 'folder';
    if (icon == Icons.description) return 'description';
    if (icon == Icons.health_and_safety) return 'health_and_safety';
    if (icon == Icons.devices) return 'devices';
    if (icon == Icons.emergency) return 'emergency';
    if (icon == Icons.medical_services) return 'medical_services';
    if (icon == Icons.checklist) return 'checklist';
    if (icon == Icons.note) return 'note';
    return 'category';
  }
}

class SectionModel {
  String title;
  int order;
  bool isPermanent;
  IconData icon; // Added IconData for sections
  List<SubsectionModel>? subSections; // recursive
  List<FieldModel>? fields;
  List<TableModel>? tables;

  SectionModel({
    required this.title,
    required this.order,
    this.isPermanent = false,
    required this.icon, // Added required icon parameter
    this.subSections,
    this.fields,
    this.tables,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      title: json['title'] ?? '',
      order: json['order'] ?? 0,
      isPermanent: json['isPermanent'] ?? false,
      icon: TabModel._parseIconFromJson(json['icon']), // Use same icon parsing
      subSections: (json['subSections'] as List<dynamic>?)
          ?.map((e) => SubsectionModel.fromJson(e))
          .toList(),
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => FieldModel.fromJson(e))
          .toList(),
      tables: (json['tables'] as List<dynamic>?)
          ?.map((e) => TableModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'order': order,
      'isPermanent': isPermanent,
      'icon': TabModel._iconToJson(icon), // Use same icon conversion
      if (subSections != null)
        'subSections': subSections!.map((e) => e.toJson()).toList(),
      if (fields != null) 'fields': fields!.map((e) => e.toJson()).toList(),
      if (tables != null) 'tables': tables!.map((e) => e.toJson()).toList(),
    };
  }
}

class SubsectionModel {
  String title;
  int order;
  bool isPermanent;
  List<FieldModel>? fields;
  List<TableModel>? tables;

  SubsectionModel({
    required this.title,
    required this.order,
    this.isPermanent = false,
    this.fields,
    this.tables,
  });

  factory SubsectionModel.fromJson(Map<String, dynamic> json) {
    return SubsectionModel(
      title: json['title'] ?? '',
      order: json['order'] ?? 0,
      isPermanent: json['isPermanent'] ?? false,
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => FieldModel.fromJson(e))
          .toList(),
      tables: (json['tables'] as List<dynamic>?)
          ?.map((e) => TableModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'order': order,
      'isPermanent': isPermanent,
      if (fields != null) 'fields': fields!.map((e) => e.toJson()).toList(),
      if (tables != null) 'tables': tables!.map((e) => e.toJson()).toList(),
    };
  }
}

class NoteModel {
  String text;
  DateTime dateTime;
  bool isPermanent;

  NoteModel({
    required this.text,
    required this.dateTime,
    this.isPermanent = false,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      text: json['text'] ?? '',
      dateTime: DateTime.tryParse(json['dateTime'] ?? '') ?? DateTime.now(),
      isPermanent: json['isPermanent'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'dateTime': dateTime.toIso8601String(),
      'isPermanent': isPermanent,
    };
  }
}

class DocumentItem {
  String name;
  DocumentType type;
  bool isPermanent;
  String? fileUrl; // only for files
  List<DocumentItem>? children; // only for folders

  DocumentItem({
    required this.name,
    required this.type,
    this.isPermanent = false,
    this.fileUrl,
    this.children,
  });

  factory DocumentItem.fromJson(Map<String, dynamic> json) {
    return DocumentItem(
      name: json['name'] ?? '',
      type: DocumentType.values.firstWhere(
        (e) => e.toString().split('.').last == (json['type'] ?? 'file'),
        orElse: () => DocumentType.file,
      ),
      isPermanent: json['isPermanent'] ?? false,
      fileUrl: json['fileUrl'],
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => DocumentItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type.toString().split('.').last,
      'isPermanent': isPermanent,
      if (fileUrl != null) 'fileUrl': fileUrl,
      if (children != null)
        'children': children!.map((e) => e.toJson()).toList(),
    };
  }
}

enum FieldDataType {
  text,
  number,
  date,
  dropdown,
  checkbox,
  radio,
  file,
}

class FieldModel {
  String label;
  String hint;
  FieldDataType dataType;
  dynamic value;
  Map<String, dynamic>? validations;
  List<String>? options; // for dropdown, radio, checkbox
  bool allowMultiple;
  bool isPermanent;
  bool isRequired;

  FieldModel({
    required this.label,
    required this.hint,
    required this.dataType,
    this.value,
    this.validations,
    this.options,
    this.allowMultiple = false,
    this.isPermanent = false,
    this.isRequired = false,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
        label: json['label'] ?? '',
        hint: json['hint'] ?? '',
        dataType: FieldDataType.values.firstWhere(
          (e) => e.toString().split('.').last == (json['dataType'] ?? 'text'),
          orElse: () => FieldDataType.text,
        ),
        value: json['value'],
        validations: json['validations'] != null
            ? Map<String, dynamic>.from(json['validations'])
            : null,
        options: (json['options'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        allowMultiple: json['allowMultiple'] ?? false,
        isPermanent: json['isPermanent'] ?? false,
        isRequired: json["isRequired"] ?? false);
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'hint': hint,
      'dataType': dataType.toString().split('.').last,
      'value': value,
      if (validations != null) 'validations': validations,
      if (options != null) 'options': options,
      'allowMultiple': allowMultiple,
      'isPermanent': isPermanent,
      'isRequired': isRequired
    };
  }
}

class TableModel {
  String title;
  String rowLabel; // text shown on "Add new row" button
  List<String> columns;
  List<List<FieldModel>> rows;
  bool isPermanent;

  TableModel({
    required this.title,
    required this.rowLabel,
    required this.columns,
    this.rows = const [],
    this.isPermanent = false,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      title: json['title'] ?? '',
      rowLabel: json['rowLabel'] ?? 'Add Row',
      columns: (json['columns'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      rows: (json['rows'] as List<dynamic>? ?? [])
          .map((row) => (row as List<dynamic>)
              .map((e) => FieldModel.fromJson(e))
              .toList())
          .toList(),
      isPermanent: json['isPermanent'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'rowLabel': rowLabel,
      'columns': columns,
      'rows': rows.map((row) => row.map((e) => e.toJson()).toList()).toList(),
      'isPermanent': isPermanent,
    };
  }
}
