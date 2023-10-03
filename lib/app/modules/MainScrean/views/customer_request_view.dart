import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../models/basic/user_request.dart';

import '../../widgets/main_widget.dart';
import '../controllers/main_screan_controller.dart';

class CustomerRequestView extends GetView<MainScreanController> {
  const CustomerRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8.8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: controller.stateRequest
                  .map((e) => GestureDetector(
                        onTap: () {
                          controller.shStatRequset(e);
                        },
                        child: Column(
                          children: [
                            IconStateRequsteSelect(
                              id: e.id!,
                              size: 50,
                            ),
                            Text(
                              e.name!,
                              style: Get.textTheme.headlineMedium,
                            )
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: GetBuilder<MainScreanController>(
              id: 'bodyCustomerRequest',
              // init: MainScreanController(),
              initState: (_) {},
              builder: (_) {
                return controller.requsstData == null ||
                        controller.requsstData!.isEmpty
                    ? Center(
                        child: Text(
                          'لا توجد طلبات',
                          style: Get.textTheme.headlineMedium,
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.requsstData != null
                            ? controller.requsstData!.length
                            : 0,
                        itemBuilder: (context, index) {
                          UserRequest userRequest =
                              controller.requsstData![index];
                          return userRequest.requestTrip == null
                              ? ItemServiceRequest(
                                  userRequest: userRequest,
                                )
                              : ItemTripRequest(
                                  userRequest: userRequest,
                                );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    ));
  }
}

