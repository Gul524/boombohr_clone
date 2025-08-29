import 'package:demo_app/models/models.dart';


class Repository extends GetStorage {
  Future<void> setTabs(List<TabModel> tabs) async {
    await GetStorage.write("tabs", tabs);
  }

  List<TabModel> getForms() {
    return StorageService.read<List<TabModel>>('tabs') ?? [];
     }

}
