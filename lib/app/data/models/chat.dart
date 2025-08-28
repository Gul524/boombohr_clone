// i am providing you a model and you have to create a flutter Widget according to model with following requirement :

// Show tab icon and  name on top leftt corner with big font and green color ,

// in the front of  tab name on the right corner give MenuButton with label "Customirze Layout" with tree option "ReOrder Fields " , "AddCustom Field" , "Add custom table " .

// then add Card for Section 

// on section card ,
// icon and name of section in left corner 
// if there is sub section then
// first add icon and name of sub section in left corner 
//  create a border  border and in that border , add all fieds acourding to data type , like if text/numbers  you will use textfields , for multiple options it will be checkboxes , for signle option it will be radio list . you decide it acourding to  datatype or parameters that clear what to use , 

// on the same section card , there will fields same as above i defiened in subsection fields styles 
// if there availbe notes use same card but just on the card create notes text field with max 5 lines and left and circle with Two letter written on it 
// below the text flied add two button on reight side one for clear the textfield and one for post 
// and below with some padding list all notes in conversation or chat style all notes with date time 


// if there any table  
// add a row in left side add table name , in right side  a button for adding new field in right corner with some margin . 
// then inside rounder border with some padding  show table without row/colum line s and also Add an Action Column in last of column there will be two icon button edit and delete in round edge border 

// for the doctument 
// use colum and in column 
// use a row in which define 
// icon name  and upload button(background : green , foreground : white ) iconbutton with round border to select dgrid view or list view , 
// on left seatch field for searching file/folder . a download button 
// then show a card list all avaible documents





// ------ Model ---- 
// enum TabType { form, documents, notes }

// enum DocumentType { file, folder }

// class TabModel {
//   String title;
//   int order;
//   bool isPermanent;
//   TabType tabType;

//   // Nullable: only one will be filled depending on tabType
//   List<SectionModel>? sections; // for form tabs
//   List<DocumentItem>? documents; // for document tabs
//   List<NoteModel>? notes; // for notes tabs

//   TabModel({
//     required this.title,
//     required this.order,
//     this.isPermanent = false,
//     required this.tabType,
//     this.sections,
//     this.documents,
//     this.notes,
//   });

//   factory TabModel.fromJson(Map<String, dynamic> json) {
//     return TabModel(
//       title: json['title'] ?? '',
//       order: json['order'] ?? 0,
//       isPermanent: json['isPermanent'] ?? false,
//       tabType: TabType.values.firstWhere(
//         (e) => e.toString().split('.').last == (json['tabType'] ?? 'form'),
//         orElse: () => TabType.form,
//       ),
//       sections: (json['sections'] as List<dynamic>?)
//           ?.map((e) => SectionModel.fromJson(e))
//           .toList(),
//       documents: (json['documents'] as List<dynamic>?)
//           ?.map((e) => DocumentItem.fromJson(e))
//           .toList(),
//       notes: (json['notes'] as List<dynamic>?)
//           ?.map((e) => NoteModel.fromJson(e))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'order': order,
//       'isPermanent': isPermanent,
//       'tabType': tabType.toString().split('.').last,
//       if (sections != null)
//         'sections': sections!.map((e) => e.toJson()).toList(),
//       if (documents != null)
//         'documents': documents!.map((e) => e.toJson()).toList(),
//       if (notes != null) 'notes': notes!.map((e) => e.toJson()).toList(),
//     };
//   }
// }

// class SectionModel {
//   String title;
//   int order;
//   bool isPermanent;
//   List<SectionModel>? subSections; // recursive
//   List<FieldModel>? fields;
//   List<TableModel>? tables;

//   SectionModel({
//     required this.title,
//     required this.order,
//     this.isPermanent = false,
//     this.subSections,
//     this.fields,
//     this.tables,
//   });

//   factory SectionModel.fromJson(Map<String, dynamic> json) {
//     return SectionModel(
//       title: json['title'] ?? '',
//       order: json['order'] ?? 0,
//       isPermanent: json['isPermanent'] ?? false,
//       subSections: (json['subSections'] as List<dynamic>?)
//           ?.map((e) => SectionModel.fromJson(e))
//           .toList(),
//       fields: (json['fields'] as List<dynamic>?)
//           ?.map((e) => FieldModel.fromJson(e))
//           .toList(),
//       tables: (json['tables'] as List<dynamic>?)
//           ?.map((e) => TableModel.fromJson(e))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'order': order,
//       'isPermanent': isPermanent,
//       if (subSections != null)
//         'subSections': subSections!.map((e) => e.toJson()).toList(),
//       if (fields != null) 'fields': fields!.map((e) => e.toJson()).toList(),
//       if (tables != null) 'tables': tables!.map((e) => e.toJson()).toList(),
//     };
//   }
// }

