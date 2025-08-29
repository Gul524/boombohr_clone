import 'package:demo_app/app/data/models/models.dart';
import 'package:demo_app/app/data/repositories/service.dart';


class Repository {
  Future<void> setTabs(List<TabModel> tabs) async {
    await StorageService.write("tabs", tabs);
  }

  List<TabModel> getForms() {
    return StorageService.read<List<TabModel>>('tabs') ?? [];
     }

}
