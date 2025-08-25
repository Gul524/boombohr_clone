import 'package:get/get.dart';
import '../modules/forms/views/forms_view.dart';
part 'app_routes.dart';

class AppPages {
  static const initial = Routes.forms;
  static final routes = <GetPage>[
    GetPage(name: Routes.forms, page: () => const FormsView()),
  ];
}
