import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../commen/ui.dart';
import '../../../models/basic/proccess_app.dart';
import '../../../models/services/perimission_process.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';
import '../../widgets/main_widget_desktop.dart';

class IntroReportView extends GetView {
  const IntroReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('IntroReportView'),
        //   centerTitle: true,
        // ),
        body: IntrodicationView(
      title: 'التقارير',
      pr1Title: "عرض  التقارير",
      pr1OnTap: () async {
        ProcessApp temp = Get.find<AuthUserService>()
            .user!
            .permisstion!
            .firstWhere(
                (element) => element.id == ProcessAndPermisstion.report.id);
        if (temp.permission!.any((element) =>
            element.id! == ProcessAndPermisstion.report.permissons.view &&
            element.allow == true)) {
          await Get.toNamed(Routes.REPORT_DESKTOP,
              parameters: {'type': 'show'});
        } else {
          UiApp.snakNote('صلاحيات', "ليس لديك الصلاحيات لاجراء هذه العملية ");
        }
      },
      pr2Title: "",
      pr3Title: "",
    ));
  }
}
