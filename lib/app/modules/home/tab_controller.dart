// tab_controller.dart
import 'package:demo_app/app/data/models/models.dart';
import 'package:demo_app/app/data/models/static_tabs.dart';
import 'package:demo_app/app/data/repositories/repository.dart';
import 'package:get/get.dart';

class AppTabController extends GetxController {
  final Repository repo = Repository();
  RxList<TabModel> tabs = <TabModel>[].obs;
  TabModel? currentTab;
  TabModel? currentHiddenTab;
  Rx<bool> ishiddenTabSelected = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTabs();
  }

  void loadTabs() {
    final list = repo.getForms();
    tabs = (list).obs;
    if (list.isEmpty) {
      tabs = (PredefinedTabs.generatePredefinedTabs()).obs;
    }
  }

  void saveTabs() {
    repo.setTabs(tabs);
  }

  void updateTab(TabModel updatedTab) {
    tabs.refresh();
  }

  // void reorderSections(
  //   int oldIndex,
  //   int newIndex,
  // ) {
  //   if (oldIndex < newIndex) {
  //     newIndex -= 1;
  //   }
  //   final sections = currentTab!.sections;
  //   final item = sections.removeAt(oldIndex);
  //   sections.insert(newIndex, item);
  //   sections.refresh();
  // }

  // void reorderFields(int sectionIndex, int oldIndex, int newIndex) {
  //   if (oldIndex < newIndex) {
  //     newIndex -= 1;
  //   }
  //   final fields = currentTab!.sections[sectionIndex].fields;
  //   final item = fields.removeAt(oldIndex);
  //   fields.insert(newIndex, item);
  //   fields.refresh();
  // }

  void addCustomField({
    required String sectionName,
    required String tabName,
    required String subSectionName,
    required String fieldName,
    required String fieldKey,
    required String fieldType,
    String? placeholder,
    bool isRequired = false,
  }) {
    final sectionIndex =
        tabs.where((t) => t.tabName == tabName).first.sections.indexWhere(
              (s) => s.sectionName == sectionName,
            );

    if (sectionIndex != -1) {
      final section = currentTab!.sections[sectionIndex];
      final subSectionIndex = section.subSections.indexWhere(
        (sub) => sub.name == subSectionName,
      );

      final newField = Field(
        fieldName: fieldName,
        fieldKey: fieldKey,
        fieldType: fieldType,
        placeholder: placeholder,
        isRequired: isRequired,
        isEditable: true,
      );

      if (subSectionIndex != -1) {
        section.subSections[subSectionIndex].fields.add(newField);
        section.subSections.refresh();
      } else {
        // Add to main section fields if no subsection
        section.fields.add(newField);
        section.fields.refresh();
      }

      tabs.refresh();
    }
  }

  void addCustomTable({
    required String tabName,
    required String tableName,
    required String dataKey,
    required List<TableColumn> columns,
    required String addButtonLabel,
  }) {
    final newSection = Section(
      sectionName: tableName,
      sectionType: 'table',
      table: TableModel(
          feildEntryButton: addButtonLabel,
          columns: columns,
          rows: []),
      items: [],
      isCustomSection: true,
      fields: [],
    );

    tabs.where((t) => t.tabName == tabName).first.sections.add(newSection);
    tabs.refresh();
  }

  void addRepeatableSection(String tabName, String sectionName) {
    final tabIndex = tabs.indexWhere((tab) => tab.tabName == tabName);
    if (tabIndex != -1) {
      final sectionIndex = tabs[tabIndex].sections.indexWhere(
            (section) => section.sectionName == sectionName,
          );

      if (sectionIndex != -1) {
        final section = tabs[tabIndex].sections[sectionIndex];
        section.repeatedSections.add({});
        tabs.refresh();
      }
    }
  }

  void removeRepeatableSection(String tabName, String sectionName, int index) {
    final tabIndex = tabs.indexWhere((tab) => tab.tabName == tabName);
    if (tabIndex != -1) {
      final sectionIndex = tabs[tabIndex].sections.indexWhere(
            (section) => section.sectionName == sectionName,
          );

      if (sectionIndex != -1) {
        final section = tabs[tabIndex].sections[sectionIndex];
        if (section.repeatedSections.length > 1) {
          section.repeatedSections.removeAt(index);
          tabs.refresh();
        }
      }
    }
  }

  void addTableEntry(
      String tabName, String sectionName, Map<String, dynamic> entry) {
    final tabIndex = tabs.indexWhere((tab) => tab.tabName == tabName);
    if (tabIndex != -1) {
      final sectionIndex = tabs[tabIndex].sections.indexWhere(
            (section) => section.sectionName == sectionName,
          );

      if (sectionIndex != -1) {
        tabs[tabIndex].sections[sectionIndex].items.add(entry);
        tabs.refresh();
      }
    }
  }

  void reorderSections(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final section =
        tabs[0].sections.removeAt(oldIndex); // example for first tab
    tabs[0].sections.insert(newIndex, section);
    tabs.refresh(); // 🔑 force rebuild
  }

  void reorderFields(int sectionIndex, int oldIndex, int newIndex,
      {int? subSectionIndex}) {
    if (newIndex > oldIndex) newIndex--;

    if (subSectionIndex != null) {
      final fields =
          tabs[0].sections[sectionIndex].subSections[subSectionIndex].fields;
      final field = fields.removeAt(oldIndex);
      fields.insert(newIndex, field);
    } else {
      final fields = tabs[0].sections[sectionIndex].fields;
      final field = fields.removeAt(oldIndex);
      fields.insert(newIndex, field);
    }

    tabs.refresh(); // 🔑 update UI immediately
  }

  void removeField(int sectionIndex, int fieldIndex, {int? subSectionIndex}) {
    if (subSectionIndex != null) {
      tabs[0]
          .sections[sectionIndex]
          .subSections[subSectionIndex]
          .fields
          .removeAt(fieldIndex);
    } else {
      tabs[0].sections[sectionIndex].fields.removeAt(fieldIndex);
    }
    tabs.refresh();
  }
}
