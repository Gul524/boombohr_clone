import 'package:get/get.dart';

enum TabVisibility {
  visible,
  hidden,
}

enum FeildType {
  text,
  number,
  checkbox,
  radio,
}

enum SectionType { form, document }

// class AppTab {
//   final String name;
//   final Rx<TabVisibility> visibility;
//   final bool isLocked;
//   final bool isCustom;
//   final int order;

//   AppTab({
//     required this.name,
//     required this.visibility,
//     this.isLocked = false,
//     this.isCustom = false,
//     required this.order,
//   });

//   AppTab copyWith({
//     String? name,
//     TabVisibility? visibility,
//     bool? isLocked,
//     bool? isCustom,
//     int? order,
//   }) {
//     return AppTab(
//       name: name ?? this.name,
//       visibility: visibility != null ? Rx(visibility) : this.visibility,
//       isLocked: isLocked ?? this.isLocked,
//       isCustom: isCustom ?? this.isCustom,
//       order: order ?? this.order,
//     );
//   }
// }

class TabModel {
  final String tabName;
  final RxList<Section> sections;
  final bool isEditable;
  final bool allowCustomFields;
  final bool allowCustomTables;
  final Rx<TabVisibility> visibility;
  final bool isLocked;
  final bool isCustom;
  final int order;

  TabModel({
    required this.tabName,
    required List<Section> sections,
    this.isEditable = true,
    this.allowCustomFields = true,
    this.allowCustomTables = true,
    required this.visibility,
    this.isLocked = false,
    this.isCustom = false,
    required this.order,
  }) : sections = sections.obs;

  TabModel copyWith({
    String? tabName,
    List<Section>? sections,
    Map<String, dynamic>? customLayout,
    bool? isEditable,
    bool? allowCustomFields,
    bool? allowCustomTables,
    int? order,
    Rx<TabVisibility>? visibility,
  }) {
    return TabModel(
      tabName: tabName ?? this.tabName,
      sections: sections ?? this.sections,
      isEditable: isEditable ?? this.isEditable,
      allowCustomFields: allowCustomFields ?? this.allowCustomFields,
      allowCustomTables: allowCustomTables ?? this.allowCustomTables,
      visibility: visibility ?? this.visibility,
      order: order ?? 0,
    );
  }
}

class Section {
  final String sectionName;
  final String
      sectionType; // 'form', 'list', 'table', 'mixed', 'repeatable', 'notes', 'info'
  final RxList<Field> fields;
  final TableModel? table;
  final RxList<dynamic> items;
  final bool isEditable;
  final bool hasCustomLayout;
  final bool isCustomSection;
  final RxList<SubSection> subSections;
  final bool isRepeatable; // New property
  final RxList<dynamic>
      repeatedSections; // New property for repeatable sections

  Section({
    required this.sectionName,
    required this.sectionType,
    List<Field> fields = const [],
    this.table,
    List<dynamic> items = const [],
    this.isEditable = true,
    this.hasCustomLayout = false,
    this.isCustomSection = false,
    List<SubSection> subSections = const [],
    this.isRepeatable = false,
    List<dynamic> repeatedSections = const [],
  })  : fields = fields.obs,
        items = items.obs,
        subSections = subSections.obs,
        repeatedSections = repeatedSections.obs;

  Section copyWith({
    String? sectionName,
    String? sectionType,
    List<Field>? fields,
    TableModel? table,
    List<dynamic>? items,
    bool? isEditable,
    bool? hasCustomLayout,
    bool? isCustomSection,
    List<SubSection>? subSections,
    bool? isRepeatable,
    List<dynamic>? repeatedSections,
  }) {
    return Section(
      sectionName: sectionName ?? this.sectionName,
      sectionType: sectionType ?? this.sectionType,
      fields: fields ?? this.fields.toList(),
      table: table ?? this.table,
      items: items ?? this.items.toList(),
      isEditable: isEditable ?? this.isEditable,
      hasCustomLayout: hasCustomLayout ?? this.hasCustomLayout,
      isCustomSection: isCustomSection ?? this.isCustomSection,
      subSections: subSections ?? this.subSections.toList(),
      isRepeatable: isRepeatable ?? this.isRepeatable,
      repeatedSections: repeatedSections ?? this.repeatedSections.toList(),
    );
  }
}

