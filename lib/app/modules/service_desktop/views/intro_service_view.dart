import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:projecttravelwin/app/commen/ui.dart';
import 'package:projecttravelwin/app/services/auth_services.dart';

import '../../../models/basic/proccess_app.dart';
import '../../../models/services/perimission_process.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/color.dart';
import '../../widgets/main_widget_desktop.dart';

class IntroServiceView extends GetView {
  const IntroServiceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('IntroServiceView'),
        //   centerTitle: true,
        // ),
        body: Column(
      children: [
        Expanded(
            child: ItemCardOperationServices(
          title: 'الخدمات',
          childern: [
            Expanded(
              child: ItemCardMain(
                title: 'اضافة خدمة',
                color: DefaultColor.containTheme2,
                onTap: () async {
                  ProcessApp temp = Get.find<AuthUserService>()
                      .user!
                      .permisstion!
                      .firstWhere((element) =>
                          element.id == ProcessAndPermisstion.service.id);
                  if (temp.permission!.any((element) =>
                      element.id! ==
                          ProcessAndPermisstion.service.permissons.add &&
                      element.allow == true)) {
                    await Get.toNamed(Routes.ADD_SERVICE);
                  } else {
                    UiApp.snakNote(
                        'صلاحيات', "ليس لديك الصلاحيات لاجراء هذه العملية ");
                  }
                },
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: ItemCardMain(
                title: 'تعديل خدمة',
                color: DefaultColor.containTheme1,
                onTap: () async {
                  // await GetStorage().erase();
                },
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: ItemCardMain(
                title: 'حذف خدمة',
                color: DefaultColor.containTheme3,
                onTap: () {},
              ),
            )
          ],
        )),
      ],
    ));
  }
}
