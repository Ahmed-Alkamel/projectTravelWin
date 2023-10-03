import 'package:get/get.dart';

import '../controllers/services_screen_controller.dart';

class ServicesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesScreenController>(
      () => ServicesScreenController(),
    );
  }
}
