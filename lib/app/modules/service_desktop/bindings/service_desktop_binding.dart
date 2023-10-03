import 'package:get/get.dart';

import '../controllers/service_desktop_controller.dart';

class ServiceDesktopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceDesktopController>(
      () => ServiceDesktopController(),
    );
  }
}
