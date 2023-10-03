import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../models/basic/service.dart';
import '../../widgets/default_widget.dart';
import '../controllers/services_public_controller.dart';

class ServicesPublicView extends GetView<ServicesPublicController> {
  const ServicesPublicView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text(
            'معاملات',
            style: Get.textTheme.titleLarge,
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Get.theme.colorScheme.secondary),
        ),
        body: Obx(() => controller.isload.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.services.isEmpty
                ? const Center(
                    child: Text('لا توجد خدمات  متوفرة'),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: controller.services.length,
                      itemBuilder: (context, index) {
                        Service service = controller.services[index];
                        return GestureDetector(
                          onTap: () async {
                            // await bootomSheetBookingService(
                            //     service, controller);
                            controller.confarmLogin(service);
                          },
                          child: DefaultCountainer(
                            child: ListTile(
                              title: Text(
                                service.name!,
                                style: Get.textTheme.headlineMedium,
                              ),
                              leading: SvgPicture.network(
                                service.pathImage!,
                                width: 50,
                                height: 50,
                                color: Get.theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )));
  }
}
