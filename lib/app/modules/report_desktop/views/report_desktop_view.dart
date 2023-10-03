import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:projecttravelwin/app/modules/widgets/default_widget.dart';
import 'package:projecttravelwin/app/modules/widgets/main_widget.dart';

import '../../widgets/main_widget_desktop.dart';
import '../controllers/report_desktop_controller.dart';

class ReportDesktopView extends GetView<ReportDesktopController> {
  const ReportDesktopView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TitleAppBarDesktop(title: 'التقارير'),
          iconTheme: IconThemeData(color: Get.theme.colorScheme.secondary),
          centerTitle: true,
        ),
        body: Obx(() => controller.isLoading.value
            ? const DefaultCircalProgress()
            : Obx(() => Column(
                  children: [
                    SizedBox(
                      width: Get.width,
                      child: Row(
                        children: controller.titlPage
                            .asMap()
                            .entries
                            .map((e) => Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.currentPage.value = e.key;
                                    },
                                    child: DefaultCountainer(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(8.0),
                                      color:
                                          controller.currentPage.value == e.key
                                              ? Get.theme.colorScheme.primary
                                              : Get.theme.colorScheme.secondary,
                                      child: Text(
                                        e.value,
                                        style: Get.textTheme.headlineLarge!
                                            .merge(TextStyle(
                                                color: controller.currentPage
                                                            .value ==
                                                        e.key
                                                    ? Get.theme.colorScheme
                                                        .secondary
                                                    : Get.theme.colorScheme
                                                        .primary)),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    Expanded(
                        child: controller.page[controller.currentPage.value])
                  ],
                ))));
  }
}
