import 'package:get/get.dart';

import '../controllers/customer_request_desktop_controller.dart';

class CustomerRequestDesktopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerRequestDesktopController>(
      () => CustomerRequestDesktopController(),
    );
  }
}
