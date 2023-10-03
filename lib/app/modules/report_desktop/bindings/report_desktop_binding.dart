import 'package:get/get.dart';

import '../controllers/report_desktop_controller.dart';

class ReportDesktopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportDesktopController>(
      () => ReportDesktopController(),
    );
  }
}
