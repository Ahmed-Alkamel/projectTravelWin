import 'package:get/get.dart';

import '../controllers/services_public_controller.dart';

class ServicesPublicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesPublicController>(
      () => ServicesPublicController(),
    );
  }
}
