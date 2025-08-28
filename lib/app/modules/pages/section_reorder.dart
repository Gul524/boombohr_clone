// import 'package:demo_app/app/data/models/models.dart';
// import 'package:demo_app/app/modules/pages/subSection_section.dart';
// import 'package:flutter/material.dart';

// /// Page to reorder the internals of a single Section:
// /// - Fields within the section
// /// - Subsections within the section
// /// - For each subsection, you can open a dedicated page to reorder its fields
// class SectionReorderPage extends StatefulWidget {
//   final SectionModel section;

//   const SectionReorderPage({super.key, required this.section});

//   @override
//   State<SectionReorderPage> createState() => _SectionReorderPageState();
// }

// class _SectionReorderPageState extends State<SectionReorderPage> {
//   late SectionModel sectionCopy;

//   @override
//   void initState() {
//     super.initState();
//     // Deep copy via JSON roundtrip
//     sectionCopy = SectionModel.fromJson(widget.section.toJson());
//     sectionCopy.fields ??= [];
//     sectionCopy.subSections ??= [];
//   }

//   void _reindexFields(List<FieldModel> fields) {
//     for (int i = 0; i < fields.length; i++) {
//       // Nothing in FieldModel for order, so no-op.
//       // If you add an 'order' to FieldModel, set it here.
//     }
//   }

//   void _reindexSubsections(List<SectionModel> subs) {
//     for (int i = 0; i < subs.length; i++) {
//       subs[i].order = i;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Reorder • ${sectionCopy.title}'),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.save),
//               onPressed: () => Navigator.pop(context, sectionCopy),
//               tooltip: 'Save',
//             ),
//           ],
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: 'Fields'),
//               Tab(text: 'Subsections'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             _buildFieldsTab(),
//             _buildSubsectionsTab(),
//           ],
//         ),
//       ),
//     );
//   }

//   // --------- TAB: SECTION FIELDS ----------
//   Widget _buildFieldsTab() {
//     final fields = sectionCopy.fields!;
//     if (fields.isEmpty) {
//       return const Center(child: Text('No fields to reorder in this section.'));
//     }

//     return ReorderableListView.builder(
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//       itemCount: fields.length,
//       onReorder: (oldIndex, newIndex) {
//         setState(() {
//           if (newIndex > oldIndex) newIndex -= 1;
//           final item = fields.removeAt(oldIndex);
//           fields.insert(newIndex, item);
//           _reindexFields(fields);
//         });
//       },
//       itemBuilder: (context, index) {
//         final f = fields[index];
//         return Card(
//           key: ValueKey('field_${index}_${f.label}_${f.dataType}'),
//           child: ListTile(
//             leading: const Icon(Icons.drag_indicator),
//             title: Text(f.label.isEmpty ? '(unnamed field)' : f.label),
//             subtitle: Text(_fieldTypeLabel(f)),
//             trailing: const Icon(Icons.unfold_more),
//           ),
//         );
//       },
//     );
//   }

//   String _fieldTypeLabel(FieldModel f) {
//     switch (f.dataType) {
//       case FieldDataType.text:
//         return 'Text';
//       case FieldDataType.number:
//         return 'Number';
//       case FieldDataType.date:
//         return 'Date';
//       case FieldDataType.dropdown:
//         return 'Dropdown';
//       case FieldDataType.checkbox:
//         return 'Checkbox (multi)';
//       case FieldDataType.radio:
//         return 'Radio (single)';
//       case FieldDataType.file:
//         return 'File';
//     }
//   }

//   // --------- TAB: SUBSECTIONS ----------
//   Widget _buildSubsectionsTab() {
//     final subs = sectionCopy.subSections!;
//     if (subs.isEmpty) {
//       return const Center(child: Text('No subsections to reorder in this section.'));
//     }

//     return ReorderableListView.builder(
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//       itemCount: subs.length,
//       onReorder: (oldIndex, newIndex) {
//         setState(() {
//           if (newIndex > oldIndex) newIndex -= 1;
//           final item = subs.removeAt(oldIndex);
//           subs.insert(newIndex, item);
//           _reindexSubsections(subs);
//         });
//       },
//       itemBuilder: (context, index) {
//         final ss = subs[index];
//         final fieldsCount = (ss.fields ?? const []).length;

//         return Card(
//           key: ValueKey('sub_${index}_${ss.title}_${ss.order}'),
//           child: ListTile(
//             leading: const Icon(Icons.drag_indicator),
//             title: Text(ss.title.isEmpty ? '(untitled subsection)' : ss.title),
//             subtitle: Text('Fields: $fieldsCount'),
//             trailing: Wrap(
//               spacing: 8,
//               children: [
//                 OutlinedButton.icon(
//                   icon: const Icon(Icons.swap_vert),
//                   label: const Text('Reorder Fields'),
//                   onPressed: () async {
//                     // Ensure non-null lists inside the subsection
//                     ss.fields ??= [];
//                     final updated = await Navigator.push<SectionModel>(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => SubsectionFieldsReorderPage(subSection: ss),
//                       ),
//                     );
//                     if (updated != null) {
//                       setState(() => sectionCopy.subSections![index] = updated);
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
