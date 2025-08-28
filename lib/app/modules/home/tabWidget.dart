import 'package:demo_app/app/data/models/models.dart';
import 'package:demo_app/app/modules/pages/add_tables.dart';
import 'package:demo_app/app/modules/pages/add_fileds.dart';
import 'package:demo_app/app/modules/pages/reorder.dart';
import 'package:demo_app/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabWidget extends StatelessWidget {
  final TabModel tab;

  const TabWidget({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                tab.icon,
                color: AppTheme.primary,
                size: 24, // Decreased by 6px from default icon size
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                tab.title,
                style: const TextStyle(
                  fontSize: 20, // Decreased by 6px from 22
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary,
                ),
              ),
              const Spacer(),
              PopupMenuButton<String>(
                onSelected: (value) {
                  // Handle menu actions here
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'reorder',
                    child: const Text("ReOrder Fields",
                        style: TextStyle(fontSize: 14)), // Decreased by 6px
                    onTap: () {
                      Get.to(() => ReorderPage(tab: tab));
                    },
                  ),
                  PopupMenuItem(
                    value: 'addField',
                    child: const Text("Add Custom Field",
                        style: TextStyle(fontSize: 14)), // Decreased by 6px
                    onTap: () {
                      Get.to(() => AddFieldPage(tab: tab));
                    },
                  ),
                  PopupMenuItem(
                    value: 'addTable',
                    child: const Text("Add Custom Table",
                        style: TextStyle(fontSize: 14)), // Decreased by 6px
                    onTap: () {
                      Get.to(() => AddTablePage(
                            tabModel: tab,
                            onTableAdded: (tab) {},
                          ));
                    },
                  ),
                ],
                child: const Text(
                  "Customize Layout",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                      fontSize: 14), // Decreased by 6px
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: _buildContent(context)),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (tab.tabType) {
      case TabType.form:
        return _buildFormTab(context);
      case TabType.notes:
        return _buildNotesTab(context);
      case TabType.documents:
        return _buildDocumentsTab(context);
    }
  }

  // ---------- FORM TAB ----------
  Widget _buildFormTab(BuildContext context) {
    return ListView(
      children:
          tab.sections?.map((section) => _buildSection(section)).toList() ?? [],
    );
  }

  Widget _buildSection(SectionModel section) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(section.icon,
                      color: AppTheme.primary, size: 22), // Decreased by 6px
                  const SizedBox(width: 8),
                  Text(section.title,
                      style: const TextStyle(
                          fontSize: 18, // Decreased by 6px from 18
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),

              // Subsections
              if (section.subSections != null)
                ...section.subSections!.map((sub) => Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            const Icon(Icons.subdirectory_arrow_right,
                                color: Colors.blue,
                                size: 18), // Decreased by 6px
                            const SizedBox(width: 6),
                            Text(sub.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14)), // Decreased by 6px
                          ]),
                          const SizedBox(height: 6),
                          ...?sub.fields?.map(_buildField),
                        ],
                      ),
                    )),

              // Fields in section
              ...?section.fields?.map((e) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        _buildField(e),
                      ],
                    ),
                  )),

              // Tables
              ...?section.tables?.map((e) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildTable(e),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(FieldModel field) {
    final label = Row(
      children: [
        Text(
          field.label,
          style: const TextStyle(fontSize: 14), // Decreased by 6px
        ),
        if (field.isRequired == true)
          const Text(
            ' *',
            style:
                TextStyle(color: Colors.red, fontSize: 14), // Decreased by 6px
          ),
      ],
    );

    switch (field.dataType) {
      case FieldDataType.text:
      case FieldDataType.number:
      case FieldDataType.date:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label,
            const SizedBox(height: 4),
            TextField(
              decoration: InputDecoration(
                  isDense: true,
                  hintText: field.hint,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
          ],
        );
      case FieldDataType.dropdown:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label,
            const SizedBox(height: 4),
            DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
                items: field.options
                    ?.map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e,
                            style: const TextStyle(
                                fontSize: 14)))) // Decreased by 6px
                    .toList(),
                onChanged: (v) {},
                dropdownColor: Colors.white,
                elevation: 4,
                borderRadius: BorderRadius.circular(4),
                selectedItemBuilder: (BuildContext context) {
                  return field.options!.map<Widget>((String item) {
                    return Text(
                      item,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }).toList();
                }),
          ],
        );
      case FieldDataType.checkbox:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label,
            const SizedBox(height: 4),
            ...?field.options?.map((e) {
                  Rx<bool> selection = false.obs;
                  return Obx(
                    () => CheckboxListTile(
                      value: selection.value,
                      onChanged: (v) {
                        selection.value = v ?? false;
                      },
                      title: Text(e,
                          style: const TextStyle(
                              fontSize: 14)), // Decreased by 6px
                    ),
                  );
                }).toList() ??
                [],
          ],
        );
      case FieldDataType.radio:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label,
            const SizedBox(height: 4),
            ...?field.options?.map((e) {
                  return Obx(
                    () => RadioListTile(
                      value: field.value,
                      groupValue: field.options,
                      onChanged: (v) {
                        field.value = e;
                      },
                      title: Text(e,
                          style: const TextStyle(
                              fontSize: 14)), // Decreased by 6px
                    ),
                  );
                }).toList() ??
                [],
          ],
        );
      case FieldDataType.file:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label,
            const SizedBox(height: 4),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.upload_file, size: 18), // Decreased by 6px
              label: Text(field.hint ?? "Upload",
                  style: const TextStyle(fontSize: 14)), // Decreased by 6px
            ),
          ],
        );
    }
  }

  Widget _buildTable(TableModel table) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(table.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10)), // Decreased by 6px from 16
            ElevatedButton(
              onPressed: () {},
              child: Text("Add ${table.rowLabel}",
                  style: const TextStyle(fontSize: 12)), // Decreased by 6px
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Column(
            children: [
              // Table header
              Row(
                children: [
                  ...table.columns.map((c) => Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(c,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12)), // Decreased by 6px
                      ))),
                  const SizedBox(
                      width: 50,
                      child: Text("Action",
                          style: TextStyle(fontSize: 12))), // Decreased by 6px
                ],
              ),
              // Rows
              ...table.rows.map((row) {
                return Row(
                  children: [
                    ...row.map((f) => Expanded(child: _buildField(f))),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit,
                                color: Colors.blue,
                                size: 18)), // Decreased by 6px
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete,
                                color: Colors.red,
                                size: 18)), // Decreased by 6px
                      ],
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  // ---------- NOTES TAB ----------
  Widget _buildNotesTab(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(children: [
                  CircleAvatar(
                      radius: 16, // Decreased by 6px
                      child: Text(tab.title.substring(0, 2).toUpperCase(),
                          style: const TextStyle(
                              fontSize: 12))), // Decreased by 6px
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: "Write a note...",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text("Clear",
                            style:
                                TextStyle(fontSize: 12))), // Decreased by 6px
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text("Post",
                            style:
                                TextStyle(fontSize: 12))), // Decreased by 6px
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView(
            children: tab.notes?.map((n) {
                  return ListTile(
                    leading:
                        const Icon(Icons.note, size: 18), // Decreased by 6px
                    title: Text(n.text,
                        style:
                            const TextStyle(fontSize: 14)), // Decreased by 6px
                    subtitle: Text(n.dateTime.toString(),
                        style:
                            const TextStyle(fontSize: 12)), // Decreased by 6px
                  );
                }).toList() ??
                [],
          ),
        )
      ],
    );
  }

  // ---------- DOCUMENT TAB ----------
  Widget _buildDocumentsTab(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.folder,
                color: AppTheme.primary, size: 18), // Decreased by 6px
            const SizedBox(width: 6),
            Text(tab.title,
                style: const TextStyle(
                    fontSize: 12, // Decreased by 6px from 18
                    fontWeight: FontWeight.bold)),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white),
              icon: const Icon(Icons.upload_file, size: 16), // Decreased by 6px
              label: const Text("Upload",
                  style: TextStyle(fontSize: 12)), // Decreased by 6px
            ),
            IconButton(
                onPressed: () {},
                icon:
                    const Icon(Icons.grid_view, size: 18)), // Decreased by 6px
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.list, size: 18)), // Decreased by 6px
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.search, size: 18), // Decreased by 6px
                  hintText: "Search file/folder",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 6),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.download, size: 18)), // Decreased by 6px
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView(
            children: tab.documents?.map((doc) {
                  return Card(
                    child: ListTile(
                      leading: Icon(
                          doc.type == DocumentType.file
                              ? Icons.insert_drive_file
                              : Icons.folder,
                          size: 18), // Decreased by 6px
                      title: Text(doc.name,
                          style: const TextStyle(
                              fontSize: 14)), // Decreased by 6px
                      trailing: doc.type == DocumentType.file
                          ? IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.download,
                                  size: 18)) // Decreased by 6px
                          : null,
                    ),
                  );
                }).toList() ??
                [],
          ),
        ),
      ],
    );
  }
}
