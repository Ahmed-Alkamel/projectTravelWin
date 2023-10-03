import 'package:get/get.dart';

import '../controllers/trips_desktop_controller.dart';

class TripsDesktopBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TripsDesktopController>(
      TripsDesktopController(),
    );
  }
}
