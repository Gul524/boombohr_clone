import 'package:demo_app/app/data/models/models.dart';
import 'package:demo_app/app/data/repositories/repository.dart';
import 'package:demo_app/app/modules/home/static_tabs.dart' hide TabModel;
import 'package:get/get.dart';

class HomeController extends GetxController {
  //profile
  final RxString name = 'John Doe'.obs;
  final RxString title = 'HR Administrator'.obs;
  final RxString employeeId = 'EMP001234'.obs;
  final RxBool hasPendingRequest = true.obs;
  final Repository repo = Repository();

  @override
  void onInit() {
    super.onInit();
    loadTabs();
  }

  // Method to handle the "Request a Change" button press
  void requestChange() {
    // Logic for handling the request change action
    Get.snackbar(
      "Action",
      "Request Change button pressed!",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  RxList<Rx<TabModel>> tabModels = <Rx<TabModel>>[].obs;

  void loadTabs() {
    final list = repo.getForms();
    if (list.isEmpty) {
      tabModels = (tabs.map((e) => e.obs).toList()).obs;
    }
  }

  void saveTabs() {
    final list = tabModels.map((e) => e.value).toList();
    repo.setTabs(list);
  }
}
