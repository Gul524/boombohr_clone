import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

class BottomNav extends StatelessWidget {
  final int index;
  const BottomNav({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: index,
      onDestinationSelected: (i) {
        final route = <String>[
          Routes.forms, Routes.create, Routes.responses, Routes.templates, Routes.settings
        ][i];
        Get.offAllNamed(route);
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.view_list), label: 'Forms'),
        NavigationDestination(icon: Icon(Icons.add_circle), label: 'Create'),
        NavigationDestination(icon: Icon(Icons.inbox), label: 'Responses'),
        NavigationDestination(icon: Icon(Icons.dashboard_customize), label: 'Templates'),
        NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
