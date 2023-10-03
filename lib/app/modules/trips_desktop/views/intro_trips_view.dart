import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../commen/ui.dart';
import '../../../models/basic/proccess_app.dart';
import '../../../models/services/perimission_process.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';
import '../../../theme/color.dart';
import '../../widgets/main_widget_desktop.dart';
import '../controllers/trips_desktop_controller.dart';

class IntroTripsView extends GetView<TripsDesktopController> {
  const IntroTripsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('IntroTripsView'),
        //   centerTitle: true,
        // ),
        body: IntrodicationView(
      title: 'الرحلات',
      pr1Title: 'اضافة رحلة',
      pr1OnTap: () async {
        ProcessApp temp = Get.find<AuthUserService>()
            .user!
            .permisstion!
            .firstWhere(
                (element) => element.id == ProcessAndPermisstion.trips.id);
        if (temp.permission!.any((element) =>
            element.id! == ProcessAndPermisstion.trips.permissons.add &&
            element.allow == true)) {
          await Get.toNamed(Routes.TRIPS_Add_DESKTOP,
              parameters: {'type': 'add'});
        } else {
          UiApp.snakNote('صلاحيات', "ليس لديك الصلاحيات لاجراء هذه العملية ");
        }
      },
      pr2Title: 'تعديل رحلة',
      pr2OnTap: () {
        print(Get.find<AuthUserService>().user!.toMap());
      },
      pr3Title: 'حذف رحلة',
    ));
  }
}
