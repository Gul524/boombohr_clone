import 'package:demo_app/app/modules/home/app_bar_widget.dart';
import 'package:demo_app/app/modules/home/drawer_widget.dart';
import 'package:demo_app/app/modules/home/home_controller.dart';
import 'package:demo_app/app/modules/home/tabWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/main";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = HomeController();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return DefaultTabController(
      length: controller.tabModels.length,
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F2F5),
        drawer: const DrawerWidget(),
        body: Obx(
          () => CustomScrollView(
            slivers: <Widget>[
              AppBarWidget(
                  controller: controller,
                  tabs: List.generate(
                      controller.tabModels.length,
                      (i) => Tab(
                            text: controller.tabModels.value[i].value.title,
                          ))),
              SliverFillRemaining(
                child: TabBarView(
                    children: List.generate(
                        controller.tabModels.length,
                        (i) => Obx(() => TabWidget(
                            tab: controller.tabModels.value[i].value)))),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   selectedItemColor: Colors.green,
        //   unselectedItemColor: Colors.grey,
        //   backgroundColor: Colors.white,
        //   items: const [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.people),
        //       label: 'People',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.access_time),
        //       label: 'Time',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.description),
        //       label: 'Reports',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.more_horiz),
        //       label: 'More',
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
