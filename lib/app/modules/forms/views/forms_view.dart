import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forms_controller.dart';

class FormsView extends GetView<FormsController> {
  const FormsView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(FormsController());
    return const Scaffold(
      body: Center(child: Text('Bamboo Forms – GetX Skeleton')),
    );
  }
}
