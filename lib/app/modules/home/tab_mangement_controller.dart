// tab_management_controller.dart
import 'package:demo_app/app/data/models/models.dart';
import 'package:demo_app/app/modules/home/tab_controller.dart';
import 'package:get/get.dart';

class TabManagementController extends GetxController {
  late AppTabController appTabs;
  final RxList<TabModel> visibleTabs = <TabModel>[].obs;
  final RxList<TabModel> hiddenTabs = <TabModel>[].obs;

  TabManagementController({required this.appTabs});

  void categorizeTabs() {
    visibleTabs.assignAll(appTabs.tabs
        .where((tab) => tab.visibility.value == TabVisibility.visible)
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order)));

    hiddenTabs.assignAll(appTabs.tabs
        .where((tab) => tab.visibility.value == TabVisibility.hidden)
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order)));
  }

  void reorderTabs(int oldIndex, int newIndex, TabVisibility fromCategory,
      TabVisibility toCategory) {
    if (oldIndex < newIndex) newIndex -= 1;

    TabModel movedTab;
    List<TabModel> sourceList;

    switch (fromCategory) {
      case TabVisibility.visible:
        movedTab = visibleTabs.removeAt(oldIndex);
        sourceList = visibleTabs;
        break;
      case TabVisibility.hidden:
        movedTab = hiddenTabs.removeAt(oldIndex);
        sourceList = hiddenTabs;
        break;
    }

    final updatedTab = movedTab.copyWith(visibility: toCategory.obs);

    switch (toCategory) {
      case TabVisibility.visible:
        visibleTabs.insert(newIndex, updatedTab);
        break;
      case TabVisibility.hidden:
        hiddenTabs.insert(newIndex, updatedTab);
        break;
    }

    final index =
        appTabs.tabs.indexWhere((tab) => tab.tabName == movedTab.tabName);
    if (index != -1) {
      appTabs.tabs[index] = updatedTab;
    }

    _updateOrders();
    appTabs.tabs.refresh();
    visibleTabs.refresh();
    hiddenTabs.refresh();
  }

  void _updateOrders() {
    // Update order for visible tabs
    for (int i = 0; i < visibleTabs.length; i++) {
      final index = appTabs.tabs
          .indexWhere((tab) => tab.tabName == visibleTabs[i].tabName);
      if (index != -1) {
        appTabs.tabs[index] = appTabs.tabs[index].copyWith(order: i);
      }
    }

    // Update order for hidden tabs
    for (int i = 0; i < hiddenTabs.length; i++) {
      final index = appTabs.tabs
          .indexWhere((tab) => tab.tabName == hiddenTabs[i].tabName);
      if (index != -1) {
        appTabs.tabs[index] = appTabs.tabs[index].copyWith(order: i + 1000);
      }
    }
  }

  /// Call this on save to merge visible and hidden tabs into appTabs.tabs
  void onSaveTabs() {
    final mergedTabs = <TabModel>[];
    mergedTabs.addAll(visibleTabs);
    mergedTabs.addAll(hiddenTabs);
    appTabs.tabs.assignAll(mergedTabs);
    appTabs.tabs.refresh();
  }

  void createCustomTab(String name) {
    final newTab = TabModel(
      tabName: name,
      sections: [],
      isCustom: true,
      visibility: Rx(TabVisibility.visible),
      order: visibleTabs.length,
    );

    visibleTabs.add(newTab);
    categorizeTabs();
  }

  void deleteCustomTab(TabModel tab) {
    if (tab.isCustom) {
      appTabs.tabs.removeWhere((t) => t.tabName == tab.tabName);
      categorizeTabs();
    }
  }

  void renameCustomTab(TabModel tab, String newName) {
    if (tab.isCustom) {
      final index = appTabs.tabs.indexWhere((t) => t.tabName == tab.tabName);
      if (index != -1) {
        appTabs.tabs[index] = appTabs.tabs[index].copyWith(tabName: newName);
        categorizeTabs();
      }
    }
  }

  void restoreTab(TabModel tab) {
    final index = appTabs.tabs.indexWhere((t) => t.tabName == tab.tabName);
    if (index != -1) {
      appTabs.tabs[index] =
          appTabs.tabs[index].copyWith(visibility: TabVisibility.hidden.obs);
      categorizeTabs();
    }
  }
}
