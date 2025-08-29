import 'package:demo_app/app/modules/home/home_controller.dart';
import 'package:demo_app/app/modules/home/profile_header.dart';
import 'package:demo_app/app/modules/home/tab_controller.dart';
import 'package:demo_app/app/modules/pages/tab_mangement_page.dart';
import 'package:demo_app/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.controller,
    required this.tabs,
  });

  final ProfileController controller;
  final List<Tab> tabs;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppTheme.scondary,
      foregroundColor: Colors.black,
      expandedHeight: 250.0,
      pinned: true,
      floating: false,
      snap: false,
      title: const Text('Dolor Software'),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: const BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: const Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => Get.to(() => TabManagementPage()),
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: ProfileHeader(controller: controller),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 0),
        child: ColoredBox(
          color: Colors.white,
          child: TabBar(
            onTap: (value) {
              final AppTabController tabController = Get.find();
              tabController.ishiddenTabSelected.value = false;
            },
            isScrollable: true,
            labelColor: AppTheme.primary,
            unselectedLabelColor: Colors.black,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: AppTheme.primaryDim,
            ),
            tabs: tabs,
          ),
        ),
      ),
    );
  }
}
