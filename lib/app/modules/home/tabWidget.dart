import 'package:demo_app/app/data/models/models.dart';
import 'package:demo_app/app/modules/home/customize_menu.dart';
import 'package:demo_app/app/modules/home/tabWidgetController.dart';
import 'package:demo_app/app/modules/sections/form.dart';
import 'package:demo_app/app/modules/sections/list_section.dart';
import 'package:demo_app/app/modules/sections/table_section.dart';

import 'package:flutter/material.dart' hide Table;
import 'package:get/get.dart';
class TabWidget extends StatelessWidget {
  final TabModel tab;

  const TabWidget({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabControllerX>(
      init: TabControllerX(tab),
      builder: (controller) => Column(
        children: [
          // Header + Customize
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tab.tabName,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomizeMenu(tab: tab),
              ],
            ),
          ),

          // Sections
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: tab.sections.map((section) {
                  switch (section.sectionType) {
                    case 'form':
                      return FormSection(section: section, controller: controller);
                    case 'list':
                      return ListSection(section: section, controller: controller);
                    case 'table':
                      return TableSection(section: section, controller: controller);
                    default:
                      return const SizedBox.shrink();
                  }
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

