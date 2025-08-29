import 'package:demo_app/models/models.dart';
import 'package:demo_app/repositories/repository.dart';
import 'package:demo_app/models/static_tabs.dart' hide TabModel;
import 'package:get/get.dart';

class ProfileController extends GetxController {
  //profile
  final RxString name = 'John Doe'.obs;
  final RxString title = 'HR Administrator'.obs;
  final RxString employeeId = 'EMP001234'.obs;
  final RxBool hasPendingRequest = true.obs;
  final Repository repo = Repository();

  @override
  void onInit() {
    super.onInit();
  }

  void requestChange() {
    Get.snackbar(
      "Action",
      "Request Change button pressed!",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

}
