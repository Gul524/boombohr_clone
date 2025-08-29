import 'package:demo_app/app/data/models/models.dart';
import 'package:demo_app/app/modules/home/tabWidget.dart';
import 'package:demo_app/app/modules/home/app_bar_widget.dart';
import 'package:demo_app/app/modules/home/drawer_widget.dart';
import 'package:demo_app/app/modules/home/home_controller.dart';
import 'package:demo_app/app/modules/home/tab_controller.dart';
import 'package:demo_app/app/modules/home/tab_mangement_controller.dart';
// import 'package:demo_app/app/theme/app_theme.dart';
import 'package:flutter/material.dart' hide TabController;
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/main";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProfileController controller;
  final TabManagementController tabManagementController = Get.find();
  final AppTabController tabController = Get.find();

  @override
  void initState() {
    super.initState();
    controller = ProfileController();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !tabController.ishiddenTabSelected.value,
      onPopInvokedWithResult: (Value, _) {
        if (tabController.ishiddenTabSelected.value) {
          tabController.ishiddenTabSelected.value = false;
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F2F5),
        drawer: const DrawerWidget(),
        body: Obx(
          () => DefaultTabController(
            length: tabController.tabs
                    .where((t) => t.visibility == TabVisibility.visible)
                    .length +
                1,
            child: CustomScrollView(
              slivers: <Widget>[
                AppBarWidget(controller: controller, tabs: [
                  ...tabController.tabs
                      .where((t) => t.visibility == TabVisibility.visible)
                      .map((i) => Tab(text: i.tabName)),
                  Tab(
                    child: _buildMoreTab(),
                  )
                ]),
                SliverFillRemaining(
                    child: Obx(
                  () => Stack(
                    children: [
                      TabBarView(children: [
                        ...tabController.tabs
                            .where((t) => t.visibility == TabVisibility.visible)
                            .map((e) => TabWidget(tab: e)),
                        const SizedBox.shrink()
                      ]),
                      if (tabController.ishiddenTabSelected.value)
                        ColoredBox(
                            color: const Color(0xFFF0F2F5),
                            child:
                                TabWidget(tab: tabController.currentHiddenTab!))
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoreTab() {
    return PopupMenuButton<TabModel>(
      itemBuilder: (context) => tabController.tabs
          .where((t) => t.visibility == TabVisibility.hidden)
          .map((tab) => PopupMenuItem(
                value: tab,
                child: Text(tab.tabName),
              ))
          .toList(),
      onSelected: (tab) {
        tabController.currentHiddenTab = tab;
        tabController.ishiddenTabSelected.value = true;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: const Text(
          'More',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  // Widget _buildTabItem(String title, int index, Function()? onTap) {
  //   return GestureDetector(
  //     onTap: () => setState(() => _selectedTabIndex.value = index),
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //       decoration: BoxDecoration(
  //         border: Border(
  //           bottom: BorderSide(
  //             color: _selectedTabIndex == index
  //                 ? AppTheme.primary
  //                 : Colors.transparent,
  //             width: 2,
  //           ),
  //         ),
  //       ),
  //       child: Text(
  //         title,
  //         style: TextStyle(
  //           color: _selectedTabIndex == index
  //               ? AppTheme.primary
  //               : Colors.grey.shade600,
  //           fontWeight: _selectedTabIndex == index
  //               ? FontWeight.bold
  //               : FontWeight.normal,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _handleMoreOption(String option) {
    switch (option) {
      case 'profile':
        // Handle profile action
        break;
      case 'settings':
        // Handle settings action
        break;
      case 'logout':
        // Handle logout action
        break;
    }
  }

//   Widget _buildTabContent() {
//     return TabWidget(
//       tab: tabController.tabs[_selectedTabIndex.value],

//       },
//     );
//   }
}
