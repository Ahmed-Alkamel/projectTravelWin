import 'package:get/get.dart';

import '../controllers/service_provider_desktop_controller.dart';

class ServiceProviderDesktopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceProviderDesktopController>(
      () => ServiceProviderDesktopController(),
    );
  }
}
