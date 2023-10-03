import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../models/basic/customer.dart';
import '../../../routes/app_pages.dart';
import '../../widgets/default_widget.dart';
import '../../widgets/main_widget.dart';
import '../controllers/main_screan_controller.dart';

class BeneficicaresView extends GetView<MainScreanController> {
  const BeneficicaresView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: controller.currentUser == null
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'لا تملك حساب',
                    style: Get.textTheme.headlineMedium,
                  ),
                  defaultButton(
                    width: Get.width / 3,
                    isResponseve: false,
                    isIcon: false,
                    lable: 'تسجيل دخول',
                    onPressed: () {
                      Get.toNamed(Routes.AUTH);
                    },
                  )
                ],
              ))
            : controller.currentUser!.benefities == null ||
                    controller.currentUser!.benefities!.isEmpty
                ? Center(
                    child: Text(
                    'لا يوجد اشخاص مستفيدون',
                    style: Get.textTheme.headlineSmall,
                  ))
                : Container(
                    margin: const EdgeInsets.only(top: 15),
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 8.8),
                    child: ListView.builder(
                      itemCount: controller.currentUser!.benefities!.length,
                      itemBuilder: (context, index) {
                        IdentitBeneficiares identit =
                            controller.currentUser!.benefities![index];
                        return GestureDetector(
                          onTap: () {
                            controller.test();
                          },
                          child: CustomerIdentenyItem(
                            identity: identit,
                            isShowonly: true,
                          ),
                        );
                      },
                    ),
                  ));
  }
}
