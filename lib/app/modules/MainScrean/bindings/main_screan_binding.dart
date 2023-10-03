import 'package:get/get.dart';

import '../controllers/main_screan_controller.dart';

class MainScreanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainScreanController>(() => MainScreanController());
  }
}
