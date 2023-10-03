import 'package:get/get.dart';

import '../controllers/management_user_desktop_controller.dart';

class ManagementUserDesktopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagementUserDesktopController>(
      () => ManagementUserDesktopController(),
    );
  }
}
