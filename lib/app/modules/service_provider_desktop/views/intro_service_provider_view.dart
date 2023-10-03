import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../commen/ui.dart';
import '../../../models/basic/proccess_app.dart';
import '../../../models/services/perimission_process.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';
import '../../widgets/main_widget_desktop.dart';
import 'add_service_provider_view.dart';

class IntroServiceProviderView extends GetView {
  const IntroServiceProviderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('IntroServiceProviderView'),
        //   centerTitle: true,
        // ),
        body: IntrodicationView(
      title: 'موفر خدمة',
      pr1Title: 'اضافة موفر',
      pr1OnTap: () async {
        ProcessApp temp = Get.find<AuthUserService>()
            .user!
            .permisstion!
            .firstWhere((element) =>
                element.id == ProcessAndPermisstion.serviceProvider.id);
        if (temp.permission!.any((element) =>
            element.id! ==
                ProcessAndPermisstion.serviceProvider.permissons.add &&
            element.allow == true)) {
          await Get.toNamed(Routes.SERVICE_PROVIDER_DESKTOP_Add,
              parameters: {'type': 'add'});
        } else {
          UiApp.snakNote('صلاحيات', "ليس لديك الصلاحيات لاجراء هذه العملية ");
        }
      },
      pr2Title: 'تعديل موفر',
      pr3Title: 'حذف موفر',
    ));
  }
}