class TableModel {
  final String feildEntryButton;
  final List<TableColumn> columns;
  final List<Map<String, dynamic>> rows;
  final bool isEditable;
  final bool isCustomTable;

  TableModel({
    required this.feildEntryButton,
    required this.columns,
    required this.rows,
    this.isEditable = true,
    this.isCustomTable = false,
  });

  TableModel copyWith({
    String? name,
    String? feildEntryButton,
    List<TableColumn>? columns,
    List<Map<String, dynamic>>? rows,
    bool? isEditable,
    bool? isCustomTable,
  }) {
    return TableModel(
      feildEntryButton: feildEntryButton ?? this.feildEntryButton,
      columns: columns ?? this.columns,
      rows: rows ?? this.rows,
      isEditable: isEditable ?? this.isEditable,
      isCustomTable: isCustomTable ?? this.isCustomTable,
    );
  }
}

class SubSection {
  final String name;
  final List<Field> fields;
  final bool isCustom;
  final bool isRepeatable;
  final String? buttonNameToRepeat;

  SubSection({
    required this.name,
    required List<Field> fields,
    this.isCustom = false,
    this.isRepeatable = false,
    this.buttonNameToRepeat,
  }) : fields = fields.obs;

  SubSection copyWith({
    String? name,
    List<Field>? fields,
    bool? isCustom,
    bool? isRepeatable,
    String? secondField,
  }) {
    return SubSection(
      name: name ?? this.name,
      fields: fields ?? this.fields.toList(),
      isCustom: isCustom ?? this.isCustom,
      isRepeatable: isRepeatable ?? this.isRepeatable,
      buttonNameToRepeat: secondField ?? this.buttonNameToRepeat,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'fields': fields.map((field) => field.toJson()).toList(),
      'isCustom': isCustom,
      'isRepeatable': isRepeatable,
      'secondField': buttonNameToRepeat,
    };
  }

  factory SubSection.fromJson(Map<String, dynamic> json) {
    return SubSection(
      name: json['name'],
      fields: (json['fields'] as List)
          .map((field) => Field.fromJson(field))
          .toList(),
      isCustom: json['isCustom'],
      isRepeatable: json['isRepeatable'] ?? false,
      buttonNameToRepeat: json['secondField'],
    );
  }
}

class Field {
  final String fieldName;
  final String fieldKey;
  final String fieldType;
  final dynamic value;
  final bool isRequired;
  final bool isEditable;
  final List<String>? options;
  final String? placeholder;
  final String? validationRegex;
  final DateTime? dueDate;
  final bool isOverdue;

  Field({
    required this.fieldName,
    required this.fieldKey,
    required this.fieldType,
    this.value,
    this.isRequired = false,
    this.isEditable = true,
    this.options,
    this.placeholder,
    this.validationRegex,
    this.dueDate,
    this.isOverdue = false,
  });

