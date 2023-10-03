import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projecttravelwin/app/commen/ui.dart';
import 'package:projecttravelwin/app/models/basic/requst_service_booking.dart';
import 'package:projecttravelwin/app/models/basic/state_request.dart';
import 'package:projecttravelwin/app/modules/widgets/default_widget.dart';

import '../../../data/local/local_data.dart';
import '../../../models/basic/user_request.dart';
import '../../../translations/locale.dart';
import '../../widgets/main_widget.dart';
import '../../widgets/main_widget_desktop.dart';
import '../controllers/customer_request_desktop_controller.dart';

class CustomerRequestDesktopView
    extends GetView<CustomerRequestDesktopController> {
  const CustomerRequestDesktopView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TitleAppBarDesktop(title: 'عرض الطلبات'),
          iconTheme: IconThemeData(color: Get.theme.colorScheme.secondary),
          centerTitle: true,
        ),
        body: Obx(() => controller.isLoading.value
            ? const DefaultCircalProgress()
            : Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'عدد الطلبات'.toString() +
                            DataConst.comme +
                            controller.allRequest.length.toString(),
                        style: Get.textTheme.headlineMedium,
                      )
                    ],
                  ),
                  Expanded(
                    child: GetBuilder<CustomerRequestDesktopController>(
                      // init: MyController(),
                      id: 'listRequest',
                      initState: (_) {},
                      builder: (_) {
                        return ListView.builder(
                          itemCount: controller.allRequest.length,
                          itemBuilder: (context, index) {
                            UserRequest request = controller.allRequest[index];
                            if (request.requestTrip != null) {
                              return ItemTripRequest(
                                userRequest: request,
                              );
                            } else {
                              return ItemServiceRequest(
                                userRequest: request,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                  const LogoBottomScreen()
                ],
              )));
  }
}

// Future showDetailsRequest(BuildContext context)async{
//   return AnimatedBuilder(animation: animation, builder: builder)
// }

class ItemTripRequest extends GetView<CustomerRequestDesktopController> {
  ItemTripRequest({super.key, required this.userRequest});
  final UserRequest userRequest;
  // var controller = Get.find<CustomerRequestDesktopController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // await bottomSheetDetailRequestTrip(userRequest.requestTrip!);
        if (userRequest.state!.id == 1) {
          await UiApp.defaultDeialog(
              title: 'تنبية',
              content: Center(
                child: Obx(() => controller.isLoading.value
                    ? DefaultCircalProgress()
                    : Text(
                        'بمجرد فتح الطلب سوف يتم تعديل الى الطلب تحت المعالجة',
                        style: Get.textTheme.headlineMedium,
                      )),
              ),
              confirm: UiApp.buttonDone(
                  lable: 'موافق',
                  onPressed: () async {
                    bool temp = await controller.reciverequest(
                        idCust: userRequest.customer!.idCus!,
                        idState: 2,
                        idReq: userRequest.idCustomerRequsts!);
                    if (temp) {
                      Get.back();
                      showRequesttrip();
                    } else {
                      UiApp.snakfaild('فشل ', 'تاكد من اتصالك ب الانترنت');
                      Get.back();
                    }
                  }));
        } else {
          showRequesttrip();
        }
      },
      child: DefaultCountainer(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: IconStateRequsteSelect(
            id: userRequest.state!.id!,
          ),
          title: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'اسم العميل'.toString() +
                    DataConst.comme +
                    userRequest.customer!.nikName!,
                style: Get.textTheme.headlineMedium,
              )),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'اسم الخدمة'.toString() +
                    DataConst.comme +
                    userRequest.serviceName!,
                style: Get.textTheme.headlineMedium,
              ),
              Text(
                'عدد الاشخاص'.toString() +
                    DataConst.comme +
                    userRequest.requestTrip!.infoBooking!.length.toString(),
                style: Get.textTheme.headlineSmall,
              ),
              Text(
                'وقت الحجز'.toString() +
                    DataConst.comme +
                    DateFormat.jm('ar')
                        .format(userRequest.requestTrip!.bookingTime!) +
                    ' ,'.toString() +
                    DateFormat.yMMMMEEEEd('ar')
                        .format(userRequest.requestTrip!.bookingTime!),
                style: Get.textTheme.headlineSmall,
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'حالة الطلب',
                style: Get.textTheme.headlineSmall,
              ),
              Text(
                userRequest.state!.name!,
                style: Get.textTheme.headlineSmall,
              )
            ],
          ),
        ),
      ),
    );
  }

  showRequesttrip() {
    defaultDiloagAnimation(
        body: Obx(
      () => controller.isLoading.value
          ? DefaultCircalProgress()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: SizedBox(
                      height: 60,
                      width: Get.width,
                      child: Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 2,
                            child: UiApp.buttonDone(
                                lable: 'حفظ التعديلات',
                                onPressed: () async {
                                  StateRequest? selected = userRequest.getState;

                                  await Get.defaultDialog<StateRequest?>(
                                      title: 'تحديد حال الطلب بالكامل',
                                      onWillPop: () {
                                        return Future.value(false);
                                      },
                                      confirm: UiApp.buttonDone(
                                          lable: 'حفظ',
                                          onPressed: () async {
                                            Get.back();
                                            await controller.editetoServer(
                                                type: 1,
                                                idRequest: userRequest
                                                    .idCustomerRequsts!,
                                                idStateReq: selected!.id!);

                                            Get.back();
                                          }),
                                      cancel: UiApp.buttonCansal(
                                          lable: 'الغاء',
                                          onPressed: () {
                                            controller.dataedidt.clear();
                                            controller.dataedidt.clear();

                                            Get.back();
                                          }),
                                      content: Column(
                                        children: [
                                          GetBuilder<
                                              CustomerRequestDesktopController>(
                                            id: 'stateRequest',
                                            initState: (_) {},
                                            builder: (_) {
                                              return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children:
                                                      controller.databasic ==
                                                              null
                                                          ? []
                                                          : controller
                                                              .databasic!
                                                              .stateRequest!
                                                              .map((e) => Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Radio(
                                                                          value:
                                                                              e,
                                                                          groupValue:
                                                                              selected,
                                                                          onChanged:
                                                                              (value) {
                                                                            selected =
                                                                                value;
                                                                            controller.updatestateRequest();
                                                                          }),
                                                                      Text(
                                                                        e.name!,
                                                                        style: Get
                                                                            .textTheme
                                                                            .headlineSmall,
                                                                      )
                                                                    ],
                                                                  ))
                                                              .toList());
                                            },
                                          ),
                                        ],
                                      ));
                                }),
                          ),
                          const Spacer(),
                          Expanded(
                              flex: 2,
                              child: UiApp.buttonCansal(
                                  lable: 'الغاء',
                                  onPressed: () async {
                                    controller.dataedidt.clear();
                                    Get.back();
                                    // await controller.editetoServer();
                                  })),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 65,
                    bottom: 0,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: Get.width,
                        height: Get.height - 65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BorderCoverWidget(
                              label: 'بيانات الرحلة',
                              child: SizedBox(
                                width: Get.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: userRequest.requestTrip!.info!
                                      .map((e) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  'اسم الشركة'.toString() +
                                                      DataConst.comme +
                                                      e.trip!.company!.name!,
                                                  style: Get
                                                      .textTheme.headlineSmall),
                                              Text(
                                                  LocaleKeys.trip_fromCity.tr +
                                                      DataConst.comme +
                                                      e.trip!.fromCity!.name! +
                                                      ' '.toString() +
                                                      LocaleKeys
                                                          .trip_ToCity.tr +
                                                      ' '.toString() +
                                                      e.trip!.toCity!.name!,
                                                  style: Get
                                                      .textTheme.headlineSmall),
                                              Text(
                                                  'خطة الرحلة'.toString() +
                                                      DataConst.comme +
                                                      userRequest.requestTrip!
                                                          .planTrip!.name!,
                                                  style: Get
                                                      .textTheme.headlineSmall),
                                              Text(
                                                  'موعد الحجز المطلوب'.toString() +
                                                      DataConst.comme +
                                                      DateFormat.jm('ar')
                                                          .format(DateTime(
                                                              2023,
                                                              1,
                                                              1,
                                                              e.trip!.timeLeave!
                                                                  .hour,
                                                              e.trip!.timeLeave!
                                                                  .minute)) +
                                                      ' ,'.toString() +
                                                      DateFormat.yMEd('ar')
                                                          .format(e.dateGo!),
                                                  style: Get
                                                      .textTheme.headlineSmall),
                                              if (e.dataBack != null)
                                                Text(
                                                    'وقت العودة'.toString() +
                                                        DataConst.comme +
                                                        DateFormat.jm('ar')
                                                            .format(DateTime(
                                                                2023,
                                                                1,
                                                                1,
                                                                e
                                                                    .trip!
                                                                    .timeLeave!
                                                                    .hour,
                                                                e
                                                                    .trip!
                                                                    .timeLeave!
                                                                    .minute)) +
                                                        ' ,'.toString() +
                                                        DateFormat.yMEd('ar')
                                                            .format(
                                                                e.dataBack!),
                                                    style: Get.textTheme
                                                        .headlineSmall)
                                            ],
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: Get.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: userRequest
                                        .requestTrip!.infoBooking!
                                        .asMap()
                                        .entries
                                        .map((e) => BorderCoverWidget(
                                              label:
                                                  'بيانات الشخص '.toString() +
                                                      (e.key + 1).toString(),
                                              child: Column(
                                                children: [
                                                  BorderCoverWidget(
                                                    label: 'بيانات الهوية '
                                                        .toString(),
                                                    child:
                                                        CustomerIdentenyItemDesktop(
                                                      identity: e.value.person,
                                                      isShowonly: true,
                                                    ),
                                                  ),
                                                  BorderCoverWidget(
                                                    label: 'البيانات المدخلة',
                                                    child: Column(
                                                      children: e.value
                                                          .dataInputRequrment!
                                                          .asMap()
                                                          .entries
                                                          .map(
                                                              (element) =>
                                                                  Column(
                                                                    children: [
                                                                      Container(
                                                                        margin:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            getWidgetinputElement(
                                                                          element
                                                                              .value,
                                                                        ),
                                                                      ),
                                                                      Divider()
                                                                    ],
                                                                  ))
                                                          .toList(),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    ));
  }
}

class ItemServiceRequest extends GetView<CustomerRequestDesktopController> {
  const ItemServiceRequest({super.key, required this.userRequest});
  final UserRequest userRequest;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // bottomSheetDetailRequestServicePublic(
        //     userRequest.requestServicePublic!);
        if (userRequest.state!.id == 1) {
          await UiApp.defaultDeialog(
              title: 'تنبية',
              content: Center(
                child: Obx(() => controller.isLoading.value
                    ? DefaultCircalProgress()
                    : Text(
                        'بمجرد فتح الطلب سوف يتم تعديل الى الطلب تحت المعالجة',
                        style: Get.textTheme.headlineMedium,
                      )),
              ),
              confirm: UiApp.buttonDone(
                  lable: 'موافق',
                  onPressed: () async {
                    bool temp = await controller.reciverequest(
                        idCust: userRequest.customer!.idCus!,
                        idState: 2,
                        idReq: userRequest.idCustomerRequsts!);
                    if (temp) {
                      Get.back();
                      showRequesttrip();
                    } else {
                      UiApp.snakfaild('فشل ', 'تاكد من اتصالك ب الانترنت');

                      Get.back();
                    }
                  }));
        } else {
          showRequesttrip();
        }
      },
      child: DefaultCountainer(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: IconStateRequsteSelect(
            id: userRequest.state!.id!,
          ),
          title: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'اسم العميل'.toString() +
                    DataConst.comme +
                    userRequest.customer!.nikName!,
                style: Get.textTheme.headlineMedium,
              )),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'اسم الخدمة'.toString() +
                    DataConst.comme +
                    userRequest.serviceName!,
                style: Get.textTheme.headlineMedium,
              ),
              Text(
                'عدد الاشخاص'.toString() +
                    DataConst.comme +
                    userRequest.requestServicePublic!.infoBookingService!.length
                        .toString(),
                style: Get.textTheme.headlineSmall,
              ),
              Text(
                'وقن المعاملة'.toString() +
                    DataConst.comme +
                    DataConst.comme +
                    DateFormat.jm('ar').format(userRequest
                        .requestServicePublic!.bookingServicesDate!) +
                    ' ,'.toString() +
                    DateFormat.yMMMMEEEEd('ar').format(
                        userRequest.requestServicePublic!.bookingServicesDate!),
                style: Get.textTheme.headlineSmall,
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('حالة الطلب', style: Get.textTheme.headlineSmall),
              Text(
                userRequest.state!.name!,
                style: Get.textTheme.headlineSmall,
              )
            ],
          ),
        ),
      ),
    );
  }

  showRequesttrip() {
    defaultDiloagAnimation(
        body: Obx(
      () => controller.isLoading.value
          ? DefaultCircalProgress()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: SizedBox(
                      height: 60,
                      width: Get.width,
                      child: Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 2,
                            child: UiApp.buttonDone(
                                lable: 'حفظ التعديلات',
                                onPressed: () async {
                                  StateRequest? selected = userRequest.getState;

                                  await Get.defaultDialog<StateRequest?>(
                                      title: 'تحديد حال الطلب بالكامل',
                                      onWillPop: () {
                                        return Future.value(false);
                                      },
                                      confirm: UiApp.buttonDone(
                                          lable: 'حفظ',
                                          onPressed: () async {
                                            Get.back();
                                            await controller.editetoServer(
                                                type: 2,
                                                idRequest: userRequest
                                                    .idCustomerRequsts!,
                                                idStateReq: selected!.id!);
                                          }),
                                      cancel: UiApp.buttonCansal(
                                          lable: 'الغاء',
                                          onPressed: () async {
                                            controller.dataedidt.clear();
                                            Get.back();
                                          }),
                                      content: Column(
                                        children: [
                                          GetBuilder<
                                              CustomerRequestDesktopController>(
                                            id: 'stateRequestName',
                                            initState: (_) {},
                                            builder: (_) {
                                              return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children:
                                                      controller.databasic ==
                                                              null
                                                          ? []
                                                          : controller
                                                              .databasic!
                                                              .stateRequest!
                                                              .map((e) => Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Radio(
                                                                          value:
                                                                              e,
                                                                          groupValue:
                                                                              selected,
                                                                          onChanged:
                                                                              (value) {
                                                                            selected =
                                                                                value;
                                                                            controller.updastateRequestName();
                                                                          }),
                                                                      Text(
                                                                        e.name!,
                                                                        style: Get
                                                                            .textTheme
                                                                            .headlineSmall,
                                                                      )
                                                                    ],
                                                                  ))
                                                              .toList());
                                            },
                                          ),
                                        ],
                                      ));
                                }),
                          ),
                          const Spacer(),
                          Expanded(
                              flex: 2,
                              child: UiApp.buttonCansal(
                                  lable: 'الغاء',
                                  onPressed: () async {
                                    controller.dataedidt.clear();
                                    Get.back();
                                    // await controller.editetoServer();
                                  })),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 65,
                    bottom: 0,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: Get.width,
                        height: Get.height - 65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BorderCoverWidget(
                              label: 'بيانات الخدمة',
                              child: SizedBox(
                                width: Get.width,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'اسم الخدمة'.toString() +
                                              DataConst.comme +
                                              userRequest.serviceName!,
                                          style: Get.textTheme.headlineSmall),
                                      Text(
                                          'موعد الحجز '.toString() +
                                              DataConst.comme +
                                              DateFormat.jm('ar').format(
                                                  userRequest
                                                      .requestServicePublic!
                                                      .bookingServicesDate!) +
                                              ' ,'.toString() +
                                              DateFormat.yMEd('ar').format(
                                                  userRequest
                                                      .requestServicePublic!
                                                      .bookingServicesDate!),
                                          style: Get.textTheme.headlineSmall),
                                    ]),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: Get.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: userRequest.requestServicePublic!
                                        .infoBookingService!
                                        .asMap()
                                        .entries
                                        .map((e) => BorderCoverWidget(
                                              label:
                                                  'بيانات الشخص '.toString() +
                                                      (e.key + 1).toString(),
                                              child: Column(
                                                children: [
                                                  BorderCoverWidget(
                                                    label: 'بيانات الهوية '
                                                        .toString(),
                                                    child:
                                                        CustomerIdentenyItemDesktop(
                                                      identity: e.value.person!,
                                                      isShowonly: true,
                                                    ),
                                                  ),
                                                  BorderCoverWidget(
                                                    label: 'البيانات المدخلة',
                                                    child: Column(
                                                      children: e.value
                                                          .dataInputRequrment!
                                                          .asMap()
                                                          .entries
                                                          .map(
                                                              (element) =>
                                                                  Column(
                                                                    children: [
                                                                      Container(
                                                                        margin:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            getWidgetinputElement(
                                                                          element
                                                                              .value,
                                                                        ),
                                                                      ),
                                                                      Divider()
                                                                    ],
                                                                  ))
                                                          .toList(),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    ));
  }
}

defaultDiloagAnimation(
    {PreferredSizeWidget? appBar,
    Widget? body,
    Curve? transitionCurve,
    Duration? transitionDuration}) async {
  return Get.dialog(
      WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: Scaffold(
          appBar: appBar,
          body: body,
        ),
      ),
      transitionCurve: transitionCurve ?? Curves.easeInOut,
      transitionDuration:
          transitionDuration ?? const Duration(milliseconds: 600));
}
