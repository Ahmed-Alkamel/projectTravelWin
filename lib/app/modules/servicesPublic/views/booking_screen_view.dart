import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../models/basic/customer.dart';
import '../../widgets/default_widget.dart';
import '../../widgets/main_widget.dart';
import '../controllers/services_public_controller.dart';

class BookingScreenView extends GetView<ServicesPublicController> {
  const BookingScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'تعبئة البيانات',
            style: Get.textTheme.titleLarge,
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Get.theme.colorScheme.secondary),
        ),
        body: Obx(
          () => controller.isload.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: Get.width,
                      height: Get.height,
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              'حجز معاملة',
                              style: Get.textTheme.headlineLarge,
                            ),
                          ),
                          Expanded(
                            child: Obx(() => ListView.builder(
                                  itemCount:
                                      controller.requestBookingServices.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.only(top: 12),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Get.theme.colorScheme.primary,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(5),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Column(
                                        children: [
                                          CustomerIdentenyItem(
                                            isShowonly: true,
                                            identity: IdentitBeneficiares(
                                                identityCustomer: controller
                                                    .requestBookingServices[
                                                        index]
                                                    .identityCustomers),
                                          ),
                                          MainRequrmentWidgetList(
                                            controlerServ: controller,
                                            index: index,
                                          )
                                          //   ListView.builder(
                                          //     shrinkWrap: true,
                                          //     physics: NeverScrollableScrollPhysics(),
                                          //     itemCount:controller.requestBookingServices[index].,
                                          //     itemBuilder: (BuildContext context,
                                          //         int childIndex) {
                                          //       return ListTile(
                                          //         title: GestureDetector(
                                          //           onTap: () {
                                          //             controller.selectedCity(
                                          //                 countries[index]
                                          //                     .cities![childIndex],
                                          //                 type,
                                          //                 indexParent);
                                          //             Get.back();
                                          //           },
                                          //           child: Text(controller
                                          //               .searchCityList![index]
                                          //               .cities![childIndex]
                                          //               .name!),
                                          //         ),
                                          //       );
                                          //     },
                                          //   ),
                                        ],
                                      ),
                                    );
                                  },
                                )),
                          ),
                          defaultButton(
                              isResponseve: true,
                              isIcon: false,
                              lable: 'اتمام الطلب',
                              onPressed: () async {
                                await controller.addRequstServer();
                              })
                        ],
                      )),
                ),
        ));
  }
}