  Field copyWith({
    String? fieldName,
    String? fieldKey,
    String? fieldType,
    dynamic value,
    bool? isRequired,
    bool? isEditable,
    List<String>? options,
    String? placeholder,
    String? validationRegex,
    DateTime? dueDate,
    bool? isOverdue,
  }) {
    return Field(
      fieldName: fieldName ?? this.fieldName,
      fieldKey: fieldKey ?? this.fieldKey,
      fieldType: fieldType ?? this.fieldType,
      value: value ?? this.value,
      isRequired: isRequired ?? this.isRequired,
      isEditable: isEditable ?? this.isEditable,
      options: options ?? this.options,
      placeholder: placeholder ?? this.placeholder,
      validationRegex: validationRegex ?? this.validationRegex,
      dueDate: dueDate ?? this.dueDate,
      isOverdue: isOverdue ?? this.isOverdue,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fieldName': fieldName,
      'fieldKey': fieldKey,
      'fieldType': fieldType,
      'value': value,
      'isRequired': isRequired,
      'isEditable': isEditable,
      'options': options,
      'placeholder': placeholder,
      'validationRegex': validationRegex,
      'dueDate': dueDate?.toIso8601String(),
      'isOverdue': isOverdue,
    };
  }

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      fieldName: json['fieldName'],
      fieldKey: json['fieldKey'],
      fieldType: json['fieldType'],
      value: json['value'],
      isRequired: json['isRequired'],
      isEditable: json['isEditable'],
      options:
          json['options'] != null ? List<String>.from(json['options']) : null,
      placeholder: json['placeholder'],
      validationRegex: json['validationRegex'],
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      isOverdue: json['isOverdue'],
    );
  }
}

class TableColumn {
  final String name;
  final String columnKey;
  final String dataType;
  final bool isHighlighted;
  final bool isEditable;

  TableColumn({
    required this.name,
    required this.columnKey,
    required this.dataType,
    this.isHighlighted = false,
    this.isEditable = true,
  });

  TableColumn copyWith({
    String? columnName,
    String? columnKey,
    String? dataType,
    bool? isSortable,
    bool? isEditable,
  }) {
    return TableColumn(
      name: columnName ?? this.name,
      columnKey: columnKey ?? this.columnKey,
      dataType: dataType ?? this.dataType,
      isHighlighted: isSortable ?? this.isHighlighted,
      isEditable: isEditable ?? this.isEditable,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'columnName': name,
      'columnKey': columnKey,
      'dataType': dataType,
      'isSortable': isHighlighted,
      'isEditable': isEditable,
    };
  }

  factory TableColumn.fromJson(Map<String, dynamic> json) {
    return TableColumn(
      name: json['columnName'],
      columnKey: json['columnKey'],
      dataType: json['dataType'],
      isHighlighted: json['isSortable'],
      isEditable: json['isEditable'],
    );
  }
}

class TrainingItem {
  final String trainingName;
  final DateTime? dueDate;
  final bool isCompleted;
  final bool isOverdue;
  final String category;

  TrainingItem({
    required this.trainingName,
    this.dueDate,
    this.isCompleted = false,
    this.isOverdue = false,
    required this.category,
  });
}

class DocumentItem {
  final String documentName;
  final String documentType;
  final DateTime uploadDate;
  final String filePath;
  final int itemCount;

  DocumentItem({
    required this.documentName,
    required this.documentType,
    required this.uploadDate,
    required this.filePath,
    this.itemCount = 0,
  });
}

class BenefitItem {
  final String benefitType;
  final String planName;
  final String eligibilityStatus;
  final bool isEligible;

  BenefitItem({
    required this.benefitType,
    required this.planName,
    required this.eligibilityStatus,
    required this.isEligible,
  });
}

class AssetItem {
  final String assetCategory;
  final String assetDescription;
  final String serialNumber;
  final DateTime assignedDate;
  final DateTime? returnDate;
  final String status;

  AssetItem({
    required this.assetCategory,
    required this.assetDescription,
    required this.serialNumber,
    required this.assignedDate,
    this.returnDate,
    required this.status,
  });
}

class EducationItem {
  final String institution;
  final String major;
  final String degree;
  final double gpa;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrentlyStudying;

  EducationItem({
    required this.institution,
    required this.major,
    required this.degree,
    required this.gpa,
    required this.startDate,
    this.endDate,
    this.isCurrentlyStudying = false,
  });
}

class NoteItem {
  final String author;
  final String content;
  final DateTime timestamp;

  NoteItem({
    required this.author,
    required this.content,
    required this.timestamp,
  });
}