// class NoteModel {
//   String text;
//   DateTime dateTime;
//   bool isPermanent;

//   NoteModel({
//     required this.text,
//     required this.dateTime,
//     this.isPermanent = false,
//   });

//   factory NoteModel.fromJson(Map<String, dynamic> json) {
//     return NoteModel(
//       text: json['text'] ?? '',
//       dateTime: DateTime.tryParse(json['dateTime'] ?? '') ?? DateTime.now(),
//       isPermanent: json['isPermanent'] ?? false,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'text': text,
//       'dateTime': dateTime.toIso8601String(),
//       'isPermanent': isPermanent,
//     };
//   }
// }

// class DocumentItem {
//   String name;
//   DocumentType type;
//   bool isPermanent;
//   String? fileUrl; // only for files
//   List<DocumentItem>? children; // only for folders

//   DocumentItem({
//     required this.name,
//     required this.type,
//     this.isPermanent = false,
//     this.fileUrl,
//     this.children,
//   });

//   factory DocumentItem.fromJson(Map<String, dynamic> json) {
//     return DocumentItem(
//       name: json['name'] ?? '',
//       type: DocumentType.values.firstWhere(
//         (e) => e.toString().split('.').last == (json['type'] ?? 'file'),
//         orElse: () => DocumentType.file,
//       ),
//       isPermanent: json['isPermanent'] ?? false,
//       fileUrl: json['fileUrl'],
//       children: (json['children'] as List<dynamic>?)
//           ?.map((e) => DocumentItem.fromJson(e))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'type': type.toString().split('.').last,
//       'isPermanent': isPermanent,
//       if (fileUrl != null) 'fileUrl': fileUrl,
//       if (children != null)
//         'children': children!.map((e) => e.toJson()).toList(),
//     };
//   }
// }

// enum FieldDataType {
//   text,
//   number,
//   date,
//   dropdown,
//   checkbox,
//   radio,
//   file,
// }

// class FieldModel {
//   String label;
//   String hint;
//   FieldDataType dataType;
//   dynamic value;
//   Map<String, dynamic>? validations;
//   List<String>? options; // for dropdown, radio, checkbox
//   bool allowMultiple;
//   bool isPermanent;

//   FieldModel({
//     required this.label,
//     required this.hint,
//     required this.dataType,
//     this.value,
//     this.validations,
//     this.options,
//     this.allowMultiple = false,
//     this.isPermanent = false,
//   });

//   factory FieldModel.fromJson(Map<String, dynamic> json) {
//     return FieldModel(
//       label: json['label'] ?? '',
//       hint: json['hint'] ?? '',
//       dataType: FieldDataType.values.firstWhere(
//         (e) => e.toString().split('.').last == (json['dataType'] ?? 'text'),
//         orElse: () => FieldDataType.text,
//       ),
//       value: json['value'],
//       validations: json['validations'] != null
//           ? Map<String, dynamic>.from(json['validations'])
//           : null,
//       options: (json['options'] as List<dynamic>?)
//           ?.map((e) => e.toString())
//           .toList(),
//       allowMultiple: json['allowMultiple'] ?? false,
//       isPermanent: json['isPermanent'] ?? false,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'label': label,
//       'hint': hint,
//       'dataType': dataType.toString().split('.').last,
//       'value': value,
//       if (validations != null) 'validations': validations,
//       if (options != null) 'options': options,
//       'allowMultiple': allowMultiple,
//       'isPermanent': isPermanent,
//     };
//   }
// }

// class TableModel {
//   String title;
//   String rowLabel; // text shown on "Add new row" button
//   List<String> columns;
//   List<List<FieldModel>> rows;
//   bool isPermanent;

//   TableModel({
//     required this.title,
//     required this.rowLabel,
//     required this.columns,
//     this.rows = const [],
//     this.isPermanent = false,
//   });

//   factory TableModel.fromJson(Map<String, dynamic> json) {
//     return TableModel(
//       title: json['title'] ?? '',
//       rowLabel: json['rowLabel'] ?? 'Add Row',
//       columns: (json['columns'] as List<dynamic>? ?? [])
//           .map((e) => e.toString())
//           .toList(),
//       rows: (json['rows'] as List<dynamic>? ?? [])
//           .map((row) => (row as List<dynamic>)
//               .map((e) => FieldModel.fromJson(e))
//               .toList())
//           .toList(),
//       isPermanent: json['isPermanent'] ?? false,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'rowLabel': rowLabel,
//       'columns': columns,
//       'rows': rows.map((row) => row.map((e) => e.toJson()).toList()).toList(),
//       'isPermanent': isPermanent,
//     };
//   }
// }