import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_app/app/data/models/models.dart';
import 'package:demo_app/app/modules/pages/add_fileds.dart';
import 'package:demo_app/app/modules/pages/add_tables.dart';
import 'package:demo_app/app/modules/pages/reorder.dart';

class CustomizeMenu extends StatelessWidget {
  final TabModel tab;
  const CustomizeMenu({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    if (tab.tabName == 'Time Off' || tab.tabName == 'Onboarding' || tab.tabName == 'Offboarding') {
      return _settingsMenu();
    }
    return _customizeMenu();
  }

  Widget _customizeMenu() {
    return PopupMenuButton<String>(
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'reorder', child: Text('Reorder Fields')),
        PopupMenuItem(value: 'add_custom_field', child: Text('Add Custom Field')),
        PopupMenuItem(value: 'add_custom_table', child: Text('Add Custom Table')),
      ],
      onSelected: (value) {
        switch (value) {
          case 'reorder':
            Get.to(() => ReorderPage(tab: tab));
            break;
          case 'add_custom_field':
            Get.to(() => AddFieldPage(tabName: tab.tabName));
            break;
          case 'add_custom_table':
            Get.to(() => AddTablePage(tabName: tab.tabName));
            break;
        }
      },
      child: const Text(
        'Customize Layout',
        style: TextStyle(
          fontSize: 16,
          color: Colors.blue,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _settingsMenu() {
    return PopupMenuButton<String>(
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'accrual_level', child: Text('Accrual Level Start Date')),
        PopupMenuItem(value: 'add_policy', child: Text('Add Time Off Policy')),
        PopupMenuItem(value: 'pause_accruals', child: Text('Pause Accruals')),
      ],
      onSelected: (value) {
        // Handle specific logic
      },
      child: const Text(
        'Settings',
        style: TextStyle(
          fontSize: 16,
          color: Colors.blue,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
