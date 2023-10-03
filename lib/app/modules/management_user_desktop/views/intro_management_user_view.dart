import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../commen/ui.dart';
import '../../../models/basic/proccess_app.dart';
import '../../../models/services/perimission_process.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';
import '../../widgets/main_widget_desktop.dart';

class IntroManagementUserView extends GetView {
  const IntroManagementUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('IntroManagementUserView'),
      //   centerTitle: true,
      // ),
      body: IntrodicationView(
        title: 'ادارة المستخدمين',
        pr1Title: "اضافة مستخدم",
        pr1OnTap: () async {
          ProcessApp temp = Get.find<AuthUserService>()
              .user!
              .permisstion!
              .firstWhere((element) =>
                  element.id == ProcessAndPermisstion.userManagement.id);
          if (temp.permission!.any((element) =>
              element.id! ==
                  ProcessAndPermisstion.userManagement.permissons.add &&
              element.allow == true)) {
            await Get.toNamed(Routes.MANAGEMENT_USER_Add_DESKTOP,
                parameters: {'type': 'add'});
          } else {
            UiApp.snakNote('صلاحيات', "ليس لديك الصلاحيات لاجراء هذه العملية ");
          }
        },
        pr2Title: 'تعديل الصلاحيات',
        pr3Title: 'حذف الطلبات',
      ),
    );
  }
}
