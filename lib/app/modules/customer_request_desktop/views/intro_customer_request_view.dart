import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../commen/ui.dart';
import '../../../models/basic/proccess_app.dart';
import '../../../models/services/perimission_process.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';
import '../../widgets/main_widget.dart';
import '../../widgets/main_widget_desktop.dart';
import '../controllers/customer_request_desktop_controller.dart';

class IntroCustomerRequestView
    extends GetView<CustomerRequestDesktopController> {
  const IntroCustomerRequestView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('IntroCustomerRequestView'),
        //   centerTitle: true,
        // ),
        body: IntrodicationView(
      title: 'طلبات العملاء',
      pr1Title: "عرض  الطلبات",
      pr1OnTap: () async {
        ProcessApp temp = Get.find<AuthUserService>()
            .user!
            .permisstion!
            .firstWhere((element) =>
                element.id == ProcessAndPermisstion.customerRequest.id);
        if (temp.permission!.any((element) =>
            element.id! ==
                ProcessAndPermisstion.customerRequest.permissons.view &&
            element.allow == true)) {
          await Get.toNamed(Routes.CUSTOMER_REQUEST_DESKTOP,
              parameters: {'type': 'show'});
        } else {
          UiApp.snakNote('صلاحيات', "ليس لديك الصلاحيات لاجراء هذه العملية ");
        }
      },
      pr2Title: 'تعديل الطلبات',
      pr3Title: 'رسائل العملاء',
      pr3OnTap: () async {
        ProcessApp temp = Get.find<AuthUserService>()
            .user!
            .permisstion!
            .firstWhere((element) =>
                element.id == ProcessAndPermisstion.customerRequest.id);
        if (temp.permission!.any((element) =>
            element.id! ==
                ProcessAndPermisstion.customerRequest.permissons.respons &&
            element.allow == true)) {
          await Get.toNamed(
            Routes.CUSTOMER_CHAT_REQUSET,
          );
        } else {
          UiApp.snakNote('صلاحيات', "ليس لديك الصلاحيات لاجراء هذه العملية ");
        }
      },
    ));
  }
}
