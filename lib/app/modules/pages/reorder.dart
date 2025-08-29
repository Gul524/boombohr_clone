// reorder_page.dart
import 'package:demo_app/app/data/models/models.dart';
import 'package:demo_app/app/modules/home/tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReorderPage extends StatelessWidget {
  final AppTabController tabController = Get.find();
  final Rx<TabModel> editedTab = TabModel(
          tabName: '',
          sections: [],
          visibility: Rx(TabVisibility.visible),
          order: 0)
      .obs;

  ReorderPage({super.key, required TabModel tab}) {
    // 🔹 Clone the tab into local reactive buffer
    editedTab.value = tab.copyWith(
      sections: tab.sections.map((s) => s.copyWith()).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reorder Fields'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(), // 🔹 cancel = discard changes
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reorder/delete items. Changes are temporary until you press Save.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  final tab = editedTab.value;
                  return ReorderableListView(
                    children: tab.sections
                        .asMap()
                        .entries
                        .map(
                          (entry) => _buildSectionItem(
                            entry.key,
                            entry.value,
                            key: Key(
                                'section_${entry.value.sectionName}_${entry.key}'),
                          ),
                        )
                        .toList(),
                    onReorder: (oldIndex, newIndex) {
                      if (newIndex > oldIndex) newIndex--;
                      final section = tab.sections.removeAt(oldIndex);
                      tab.sections.insert(newIndex, section);
                      editedTab.refresh();
                    },
                  );
                }),
              ),
              const SizedBox(height: 20),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionItem(int sectionIndex, Section section, {Key? key}) {
    return Card(
      key: key,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    section.sectionName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    editedTab.value.sections.removeAt(sectionIndex);
                    editedTab.refresh();
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...section.subSections.asMap().entries.map((entry) =>
                _buildSubSectionItem(sectionIndex, entry.key, entry.value)),
            if (section.fields.isNotEmpty) ...[
              const SizedBox(height: 8),
              ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: section.fields
                    .asMap()
                    .entries
                    .map((entry) => _buildFieldItem(
                          sectionIndex,
                          entry.key,
                          entry.value,
                          key: Key('field_${entry.value.fieldKey}'),
                        ))
                    .toList(),
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) newIndex--;
                  final field = section.fields.removeAt(oldIndex);
                  section.fields.insert(newIndex, field);
                  editedTab.refresh();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSubSectionItem(
      int sectionIndex, int subSectionIndex, SubSection subSection) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(subSection.name,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                editedTab.value.sections[sectionIndex].subSections
                    .removeAt(subSectionIndex);
                editedTab.refresh();
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: subSection.fields
              .asMap()
              .entries
              .map((entry) => _buildFieldItem(
                    sectionIndex,
                    entry.key,
                    entry.value,
                    subSectionIndex: subSectionIndex,
                    key: Key('field_${entry.value.fieldKey}'),
                  ))
              .toList(),
          onReorder: (oldIndex, newIndex) {
            if (newIndex > oldIndex) newIndex--;
            final field = subSection.fields.removeAt(oldIndex);
            subSection.fields.insert(newIndex, field);
            editedTab.refresh();
          },
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildFieldItem(
    int sectionIndex,
    int fieldIndex,
    Field field, {
    int? subSectionIndex,
    Key? key,
  }) {
    return ListTile(
      key: key,
      leading: const Icon(Icons.drag_handle, color: Colors.grey),
      title: Text(field.fieldName),
      subtitle: Text('(${field.fieldType})'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_upward, size: 18),
            onPressed: () {
              if (fieldIndex > 0) {
                final fields = subSectionIndex != null
                    ? editedTab.value.sections[sectionIndex]
                        .subSections[subSectionIndex].fields
                    : editedTab.value.sections[sectionIndex].fields;
                final item = fields.removeAt(fieldIndex);
                fields.insert(fieldIndex - 1, item);
                editedTab.refresh();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_downward, size: 18),
            onPressed: () {
              final fields = subSectionIndex != null
                  ? editedTab.value.sections[sectionIndex]
                      .subSections[subSectionIndex].fields
                  : editedTab.value.sections[sectionIndex].fields;
              if (fieldIndex < fields.length - 1) {
                final item = fields.removeAt(fieldIndex);
                fields.insert(fieldIndex + 1, item);
                editedTab.refresh();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              if (subSectionIndex != null) {
                editedTab.value.sections[sectionIndex]
                    .subSections[subSectionIndex].fields
                    .removeAt(fieldIndex);
              } else {
                editedTab.value.sections[sectionIndex].fields
                    .removeAt(fieldIndex);
              }
              editedTab.refresh();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () => Get.back(), // Cancel = discard
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            // Save changes back to controller
            final index = tabController.tabs
                .indexWhere((t) => t.tabName == editedTab.value.tabName);
            if (index != -1) {
              tabController.tabs[index] = editedTab.value;
              tabController.tabs.refresh();
            }
            Get.back();
          },
          child: const Text('Save Changes'),
        ),
      ],
    );
  }
}
