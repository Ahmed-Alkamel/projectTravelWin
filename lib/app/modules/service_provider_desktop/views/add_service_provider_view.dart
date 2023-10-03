import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:projecttravelwin/app/Helper/validation.dart';
import 'package:projecttravelwin/app/commen/ui.dart';
import 'package:projecttravelwin/app/models/basic/company.dart';
import 'package:projecttravelwin/app/models/basic/data_basic_add_trip.dart';
import 'package:projecttravelwin/app/modules/widgets/default_widget.dart';

import '../../../data/local/local_data.dart';
import '../../widgets/main_widget_desktop.dart';
import '../controllers/service_provider_desktop_controller.dart';

class AddServiceProviderView extends GetView<ServiceProviderDesktopController> {
  const AddServiceProviderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleAppBarDesktop(title: 'اضافة موفر خدمة'),
        iconTheme: IconThemeData(color: Get.theme.colorScheme.secondary),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => controller.isloadAddScreen.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            child: Obx(() => DefaultDataTable(
                                    columns: [
                                      headerColumnDefault("رقم الشركة"),
                                      headerColumnDefault('اسم الشركة'),
                                      headerColumnDefault('العنوان'),
                                      headerColumnDefault('رقم الجوال'),
                                    ],
                                    rows: controller.allCompany
                                        .map((e) => DataRow(cells: [
                                              DataCell(DefaultWidgetDataCell(
                                                data: e.id!.toString(),
                                              )),
                                              DataCell(DefaultWidgetDataCell(
                                                data: e.name!.toString(),
                                              )),
                                              DataCell(DefaultWidgetDataCell(
                                                data: e.address!.toString(),
                                              )),
                                              DataCell(DefaultWidgetDataCell(
                                                data: e.phone!.toString(),
                                              )),
                                            ]))
                                        .toList())),
                          ),
                        ),
                        BottomNavigationProcess(
                          onPressedAdd: () async {
                            if (controller.dataBasic!.serviceMine == null ||
                                controller.dataBasic!.serviceMine!.isEmpty) {
                              await UiApp.snakNote('تنبية',
                                  "لا توجد خدمات ارجاء اضافة الخدمة اولا");
                            } else {
                              controller.newCompany = null;
                              controller.newCompany = Company();
                              await addCompanyDiealog();
                            }
                          },
                        ),
                      ],
                    ),
                  )),
          ),
          LogoBottomScreen()
        ],
      ),
    );
  }

// TODO: copy to project
  Future addCompanyDiealog() async {
    return await UiApp.defaultDeialog(
        onWillPop: () {
          bool def = false;
          if (controller.newCompany == null) {
            def = true;
          }
          return Future.value(def);
        },
        confirm: UiApp.buttonDone(
            lable: 'حفظ ',
            onPressed: () async {
              await controller.saveCompany();
            }),
        cancel: UiApp.buttonCansal(
            lable: 'الغاء',
            onPressed: () {
              Get.back();
            }),
        title: 'اضافة موفر خدمة',
        content: Form(
          key: controller.keyFomeadd,
          child: Column(
            children: [
              DefaultTextFormField(
                label: 'اسم الشركة',
                hintText: 'ادخل اسم الشركة/ الموفر',
                validator: (value) =>
                    ValidatorApp.getVaidator(ValidateType.required, value),
                onchange: (value) {
                  controller.newCompany!.name = value;
                },
                isborderall: true,
              ),
              DefaultTextFormField(
                label: 'العنوان',
                hintText: 'ادخل عنوان الشركة',
                validator: (value) =>
                    ValidatorApp.getVaidator(ValidateType.required, value),
                onchange: (value) {
                  controller.newCompany!.address = value;
                },
                isborderall: true,
              ),
              DefaultTextFormField(
                label: 'رقم الجوال',
                hintText: 'ادخل  رقم الجوال',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(UntilHelper.onlynumberReq),
                ],
                validator: (value) =>
                    ValidatorApp.getVaidator(ValidateType.required, value),
                onchange: (value) {
                  controller.newCompany!.phone = value;
                },
                isborderall: true,
              ),
              GetBuilder<ServiceProviderDesktopController>(
                id: 'serviceProvider',
                //  init: MyController(),
                initState: (_) {},
                builder: (_) {
                  return Expanded(
                      child: BorderCoverWidget(
                    label: 'الخدمات',
                    child: controller.newCompany!.servicesCompanyProvider ==
                                null ||
                            controller
                                .newCompany!.servicesCompanyProvider!.isEmpty
                        ? Center(
                            child: TextButton(
                              onPressed: () async {
                                await addServiceToNewCompany(controller
                                        .newCompany!.servicesCompanyProvider ??
                                    []);
                              },
                              child: Text(
                                'فارغ قم بضافة ',
                                style: Get.textTheme.headlineLarge,
                              ),
                            ),
                          )
                        : SizedBox(
                            width: Get.width / 3 * 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: controller.newCompany!
                                            .servicesCompanyProvider!
                                            .asMap()
                                            .entries
                                            .map((e) => Text(
                                                  (e.key + 1).toString() +
                                                      ' - '.toString() +
                                                      e.value.name!,
                                                  style: Get
                                                      .textTheme.headlineMedium,
                                                ))
                                            .toList()),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await addServiceToNewCompany(controller
                                            .newCompany!
                                            .servicesCompanyProvider ??
                                        []);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: Get.theme.colorScheme.primary,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'تعديل على الخدمات',
                                        style: Get.textTheme.headlineSmall,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                  ));
                },
              ),
            ],
          ),
        ));
  }

  Future addServiceToNewCompany(List<ServiceMine> service) async {
    return await UiApp.defaultDeialog(
        onWillPop: () {
          return Future.value(false);
        },
        confirm: UiApp.buttonDone(
            lable: 'تم',
            onPressed: () {
              controller.newCompany!.servicesCompanyProvider = service;

              controller.updateserviceProvider();
              Get.back();
            }),
        cancel: UiApp.buttonCansal(
            lable: 'الغاء',
            onPressed: () {
              Get.back();
            }),
        title: 'الخدمات',
        content: GetBuilder<ServiceProviderDesktopController>(
          // init: MyController(),
          id: 'checkService',
          initState: (_) {},
          builder: (_) {
            return Column(
              children: [
                Text(
                  'تحديد الخدمات',
                  style: Get.textTheme.displaySmall,
                ),
                SingleChildScrollView(
                  // scrollDirection:
                  //     Axis.horizontal,
                  child: Column(
                      children: controller.dataBasic!.serviceMine!
                          .map(
                            (e) => Row(
                              children: [
                                Checkbox(
                                    value: service.isEmpty
                                        ? false
                                        : service
                                            .any((element) => element == e),
                                    onChanged: (value) {
                                      if (value == true) {
                                        service.add(e);
                                      } else {
                                        service.remove(e);
                                      }
                                      controller.updatecheckService();
                                    }),
                                Text(
                                  e.name!,
                                  style: Get.textTheme.displaySmall,
                                )
                              ],
                            ),
                          )
                          .toList()),
                ),
              ],
            );
          },
        ));
  }
}
