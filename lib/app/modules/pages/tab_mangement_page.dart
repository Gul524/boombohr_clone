// tab_management_page.dart
import 'package:demo_app/app/data/models/models.dart';
import 'package:demo_app/app/modules/home/tab_mangement_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabManagementPage extends StatefulWidget {
  TabManagementPage({super.key});

  @override
  State<TabManagementPage> createState() => _TabManagementPageState();
}

class _TabManagementPageState extends State<TabManagementPage> {
  late TabManagementController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.find<TabManagementController>();
    controller.categorizeTabs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reorder Employee Record Tabs'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInstructions(),
                const SizedBox(height: 24),
                _buildNewCustomTabButton(),
                const SizedBox(height: 24),
                _buildVisibleTabsSection(),
                const SizedBox(height: 24),
                _buildHiddenTabsSection(),
                const SizedBox(height: 32),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• Drag chips to change the order of visible tabs.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          '• Drag a chip into Hidden to show it under More.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          '• Drag a hidden item back to the green bar to show it again.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          '• Use Archive to hide a tab from everywhere; restore from Add Tabs.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          '• Locked tabs can be moved to Hidden, but cannot be archived or deleted.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          '• Custom tabs can be renamed or deleted.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildVisibleTabsSection() {
    return Obx(
      () => _buildTabCategory(
        title: 'Visible Tabs',
        tabs: controller.visibleTabs.value,
        category: TabVisibility.visible,
        backgroundColor: Colors.green.shade100,
      ),
    );
  }

  Widget _buildHiddenTabsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hidden Tabs (shown under "More")',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Obx(() => _buildTabCategory(
              tabs: controller.hiddenTabs.value,
              category: TabVisibility.hidden,
              backgroundColor: Colors.grey.shade200,
              title: '',
            )),
      ],
    );
  }

  Widget _buildTabCategory({
    required String title,
    required List<TabModel> tabs,
    required TabVisibility category,
    required Color backgroundColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(right: 50),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) ...[
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
          ],
          DragTarget<TabModel>(
            builder: (context, candidateData, rejectedData) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: tabs.isEmpty ? 50 : 0,
                ),
                child: tabs.isEmpty
                    ? const Center(child: Text('Drag tabs here'))
                    : ReorderableListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: tabs
                            .asMap()
                            .entries
                            .map((entry) =>
                                _buildTabChip(entry.value, entry.key, category))
                            .toList(),
                        onReorder: (oldIndex, newIndex) {
                          controller.reorderTabs(
                              oldIndex, newIndex, category, category);
                        },
                      ),
              );
            },
            onAcceptWithDetails: (tab) {
              final fromCategory = tab.data.visibility.value;
              controller.reorderTabs(
                _findTabIndex(tab.data, fromCategory),
                0,
                fromCategory,
                category,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabChip(TabModel tab, int index, TabVisibility currentCategory) {
    return Draggable<TabModel>(
      key: Key('${tab.tabName}_$index'),
      data: tab,
      feedback: Material(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(tab.tabName),
        ),
      ),
      childWhenDragging: Container(),
      child: LongPressDraggable<TabModel>(
        data: tab,
        feedback: Material(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(tab.tabName),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(tab.tabName),
              if (tab.isCustom) ...[
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.edit, size: 16),
                  onPressed: () => _showRenameDialog(tab),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 16, color: Colors.red),
                  onPressed: () => _showDeleteDialog(tab),
                ),
              ],
              if (tab.isLocked) const Icon(Icons.lock, size: 12),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildAddTabsButton() {
  //   return ElevatedButton.icon(
  //     onPressed: _showAddTabsDialog,
  //     icon: const Icon(Icons.add),
  //     label: const Text('Add Tabs'),
  //   );
  // }

  Widget _buildNewCustomTabButton() {
    return ElevatedButton.icon(
      onPressed: _showCreateCustomTabDialog,
      icon: const Icon(Icons.add),
      label: const Text('New Custom Tab'),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            controller.onSaveTabs();
            Get.back();
          },
          child: const Text('Done'),
        ),
      ],
    );
  }

  int _findTabIndex(TabModel tab, TabVisibility category) {
    switch (category) {
      case TabVisibility.visible:
        return controller.visibleTabs
            .indexWhere((t) => t.tabName == tab.tabName);
      case TabVisibility.hidden:
        return controller.hiddenTabs
            .indexWhere((t) => t.tabName == tab.tabName);
    }
  }

  void _showRenameDialog(TabModel tab) {
    final TextEditingController controller =
        TextEditingController(text: tab.tabName);

    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text('Rename Tab'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Tab Name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                this.controller.renameCustomTab(tab, controller.text);
                Get.back();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(TabModel tab) {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text('Delete Tab'),
        content: Text('Are you sure you want to delete "${tab.tabName}"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deleteCustomTab(tab);
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showAddTabsDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text('Add Tabs'),
        content: SizedBox(
          width: double.maxFinite,
          child: Obx(() => ListView(
                shrinkWrap: true,
                children: controller.appTabs.tabs
                    .map((tab) => ListTile(
                          title: Text(tab.tabName),
                          trailing: ElevatedButton(
                            onPressed: () => controller.restoreTab(tab),
                            child: const Text('Restore'),
                          ),
                        ))
                    .toList(),
              )),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showCreateCustomTabDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text('New Custom Tab'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Custom Tab Name*',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'e.g., Certifications',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Don\'t worry, people won\'t see this new tab yet. For now, only admins will see this tab. When you\'re ready, go to Access Levels to give additional access.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                this.controller.createCustomTab(controller.text);
                Get.back();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
