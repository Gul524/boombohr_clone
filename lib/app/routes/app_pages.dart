import 'package:demo_app/app/modules/home/home_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static final initial = HomeScreen.routeName;

  static final routes = <GetPage>[
    GetPage(name: HomeScreen.routeName, page: () => const HomeScreen()),
  ];
}
