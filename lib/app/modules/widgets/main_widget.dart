import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'dart:math' as math;
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../Helper/function_useable.dart';
import '../../Helper/validation.dart';
import '../../commen/ui.dart';
import '../../data/local/local_data.dart';
import '../../models/basic/category_secondry.dart';
import '../../models/basic/customer.dart';
import '../../models/basic/data_basic.dart';
import '../../models/basic/databasicaddServie.dart';
import '../../models/basic/identity_customers.dart';
import '../../models/basic/main_requiremnt.dart';
import '../../models/basic/requst_service_booking.dart';
import '../../models/basic/service.dart';
import '../../models/basic/sub_requiremnt.dart';
import '../../models/basic/trips.dart';
import '../../models/basic/type_filed.dart';
import '../../models/basic/user_request.dart';
import '../../routes/app_pages.dart';
import '../../theme/color.dart';
import '../../theme/theme.dart';
import '../../translations/locale.dart';
import '../MainScrean/controllers/main_screan_controller.dart';
import '../ServicesScreen/controllers/services_screen_controller.dart';
import '../addService/controllers/add_service_controller.dart';
import '../home/controllers/home_controller.dart';
import '../servicesPublic/controllers/services_public_controller.dart';
import 'default_widget.dart';

Container layoutBodyBoking(
    {ServicesScreenController? controller,
    ServicesPublicController? controllerServi}) {
  return controller != null
      ? Container(
          width: Get.size.width,
          height: Get.size.height,
          padding: const EdgeInsets.all(8.0),
          child: Obx(() => controller.isload.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  // key: controller.keyForm,
                  child: Obx(() => ListView.builder(
                        itemCount: controller.requestBookingServices.length,
                        itemBuilder: (context, index) {
                          if (controller.countAdult.value > index) {
                            return Column(
                              children: [
                                Text("البالغ ${index + 1}"),
                                bodyBookingServices(index,
                                    controller: controller),
                              ],
                            );
                          } else if (controller.countAdult.value +
                                      controller.countChildern.value >
                                  index &&
                              controller.groubeVauleIsFamily.value) {
                            return Column(
                              children: [
                                Text(
                                    'طفل ${(index - controller.countAdult.value) + 1}'),
                                bodyBookingServices(index,
                                    controller: controller),
                              ],
                            );
                          } else {
                            return controller.groubeVauleIsFamily.value
                                ? Column(
                                    children: [
                                      Text(
                                          'الرضيع ${(index - controller.countAdult.value - controller.countChildern.value) + 1}'),
                                      bodyBookingServices(index,
                                          controller: controller),
                                    ],
                                  )
                                : Container();
                          }

                          // if (controller.countAdult.value > index) {
                          //           return formCustomerData(context, controller,
                          //               index: index,
                          //               title: 'بيانات المسافر${index + 1} (بالغ)');
                          //         } else if (controller.countAdult.value +
                          //                 controller.countChildern.value >
                          //             index) {
                          //           return formChildernData(context, controller,
                          //               index: index - controller.countAdult.value,
                          //               title:
                          //                   "بيانات المسافر ${index + 1} (طفل اقل من 12 سنة) ");
                          //         } else {
                          //           return formChildernData(context, controller,
                          //               index: index - controller.countAdult.value,
                          //               title:
                          //                   "بيانات المسافر ${index + 1} (رضيع اقل من 2 سنة) ");
                          //         }
                        },
                      )))),
        )
      : Container(
          width: Get.size.width,
          height: Get.size.height,
          padding: const EdgeInsets.all(8.0),
          child: Obx(() => controllerServi!.isload.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  // key: controller.keyForm,
                  child: Obx(() => ListView.builder(
                        itemCount:
                            controllerServi.requestBookingServices.length,
                        itemBuilder: (context, index) {
                          if (controllerServi.countAdult.value > index) {
                            return Column(
                              children: [
                                Text("البالغ ${index + 1}"),
                                bodyBookingServices(index,
                                    controllerServi: controllerServi),
                              ],
                            );
                          } else if (controllerServi.countAdult.value +
                                      controllerServi.countChildern.value >
                                  index &&
                              controllerServi.isFamily.value) {
                            return Column(
                              children: [
                                Text(
                                    'طفل ${(index - controllerServi.countAdult.value) + 1}'),
                                bodyBookingServices(index,
                                    controllerServi: controllerServi),
                              ],
                            );
                          } else {
                            return controllerServi.isFamily.value
                                ? Column(
                                    children: [
                                      Text(
                                          'الرضيع ${(index - controllerServi.countAdult.value - controllerServi.countChildern.value) + 1}'),
                                      bodyBookingServices(index,
                                          controllerServi: controllerServi),
                                    ],
                                  )
                                : Container();
                          }

                          // if (controller.countAdult.value > index) {
                          //           return formCustomerData(context, controller,
                          //               index: index,
                          //               title: 'بيانات المسافر${index + 1} (بالغ)');
                          //         } else if (controller.countAdult.value +
                          //                 controller.countChildern.value >
                          //             index) {
                          //           return formChildernData(context, controller,
                          //               index: index - controller.countAdult.value,
                          //               title:
                          //                   "بيانات المسافر ${index + 1} (طفل اقل من 12 سنة) ");
                          //         } else {
                          //           return formChildernData(context, controller,
                          //               index: index - controller.countAdult.value,
                          //               title:
                          //                   "بيانات المسافر ${index + 1} (رضيع اقل من 2 سنة) ");
                          //         }
                        },
                      )))),
        );
}

Column bodyBookingServices(int index,
    {ServicesScreenController? controller,
    ServicesPublicController? controllerServi}) {
  return controller != null
      ? Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 51, 204, 255),
                        width: 1),
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: DefaultTextFormField(
                            margin: const EdgeInsets.only(left: 15),
                            label: 'الاسم الاول',
                            hintText: 'الاسم الاول',
                            isborderall: true,
                            onchange: (p0) {
                              controller.requestBookingServices[index]
                                  .identityCustomers.name.frisName = p0;
                            },
                          ),
                        ),
                        Expanded(
                          child: DefaultTextFormField(
                            margin: const EdgeInsets.only(left: 15),
                            label: 'الاسم الثاني',
                            hintText: 'ادخل الاسم الثاني',
                            isborderall: true,
                            onchange: (p0) {
                              controller.requestBookingServices[index]
                                  .identityCustomers.name.lastName = p0;
                            },
                          ),
                        ),
                        Expanded(
                          child: DefaultTextFormField(
                            label: 'اللقب',
                            hintText: 'ادخل اللقب',
                            isborderall: true,
                            onchange: (p0) {
                              controller.requestBookingServices[index]
                                  .identityCustomers.name.surName = p0;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // DefaultTextFormField(
                    //   label: 'رقم الهاتف',
                    //   hintText: 'ادخل رقم الهاتف لتواصل',
                    //   isborderall: true,
                    //   keyboardType: TextInputType.phone,
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultDropDownForm(
                        hintText: 'الحالة الاجتماعية',
                        label: const Text('الحالة الاجتماعية'),
                        dataList: controller.dataBasic.value!.martialStatus,
                        onChanged: (p0) {
                          // controller.selectedmartialStatus = p0;
                          controller.requestBookingServices[index]
                              .identityCustomers.martial.value = p0;

                          controller.searchSubrequment(index);
                        },
                        value: controller.requestBookingServices[index]
                            .identityCustomers.martial.value),
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultDropDownForm(
                        hintText: 'نوع الهوية المطلوبة',
                        label: const Text('نوع الهوية المطلوبة'),
                        dataList: controller.service!.identitfyRequerment!,
                        onChanged: (p0) {
                          controller.requestBookingServices[index]
                              .identityCustomers.typeIdentity = p0;
                          controller.test();
                        },
                        value: null),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => DefaultRadioList(
                          data: controller.dataBasic.value!.gender!,
                          groupValue: controller.requestBookingServices[index]
                              .identityCustomers.gender.value,
                          onChanged: (value) {
                            // controller.selectGender.value = value;
                            controller.requestBookingServices[index]
                                .identityCustomers.gender.value = value;
                            controller.searchSubrequment(index);
                          },
                        )),
                    DefaultDataTimePickerWidget(
                      label: const Text('تاريخ الميلاد'),
                      isborderall: true,
                      onChanged: (p0) {
                        Get.log(p0);
                        controller.requestBookingServices[index]
                            .identityCustomers.datePirth = p0;
                      },
                    )
                  ]),
                ),
                Positioned(
                    top: 2,
                    right: 15,
                    child: Container(
                      color: Get.theme.scaffoldBackgroundColor,
                      child: const Text('المعلومات الشخصية'),
                    ))
              ],
            ),
            Stack(
              children: [
                MainRequrmentWidgetList(
                  controler: controller,
                  index: index,
                ),
                Positioned(
                    top: 2,
                    right: 15,
                    child: Container(
                      color: Get.theme.scaffoldBackgroundColor,
                      child: const Text('متطلبات الخدمة'),
                    ))
              ],
            )
          ],
        )
      : Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 51, 204, 255),
                        width: 1),
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: DefaultTextFormField(
                            margin: const EdgeInsets.only(left: 15),
                            label: 'الاسم الاول',
                            hintText: 'الاسم الاول',
                            isborderall: true,
                            onchange: (p0) {
                              controllerServi!.requestBookingServices[index]
                                  .identityCustomers.name.frisName = p0;
                            },
                          ),
                        ),
                        Expanded(
                          child: DefaultTextFormField(
                            margin: const EdgeInsets.only(left: 15),
                            label: 'الاسم الثاني',
                            hintText: 'ادخل الاسم الثاني',
                            isborderall: true,
                            onchange: (p0) {
                              controllerServi!.requestBookingServices[index]
                                  .identityCustomers.name.lastName = p0;
                            },
                          ),
                        ),
                        Expanded(
                          child: DefaultTextFormField(
                            label: 'اللقب',
                            hintText: 'ادخل اللقب',
                            isborderall: true,
                            onchange: (p0) {
                              controllerServi!.requestBookingServices[index]
                                  .identityCustomers.name.surName = p0;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // DefaultTextFormField(
                    //   label: 'رقم الهاتف',
                    //   hintText: 'ادخل رقم الهاتف لتواصل',
                    //   isborderall: true,
                    //   keyboardType: TextInputType.phone,
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultDropDownForm(
                        hintText: 'الحالة الاجتماعية',
                        label: const Text('الحالة الاجتماعية'),
                        dataList:
                            controllerServi!.dataBasic.value!.martialStatus,
                        onChanged: (p0) {
                          // controller.selectedmartialStatus = p0;
                          controllerServi.requestBookingServices[index]
                              .identityCustomers.martial.value = p0;

                          controllerServi.searchSubrequment(index);
                        },
                        value: controllerServi.requestBookingServices[index]
                            .identityCustomers.martial.value),
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultDropDownForm(
                        hintText: 'نوع الهوية المطلوبة',
                        label: const Text('نوع الهوية المطلوبة'),
                        dataList: controllerServi.service!.identitfyRequerment!,
                        onChanged: (p0) {
                          controllerServi.requestBookingServices[index]
                              .identityCustomers.typeIdentity = p0;
                        },
                        value: null),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => DefaultRadioList(
                          data: controllerServi.dataBasic.value!.gender!,
                          groupValue: controllerServi
                              .requestBookingServices[index]
                              .identityCustomers
                              .gender
                              .value,
                          onChanged: (value) {
                            // controller.selectGender.value = value;
                            controllerServi.requestBookingServices[index]
                                .identityCustomers.gender.value = value;
                            controllerServi.searchSubrequment(index);
                          },
                        )),
                    DefaultDataTimePickerWidget(
                      label: const Text('تاريخ الميلاد'),
                      isborderall: true,
                      onChanged: (p0) {
                        Get.log(p0);
                        controllerServi.requestBookingServices[index]
                            .identityCustomers.datePirth = p0;
                      },
                    )
                  ]),
                ),
                Positioned(
                    top: 2,
                    right: 15,
                    child: Container(
                      color: Get.theme.scaffoldBackgroundColor,
                      child: const Text('المعلومات الشخصية'),
                    ))
              ],
            ),
            Stack(
              children: [
                MainRequrmentWidgetList(
                  controlerServ: controllerServi,
                  index: index,
                ),
                Positioned(
                    top: 2,
                    right: 15,
                    child: Container(
                      color: Get.theme.scaffoldBackgroundColor,
                      child: const Text('متطلبات الخدمة'),
                    ))
              ],
            )
          ],
        );
}

class MainRequrmentWidgetList extends StatelessWidget {
  const MainRequrmentWidgetList(
      {super.key, this.controler, this.controlerServ, required this.index});
  final ServicesScreenController? controler;
  final ServicesPublicController? controlerServ;

  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        choosCorrectWidgetMainRequ(index),
        Divider(
          color: Get.theme.colorScheme.primary,
        ),
        Obx(() => choosCorrectWidgetSubRequ(index))
      ],
    );
  }

  Widget choosCorrectWidgetMainRequ(int index) {
    return controler != null
        ? Column(
            children: controler!.service!.mainRequirment!
                .asMap()
                .entries
                .map((e) => e.value.typeFiled!.id == 1
                    ? DefaultTextFormField(
                        keyboardType: TextInputType.text,
                        label: e.value.name,
                        hintText: '',
                        isborderall: true,
                        onchange: (p0) {
                          controler!.saveDataRequst(
                              indexPerson: index,
                              idMain: e.value.id,
                              indexMain: e.key,
                              indexTypFiled: e.value.typeFiled!.id!,
                              value: p0);
                        },
                      )
                    : e.value.typeFiled!.id == 2
                        ? DefaultImagePicker(
                            main: e.value,
                            onTap: () async {
                              await alertChoiseImagePicker();
                              await controler!.saveDataRequst(
                                indexPerson: index,
                                idMain: e.value.id,
                                indexMain: e.key,
                                indexTypFiled: e.value.typeFiled!.id!,
                                value: controler!.image!.path,
                                // fileName: controler.image!.name
                              );

                              // await controler.pickImage();
                            },
                          )
                        : e.value.typeFiled!.id == 3
                            ? DefaultTextFormField(
                                keyboardType: TextInputType.number,
                                label: e.value.name,
                                hintText: '',
                                isborderall: true,
                                onchange: (p0) {
                                  controler!.saveDataRequst(
                                      indexPerson: index,
                                      idMain: e.value.id,
                                      indexMain: e.key,
                                      indexTypFiled: e.value.typeFiled!.id!,
                                      value: p0);
                                },
                              )
                            : e.value.typeFiled!.id == 4
                                ? DefaultDataTimePickerWidget(
                                    isborderall: true,
                                    onChanged: (p0) {
                                      controler!.saveDataRequst(
                                          indexPerson: index,
                                          idMain: e.value.id,
                                          indexMain: e.key,
                                          indexTypFiled: e.value.typeFiled!.id!,
                                          value: p0);
                                    },
                                  )
                                : e.value.typeFiled!.id == 5
                                    ? DefaultFilePicker(
                                        main: e.value,
                                        onTap: () async {
                                          await controler!.filePiicker();
                                          await controler!.saveDataRequst(
                                            indexPerson: index,
                                            idMain: e.value.id,
                                            indexMain: e.key,
                                            indexTypFiled:
                                                e.value.typeFiled!.id!,
                                            value: controler!.fileCurrent!.path,
                                          );
                                        },
                                      )
                                    : e.value.typeFiled!.id == 9
                                        ? Obx(
                                            () => DefaultRadioList(
                                              data: e.value.choose!,
                                              groupValue: controler!
                                                  .requestBookingServices[index]
                                                  .detailsMain![e.key]
                                                  .choice
                                                  .value,
                                              onChanged: (value) {
                                                controler!.saveDataRequst(
                                                    indexPerson: index,
                                                    idMain: e.value.id,
                                                    indexMain: e.key,
                                                    indexTypFiled:
                                                        e.value.typeFiled!.id!,
                                                    value: value);
                                              },
                                            ),
                                          )
                                        : e.value.typeFiled!.id == 8
                                            ? DefaultDropDownForm(
                                                // hintText: 'نوع الهوية المطلوبة',
                                                label: Text(e.value.name!),
                                                dataList: e.value.choose,
                                                onChanged: (p0) {
                                                  controler!.saveDataRequst(
                                                      indexPerson: index,
                                                      idMain: e.value.id,
                                                      indexMain: e.key,
                                                      indexTypFiled: e
                                                          .value.typeFiled!.id!,
                                                      value: p0);
                                                },
                                                value: controler!
                                                    .requestBookingServices[
                                                        index]
                                                    .detailsMain![e.key]
                                                    .choice
                                                    .value)
                                            : const Text(''))
                .toList(),
          )
        : Column(
            children: controlerServ!.service!.mainRequirment!
                .asMap()
                .entries
                .map((e) => e.value.typeFiled!.id == 1
                    ? DefaultTextFormField(
                        keyboardType: TextInputType.text,
                        label: e.value.name,
                        hintText: '',
                        isborderall: true,
                        onchange: (p0) {
                          controlerServ!.saveDataRequst(
                              indexPerson: index,
                              idMain: e.value.id,
                              indexMain: e.key,
                              indexTypFiled: e.value.typeFiled!.id!,
                              value: p0);
                        },
                      )
                    : e.value.typeFiled!.id == 2
                        ? DefaultImagePicker(
                            main: e.value,
                            onTap: () async {
                              await alertChoiseImagePicker();
                              await controlerServ!.saveDataRequst(
                                indexPerson: index,
                                idMain: e.value.id,
                                indexMain: e.key,
                                indexTypFiled: e.value.typeFiled!.id!,
                                value: controlerServ!.image!.path,
                                // fileName: controler.image!.name
                              );

                              // await controler.pickImage();
                            },
                          )
                        : e.value.typeFiled!.id == 3
                            ? DefaultTextFormField(
                                keyboardType: TextInputType.number,
                                label: e.value.name,
                                hintText: '',
                                isborderall: true,
                                onchange: (p0) {
                                  controlerServ!.saveDataRequst(
                                      indexPerson: index,
                                      idMain: e.value.id,
                                      indexMain: e.key,
                                      indexTypFiled: e.value.typeFiled!.id!,
                                      value: p0);
                                },
                              )
                            : e.value.typeFiled!.id == 4
                                ? DefaultDataTimePickerWidget(
                                    label: Text(
                                      e.value.name!,
                                      style: Get.textTheme.headlineMedium,
                                    ),
                                    isborderall: true,
                                    onChanged: (p0) {
                                      controlerServ!.saveDataRequst(
                                          indexPerson: index,
                                          idMain: e.value.id,
                                          indexMain: e.key,
                                          indexTypFiled: e.value.typeFiled!.id!,
                                          value: p0);
                                    },
                                  )
                                : e.value.typeFiled!.id == 5
                                    ? DefaultFilePicker(
                                        main: e.value,
                                        onTap: () async {
                                          await controlerServ!.filePiicker();
                                          await controlerServ!.saveDataRequst(
                                            indexPerson: index,
                                            idMain: e.value.id,
                                            indexMain: e.key,
                                            indexTypFiled:
                                                e.value.typeFiled!.id!,
                                            value: controlerServ!
                                                .fileCurrent!.path,
                                          );
                                        },
                                      )
                                    : e.value.typeFiled!.id == 9
                                        ? Obx(
                                            () => DefaultRadioList(
                                              data: e.value.choose!,
                                              groupValue: controlerServ!
                                                  .requestBookingServices[index]
                                                  .detailsMain![e.key]
                                                  .choice
                                                  .value,
                                              onChanged: (value) {
                                                controlerServ!.saveDataRequst(
                                                    indexPerson: index,
                                                    idMain: e.value.id,
                                                    indexMain: e.key,
                                                    indexTypFiled:
                                                        e.value.typeFiled!.id!,
                                                    value: value);
                                              },
                                            ),
                                          )
                                        : e.value.typeFiled!.id == 8
                                            ? DefaultDropDownForm(
                                                // hintText: 'نوع الهوية المطلوبة',
                                                label: Text(e.value.name!),
                                                dataList: e.value.choose,
                                                onChanged: (p0) {
                                                  controlerServ!.saveDataRequst(
                                                      indexPerson: index,
                                                      idMain: e.value.id,
                                                      indexMain: e.key,
                                                      indexTypFiled: e
                                                          .value.typeFiled!.id!,
                                                      value: p0);
                                                },
                                                value: controlerServ!
                                                    .requestBookingServices[
                                                        index]
                                                    .detailsMain![e.key]
                                                    .choice
                                                    .value)
                                            : const Text(''))
                .toList(),
          );
  }

  Widget choosCorrectWidgetSubRequ(int index) {
    return controler != null
        ? controler!.requestBookingServices[index].subRequiremnt!.value ==
                    null ||
                controler!.requestBookingServices[index].subRequiremnt!.value!
                        .idSubRequerment ==
                    -99
            ? Container()
            : Column(
                mainAxisSize: MainAxisSize.max,
                children: controler!.requestBookingServices[index]
                    .subRequiremnt!.value!.detaial!
                    .asMap()
                    .entries
                    .map((e) => e.value.typeFiled!.id == 1
                        ? Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: DefaultTextFormField(
                              keyboardType: TextInputType.text,
                              label: e.value.containt,
                              hintText: '',
                              isborderall: true,
                              onchange: (p0) {
                                controler!.saveDataRequst(
                                    indexPerson: index,
                                    idSub: e.value.id,
                                    indexSub: e.key,
                                    indexTypFiled: e.value.typeFiled!.id!,
                                    value: p0);
                              },
                            ),
                          )
                        : e.value.typeFiled!.id == 2
                            ? DefaultImagePicker(
                                main: e.value,
                                onTap: () async {
                                  await alertChoiseImagePicker();
                                  await controler!.saveDataRequst(
                                      indexPerson: index,
                                      idSub: e.value.id,
                                      indexSub: e.key,
                                      indexTypFiled: e.value.typeFiled!.id!,
                                      value: controler!.image!.path);
                                },
                              )
                            : e.value.typeFiled!.id == 3
                                ? DefaultTextFormField(
                                    keyboardType: TextInputType.number,
                                    label: e.value.containt,
                                    hintText: '',
                                    isborderall: true,
                                    onchange: (p0) {
                                      controler!.saveDataRequst(
                                          indexPerson: index,
                                          idSub: e.value.id,
                                          indexSub: e.key,
                                          indexTypFiled: e.value.typeFiled!.id!,
                                          value: p0);
                                    },
                                  )
                                : e.value.typeFiled!.id == 4
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: DefaultDataTimePickerWidget(
                                          label: Text(e.value.containt ?? ''),
                                          isborderall: true,
                                          onChanged: (p0) {
                                            controler!.saveDataRequst(
                                                indexPerson: index,
                                                idSub: e.value.id,
                                                indexSub: e.key,
                                                indexTypFiled:
                                                    e.value.typeFiled!.id!,
                                                value: p0);
                                          },
                                        ),
                                      )
                                    : e.value.typeFiled!.id == 5
                                        ? DefaultFilePicker(
                                            main: e.value,
                                            onTap: () async {
                                              await controler!.filePiicker();
                                              await controler!.saveDataRequst(
                                                  indexPerson: index,
                                                  idSub: e.value.id,
                                                  indexSub: e.key,
                                                  indexTypFiled:
                                                      e.value.typeFiled!.id!,
                                                  value: controler!
                                                      .fileCurrent!.path);
                                            },
                                          )
                                        : e.value.typeFiled!.id == 9
                                            ? DefaultRadioList(
                                                data: e.value.choose!,
                                                groupValue: controler!
                                                    .requestBookingServices[
                                                        index]
                                                    .detailsSub![e.key]
                                                    .choiceSub
                                                    .value,
                                                onChanged: (value) {
                                                  // controler.selectedChoose = value;
                                                  controler!.saveDataRequst(
                                                      indexPerson: index,
                                                      idSub: e.value.id,
                                                      indexSub: e.key,
                                                      indexTypFiled: e
                                                          .value.typeFiled!.id!,
                                                      value: value);
                                                },
                                              )
                                            : e.value.typeFiled!.id == 8
                                                ? DefaultDropDownForm(
                                                    // hintText: 'نوع الهوية المطلوبة',
                                                    label:
                                                        Text(e.value.containt!),
                                                    dataList: e.value.choose,
                                                    onChanged: (p0) {
                                                      controler!.saveDataRequst(
                                                          indexPerson: index,
                                                          idSub: e.value.id,
                                                          indexSub: e.key,
                                                          indexTypFiled: e.value
                                                              .typeFiled!.id!,
                                                          value: p0);
                                                    },
                                                    value: controler!
                                                        .requestBookingServices[
                                                            index]
                                                        .detailsSub![e.key]
                                                        .choiceSub
                                                        .value,
                                                  )
                                                : const Text(''))
                    .toList(),
              )
        : controlerServ!.requestBookingServices[index].subRequiremnt!.value ==
                    null ||
                controlerServ!.requestBookingServices[index].subRequiremnt!
                        .value!.idSubRequerment ==
                    -99
            ? Container()
            : Column(
                mainAxisSize: MainAxisSize.max,
                children: controlerServ!.requestBookingServices[index]
                    .subRequiremnt!.value!.detaial!
                    .asMap()
                    .entries
                    .map((e) => e.value.typeFiled!.id == 1
                        ? Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: DefaultTextFormField(
                              keyboardType: TextInputType.text,
                              label: e.value.containt,
                              hintText: '',
                              isborderall: true,
                              onchange: (p0) {
                                controlerServ!.saveDataRequst(
                                    indexPerson: index,
                                    idSub: e.value.id,
                                    indexSub: e.key,
                                    indexTypFiled: e.value.typeFiled!.id!,
                                    value: p0);
                              },
                            ),
                          )
                        : e.value.typeFiled!.id == 2
                            ? DefaultImagePicker(
                                main: e.value,
                                onTap: () async {
                                  await alertChoiseImagePicker();
                                  await controlerServ!.saveDataRequst(
                                      indexPerson: index,
                                      idSub: e.value.id,
                                      indexSub: e.key,
                                      indexTypFiled: e.value.typeFiled!.id!,
                                      value: controlerServ!.image!.path);
                                },
                              )
                            : e.value.typeFiled!.id == 3
                                ? DefaultTextFormField(
                                    keyboardType: TextInputType.number,
                                    label: e.value.containt,
                                    hintText: '',
                                    isborderall: true,
                                    onchange: (p0) {
                                      controlerServ!.saveDataRequst(
                                          indexPerson: index,
                                          idSub: e.value.id,
                                          indexSub: e.key,
                                          indexTypFiled: e.value.typeFiled!.id!,
                                          value: p0);
                                    },
                                  )
                                : e.value.typeFiled!.id == 4
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: DefaultDataTimePickerWidget(
                                          label: Text(e.value.containt ?? ''),
                                          isborderall: true,
                                          onChanged: (p0) {
                                            controlerServ!.saveDataRequst(
                                                indexPerson: index,
                                                idSub: e.value.id,
                                                indexSub: e.key,
                                                indexTypFiled:
                                                    e.value.typeFiled!.id!,
                                                value: p0);
                                          },
                                        ),
                                      )
                                    : e.value.typeFiled!.id == 5
                                        ? DefaultFilePicker(
                                            main: e.value,
                                            onTap: () async {
                                              await controlerServ!
                                                  .filePiicker();
                                              await controlerServ!
                                                  .saveDataRequst(
                                                      indexPerson: index,
                                                      idSub: e.value.id,
                                                      indexSub: e.key,
                                                      indexTypFiled: e
                                                          .value.typeFiled!.id!,
                                                      value: controlerServ!
                                                          .fileCurrent!.path);
                                            },
                                          )
                                        : e.value.typeFiled!.id == 9
                                            ? DefaultRadioList(
                                                data: e.value.choose!,
                                                groupValue: controlerServ!
                                                    .requestBookingServices[
                                                        index]
                                                    .detailsSub![e.key]
                                                    .choiceSub
                                                    .value,
                                                onChanged: (value) {
                                                  // controler.selectedChoose = value;
                                                  controlerServ!.saveDataRequst(
                                                      indexPerson: index,
                                                      idSub: e.value.id,
                                                      indexSub: e.key,
                                                      indexTypFiled: e
                                                          .value.typeFiled!.id!,
                                                      value: value);
                                                },
                                              )
                                            : e.value.typeFiled!.id == 8
                                                ? DefaultDropDownForm(
                                                    // hintText: 'نوع الهوية المطلوبة',
                                                    label:
                                                        Text(e.value.containt!),
                                                    dataList: e.value.choose,
                                                    onChanged: (p0) {
                                                      controlerServ!
                                                          .saveDataRequst(
                                                              indexPerson:
                                                                  index,
                                                              idSub: e.value.id,
                                                              indexSub: e.key,
                                                              indexTypFiled: e
                                                                  .value
                                                                  .typeFiled!
                                                                  .id!,
                                                              value: p0);
                                                    },
                                                    value: controlerServ!
                                                        .requestBookingServices[
                                                            index]
                                                        .detailsSub![e.key]
                                                        .choiceSub
                                                        .value,
                                                  )
                                                : const Text(''))
                    .toList(),
              );
  }

  Future alertChoiseImagePicker() => UiApp.defaultDeialog(
        title: 'مكان الصورة',
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                if (controler != null) {
                  controler!.pickImage(true);
                } else {
                  controlerServ!.pickImage(true);
                }
              },
              child: Column(
                children: [
                  DefaultIcon(
                    icon: Icons.camera,
                  ),
                  Center(
                    child:
                        Text('الكاميرة', style: Get.textTheme.headlineMedium),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (controler != null) {
                  controler!.pickImage(false);
                } else {
                  controlerServ!.pickImage(false);
                }
              },
              child: Column(
                children: [
                  DefaultIcon(
                    icon: Icons.image,
                  ),
                  Center(
                    child: Text(
                      'المعرض',
                      style: Get.textTheme.headlineMedium,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        confirm: defaultButton(
            isResponseve: false,
            isIcon: false,
            lable: 'الغاء',
            color: Get.theme.colorScheme.primary,
            onPressed: () {
              Get.back();
            }),
      );
}

Future<IdentitBeneficiares?> addIdentitBottomSheet(dynamic controller) async {
  IdentitBeneficiares identity = IdentitBeneficiares(
      identityCustomer: IdentityCustomers(
          gender: Rx<Gender?>(null),
          martial: Rx<MartialStatus?>(null),
          name: Name()));
  final keyform = GlobalKey<FormState>();
  return await Get.bottomSheet(
      isScrollControlled: true,
      ignoreSafeArea: true,
      SafeArea(
          child: Container(
              color: Get.theme.colorScheme.secondary,
              height: Get.height - 100,
              child: Form(
                key: keyform,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () {
                              identity.isMe = false;
                              Get.back<IdentitBeneficiares?>(result: null);
                            },
                            icon: DefaultIcon(
                              icon: Icons.close,
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Get.theme.colorScheme.primary, width: 1),
                          borderRadius: BorderRadius.circular(5),
                          shape: BoxShape.rectangle,
                        ),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: DefaultTextFormField(
                                  margin: const EdgeInsets.only(left: 15),
                                  label: 'الاسم الاول',
                                  hintText: 'الاسم الاول',
                                  validator: (value) {
                                    return ValidatorApp.getVaidator(
                                        ValidateType.required, value);
                                  },
                                  isborderall: true,
                                  onchange: (p0) {
                                    // controller.requestBookingServices[index]
                                    identity.identityCustomer!.name.frisName =
                                        p0;
                                  },
                                ),
                              ),
                              Expanded(
                                child: DefaultTextFormField(
                                  margin: const EdgeInsets.only(left: 15),
                                  label: 'الاسم الثاني',
                                  hintText: 'ادخل الاسم الثاني',
                                  isborderall: true,
                                  validator: (value) {
                                    return ValidatorApp.getVaidator(
                                        ValidateType.required, value);
                                  },
                                  onchange: (p0) {
                                    // controller.requestBookingServices[index]
                                    identity.identityCustomer!.name.lastName =
                                        p0;
                                  },
                                ),
                              ),
                              Expanded(
                                child: DefaultTextFormField(
                                  label: 'اللقب',
                                  hintText: 'ادخل اللقب',
                                  isborderall: true,
                                  validator: (value) {
                                    return ValidatorApp.getVaidator(
                                        ValidateType.required, value);
                                  },
                                  onchange: (p0) {
                                    // controller.requestBookingServices[index]
                                    identity.identityCustomer!.name.surName =
                                        p0;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // DefaultTextFormField(
                          //   label: 'رقم الهاتف',
                          //   hintText: 'ادخل رقم الهاتف لتواصل',
                          //   isborderall: true,
                          //   keyboardType: TextInputType.phone,
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          DefaultDropDownForm(
                              validator: (p0) {
                                if (p0 == null) {
                                  return 'لا تترك الحقل فارغ';
                                } else {
                                  return null;
                                }
                              },
                              hintText: 'الحالة الاجتماعية',
                              label: const Text('الحالة الاجتماعية'),
                              dataList: controller is ServicesScreenController
                                  ? controller.dataBasic.value!.martialStatus
                                  : controller is ServicesPublicController
                                      ? controller
                                          .dataBasic.value!.martialStatus
                                      : [],
                              onChanged: (p0) {
                                identity.identityCustomer!.martial.value = p0;
                              },
                              value: identity.identityCustomer!.martial.value),
                          const SizedBox(
                            height: 10,
                          ),
                          DefaultDropDownForm(
                              validator: (p0) {
                                if (p0 == null) {
                                  return 'لا تترك الحقل فارغ';
                                } else {
                                  return null;
                                }
                              },
                              hintText: 'نوع الهوية المطلوبة',
                              label: const Text('نوع الهوية المطلوبة'),
                              dataList: controller is ServicesScreenController
                                  ? controller.service!.identitfyRequerment!
                                  : controller is ServicesPublicController
                                      ? controller.service!.identitfyRequerment!
                                      : [],
                              onChanged: (p0) {
                                identity.identityCustomer!.typeIdentity = p0;
                                // controller.requestBookingServices[index]
                                //     .identityCustomers.typeIdentity = p0;
                                // controller.test();
                              },
                              value: null),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() => DefaultRadioList(
                                data: controller is ServicesScreenController
                                    ? controller.dataBasic.value!.gender!
                                    : controller is ServicesPublicController
                                        ? controller.dataBasic.value!.gender!
                                        : [],
                                groupValue:
                                    identity.identityCustomer!.gender.value,
                                onChanged: (value) {
                                  identity.identityCustomer!.gender.value =
                                      value;
                                },
                              )),

                          DefaultDataTimePickerWidget(
                            validator: (value) {
                              return ValidatorApp.getVaidator(
                                  ValidateType.required, value);
                            },
                            label: const Text('تاريخ الميلاد'),
                            isborderall: true,
                            onChanged: (p0) {
                              Get.log(p0);
                              identity.identityCustomer!.datePirth = p0;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultButton(
                              isResponseve: false,
                              isIcon: false,
                              lable: 'اضافة',
                              onPressed: () {
                                if (keyform.currentState!.validate()) {
                                  identity.isSelected.value = true;
                                  Get.back<IdentitBeneficiares?>(
                                      result: identity);
                                }
                              })
                        ]),
                      ),
                    ],
                  ),
                ),
              ))));
}

Future<SubRequiremnt?> addSubRequermentDialog(
    DataBasicOfAddServic data, AddServiceController controller) async {
  bool isFamily = false;
  Gender gender = Gender();
  SubRequiremnt? subRequiremnt = SubRequiremnt(isFamely: false);
  final keyform = GlobalKey<FormState>();
  String errorGender = '';
  return await Get.defaultDialog<SubRequiremnt?>(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      onWillPop: () {
        return Future.value(false);
      },
      content: Container(
        color: Get.theme.colorScheme.secondary,
        // height: Get.height - 100,
        child: Form(
          key: keyform,
          child: SingleChildScrollView(
            child: Column(children: [
              GetBuilder<AddServiceController>(
                id: 'Gender',
                // init: AddServiceController(),
                initState: (_) {},
                builder: (_) {
                  return Column(
                    children: [
                      DefaultRadioList(
                          titleText: 'تحديد الجنس',
                          data: data.gender,
                          onChanged: (value) {
                            if (value is Gender) {
                              gender = value;
                              subRequiremnt.gender = gender.idGender;
                            }
                            controller.updataGender();
                          },
                          groupValue: gender),
                      if (errorGender.isNotEmpty)
                        Center(
                            child: Text(errorGender,
                                style: Get.textTheme.headlineSmall!
                                    .merge(const TextStyle(color: Colors.red))))
                    ],
                  );
                },
              ),
              DefaultDropDownForm(
                  validator: (value) => ValidatorApp.getVaidator(
                      ValidateType.required,
                      value is MartialStatus ? value.nameAr : ''),
                  label: Text("تحديد الحالة الاجتماعية",
                      style: Get.textTheme.headlineSmall),
                  dataList: data.martialStatus,
                  onChanged: (value) {
                    if (value is MartialStatus) {
                      subRequiremnt.idMartial = value.idMartial;
                    }
                  },
                  value: null),
              BorderCoverWidget(
                label: 'الفترة العمرة',
                child: Row(
                  children: [
                    Expanded(
                      child: DefaultTextFormField(
                        label: 'اكبر من',
                        validator: (value) => ValidatorApp.getVaidator(
                            ValidateType.required, value),
                        isborderall: true,
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        onchange: (value) {
                          subRequiremnt.moreThanAge = int.tryParse(value);
                          controller.updateDetailsSubRequement();
                        },
                        onEditingComplete: () {
                          controller.updateDetailsSubRequement();
                        },
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: DefaultTextFormField(
                          label: 'اقل من ',
                          isborderall: true,
                          validator: (value) => ValidatorApp.getVaidator(
                              ValidateType.required, value),
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          onchange: (value) {
                            subRequiremnt.lessThanAge = int.tryParse(value);
                            controller.updateDetailsSubRequement();
                          },
                          onEditingComplete: () {
                            controller.updateDetailsSubRequement();
                          }),
                    ),
                  ],
                ),
              ),
              GetBuilder<AddServiceController>(
                id: 'isFamly',
                // init: AddServiceController(),
                initState: (_) {},
                builder: (_) {
                  return BorderCoverWidget(
                      label: 'عائلي/غير عائلي',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: GFRadioListTile(
                              titleText: 'عائلي',
                              color: Get.theme.colorScheme.secondary,
                              radioColor: Get.theme.colorScheme.primary,
                              groupValue: isFamily,
                              value: true,
                              onChanged: (value) {
                                // controller.groubeVauleIsFamily.value = value;
                                isFamily = true;
                                subRequiremnt.isFamely = isFamily;
                                controller.updateisFamily();
                              },
                            ),
                          ),
                          Expanded(
                            child: GFRadioListTile(
                              selected: true,
                              color: Get.theme.colorScheme.secondary,
                              radioColor: Get.theme.colorScheme.primary,
                              titleText: 'غير عائلي',
                              groupValue: isFamily,
                              value: false,
                              onChanged: (value) {
                                isFamily = false;
                                subRequiremnt.isFamely = isFamily;

                                controller.updateisFamily();
                              },
                            ),
                          ),
                        ],
                      ));
                },
              ),
              itemDetialsSubReq(subRequiremnt, controller),
            ]),
          ),
        ),
      ),
      confirm: defaultButton(
        isResponseve: false,
        isIcon: false,
        lable: 'حفظ ',
        onPressed: () {
          if (keyform.currentState!.validate()) {
            Get.back<SubRequiremnt?>(result: subRequiremnt);
          }
        },
      ),
      cancel: defaultButton(
          isResponseve: false,
          isIcon: false,
          lable: 'الغاء ',
          onPressed: () {
            Get.back<SubRequiremnt?>(result: null);
          }));
}

Container itemDetialsSubReq(
    SubRequiremnt subRequiremnt, AddServiceController controller) {
  return Container(
    child: GetBuilder<AddServiceController>(
      id: 'DetailsSubRequement',
      initState: (_) {},
      builder: (_) {
        if (subRequiremnt.gender != null &&
            // subRequiremnt.isFamely != null &&
            subRequiremnt.idMartial != null &&
            subRequiremnt.moreThanAge != null &&
            subRequiremnt.lessThanAge != null) {
          GlobalKey<FormState> keyForm = GlobalKey<FormState>();
          return Form(
            key: keyForm,
            child: SizedBox(
              height: 150,
              child: BorderCoverWidget(
                  label: 'المتطلبات الفرعية',
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                            children: subRequiremnt.detaial!
                                .asMap()
                                .entries
                                .map((eSubreq) => Container(
                                      margin: const EdgeInsets.all(8.0),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: DefaultTextFormField(
                                              initialValue:
                                                  eSubreq.value.containt,
                                              validator: (p0) =>
                                                  ValidatorApp.getVaidator(
                                                      ValidateType.required,
                                                      p0),
                                              isborderall: true,
                                              label: 'اسم المتطلب',
                                              hintText: 'ادخل اسم المتطلب',
                                              onchange: (value) {
                                                eSubreq.value.containt = value;
                                                controller
                                                    .updateDropDownTypeFild();
                                              },
                                            ),
                                          ),
                                          const Spacer(),
                                          Expanded(
                                            flex: 2,
                                            child: GetBuilder<
                                                AddServiceController>(
                                              id: 'DropDownTypeFild',
                                              // init: AddServiceController(),
                                              initState: (_) {},
                                              builder: (_) {
                                                return eSubreq.value.containt ==
                                                            null ||
                                                        eSubreq.value.containt!
                                                            .isEmpty
                                                    ? Container()
                                                    : DefaultDropDownForm(
                                                        validator: (p0) =>
                                                            ValidatorApp.getVaidator(
                                                                ValidateType
                                                                    .required,
                                                                p0 is TypeFiled
                                                                    ? p0.name
                                                                    : ''),
                                                        label: Text(
                                                          'قم بختيار نوع المتطلب',
                                                          style: Get.textTheme
                                                              .headlineSmall,
                                                        ),
                                                        dataList: controller
                                                            .dataBasic
                                                            ?.typeFiled,
                                                        onChanged:
                                                            (value) async {
                                                          if (keyForm
                                                              .currentState!
                                                              .validate()) {
                                                            eSubreq.value
                                                                    .typeFiled =
                                                                value;
                                                            if (eSubreq
                                                                        .value
                                                                        .typeFiled!
                                                                        .id ==
                                                                    8 ||
                                                                eSubreq
                                                                        .value
                                                                        .typeFiled!
                                                                        .id ==
                                                                    9) {
                                                              GlobalKey<
                                                                      FormState>
                                                                  keyAddChoice =
                                                                  GlobalKey<
                                                                      FormState>();
                                                              await UiApp.defaultDeialog(
                                                                  onWillPop: () {
                                                                    return Future
                                                                        .value(
                                                                            false);
                                                                  },
                                                                  confirm: defaultButton(
                                                                      isResponseve: true,
                                                                      isIcon: false,
                                                                      lable: 'تم',
                                                                      onPressed: () {
                                                                        if (keyAddChoice
                                                                            .currentState!
                                                                            .validate()) {
                                                                          Get.back();
                                                                        }
                                                                      }),
                                                                  cancel: defaultButton(
                                                                      isResponseve: true,
                                                                      isIcon: false,
                                                                      lable: 'الفاء',
                                                                      onPressed: () {
                                                                        eSubreq
                                                                            .value
                                                                            .choose = [];
                                                                        eSubreq
                                                                            .value
                                                                            .name = null;

                                                                        controller
                                                                            .updateDetailsSubRequement();
                                                                        Get.back();
                                                                      }),
                                                                  title: "اضافة خيار للمتطلب",
                                                                  content: GetBuilder<AddServiceController>(
                                                                    id: 'AddChoiceSub',
                                                                    // init:
                                                                    //     AddServiceController(),
                                                                    initState:
                                                                        (_) {},
                                                                    builder:
                                                                        (_) {
                                                                      return itemAddChoic(
                                                                          eSubreq,
                                                                          controller,
                                                                          keyAddChoice);
                                                                    },
                                                                  ));
                                                            }

                                                            controller
                                                                .updateDetailsSubRequement();
                                                          } else {
                                                            // eSubreq.value.typeFiled =
                                                            //     null;
                                                          }
                                                        },
                                                        value: eSubreq
                                                            .value.typeFiled);
                                              },
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                subRequiremnt.detaial!
                                                    .removeAt(eSubreq.key);
                                                controller
                                                    .updateDetailsSubRequement();
                                              },
                                              icon: const Icon(Icons.close))
                                        ],
                                      ),
                                    ))
                                .toList()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  // if (keyForm.currentState!.validate()) {
                                  subRequiremnt.detaial!
                                      .add(SubRequirmentDetails());
                                  controller.updateDetailsSubRequement();
                                  // }
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Get.theme.colorScheme.primary,
                                )),
                            Center(
                              child: Text(
                                'اضافة متطلب مخصص',
                                style: Get.textTheme.headlineSmall,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          );
        } else {
          return Container();
        }
      },
    ),
  );
}

SizedBox itemAddChoic(MapEntry<int, SubRequirmentDetails> eSubreq,
    AddServiceController controller, GlobalKey<FormState> keyAddChoice) {
  return SizedBox(
    width: Get.width / 2,
    height: Get.height / 2,
    child: Form(
      key: keyAddChoice,
      child: Column(
        children: [
          SingleChildScrollView(
              child: Column(
            children: eSubreq.value.choose
                    ?.asMap()
                    .entries
                    .map(
                      (edialog) => Row(
                        children: [
                          Expanded(
                            child: DefaultTextFormField(
                              validator: (value) => ValidatorApp.getVaidator(
                                  ValidateType.required, value),
                              initialValue: edialog.value.containt,
                              label: '  الخيار رقم '.toString() +
                                  (edialog.key + 1).toString(),
                              isborderall: true,
                              onchange: (p0) {
                                edialog.value.containt = p0;
                              },
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                eSubreq.value.choose?.removeAt(edialog.key);
                                controller.updateAddChoiceSub();
                              },
                              icon: const Icon(Icons.close))
                        ],
                      ),
                    )
                    .toList() ??
                [],
          )),
          GestureDetector(
            onTap: () {
              if (keyAddChoice.currentState!.validate()) {
                eSubreq.value.choose!.add(ChooseSub());
                controller.updateAddChoiceSub();
              }
            },
            child: Row(
              children: [
                const Icon(Icons.add),
                Text(
                  'اضافة خيار',
                  style: Get.textTheme.headlineSmall,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

class CustomerIdentenyItem extends GetView {
  const CustomerIdentenyItem(
      {super.key,
      required this.identity,
      required this.isShowonly,
      this.onChanged});
  final void Function(bool?)? onChanged;
  final bool isShowonly;
  final IdentitBeneficiares identity;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: DefaultIcon.svg(
        path: 'icons/profile.svg',
        width: 40,
        height: 40,
      ),
      title: Text(identity.identityCustomer!.nameid!,
          style: Get.textTheme.headlineMedium),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              LocaleKeys.personalData_gender.tr +
                  DataConst.comme +
                  identity.identityCustomer!.gender.value!.nameAr!,
              style: Get.textTheme.headlineMedium),
          Text(
            'تاريخ الميلاد'.toString() +
                DataConst.comme +
                identity.identityCustomer!.datePirth!,
            style: Get.textTheme.headlineMedium,
          ),
          Text(
              'الحالة الاجتماعية'.toString() +
                  DataConst.comme +
                  identity.identityCustomer!.martial.value!.nameAr!,
              style: Get.textTheme.headlineMedium),
          Text(
              'نوع الهوية'.toString() +
                  DataConst.comme +
                  identity.identityCustomer!.typeIdentity!.name!,
              style: Get.textTheme.headlineMedium),
        ],
      ),
      trailing: !isShowonly
          ? Obx(() => Checkbox(
              value: identity.isSelected.value,
              onChanged: (value) {
                identity.isSelected.value = value!;
                onChanged!(value);

                // controller.currentUser.value!.isSelected = value!;
              }))
          : null,
    );
  }
}

Future bootomSheetBookingService(
    Service service, ServicesPublicController controller) {
  return Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  service.name!,
                  style: Get.textTheme.titleLarge,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  const Text('نوع الحجز'),
                  Obx(() => itemIsFamilyWidget(controller))
                ],
              ),
              Obx(() => Column(children: [
                    Row(
                      children: [
                        Expanded(child: DefaultText('البالغين')),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        controller.incrementCountTravels(id: 1);
                                      },
                                      icon: const Icon(Icons.add))),
                              Expanded(
                                child: Obx(() => Center(
                                    child: DefaultText(controller
                                        .countAdult.value
                                        .toString()))),
                              ),
                              Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        controller.decrementCountTravels(id: 1);
                                      },
                                      icon: const Icon(Icons.remove))),
                            ],
                          ),
                        )
                      ],
                    ),
                    controller.isFamily.value
                        ? Row(
                            children: [
                              Expanded(child: DefaultText('الأطفال اقل 12')),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: IconButton(
                                            onPressed: () {
                                              controller.incrementCountTravels(
                                                  id: 2);
                                            },
                                            icon: const Icon(Icons.add))),
                                    Expanded(
                                      child: Obx(() => Center(
                                            child: DefaultText(controller
                                                .countChildern.value
                                                .toString()),
                                          )),
                                    ),
                                    Expanded(
                                        child: IconButton(
                                            onPressed: () {
                                              controller.decrementCountTravels(
                                                  id: 2);
                                            },
                                            icon: const Icon(Icons.remove))),
                                  ],
                                ),
                              )
                            ],
                          )
                        : Container(),
                    controller.isFamily.value
                        ? Row(
                            children: [
                              Expanded(
                                  child: DefaultText('الرضع اقل من سنتين')),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: IconButton(
                                            onPressed: () {
                                              controller.incrementCountTravels(
                                                  id: 3);
                                            },
                                            icon: const Icon(Icons.add))),
                                    Expanded(
                                      child: Obx(() => Center(
                                            child: DefaultText(controller
                                                .countbaby.value
                                                .toString()),
                                          )),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () {
                                          controller.decrementCountTravels(
                                              id: 3);
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : Container()
                  ])),
              Center(
                  child: GFButton(
                      text: 'done',
                      onPressed: () async {
                        Get.back();

                        controller.endBootmSheetBookingServices(service);
                      }))
            ],
          ),
        ),
      ),
      backgroundColor: Get.theme.colorScheme.secondary);
}

class TripCard extends GetView<ServicesScreenController> {
  const TripCard({super.key, required this.trip, this.onlyShow = false});

  final Trips trip;
  final bool? onlyShow;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!onlyShow!) {
          await controller.endBootmSheetBookingTrip(trip);
          // bootomSheetBookingTrip(trip, controller);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Neumorphic(
            style: NeumorphicStyle(color: Get.theme.colorScheme.secondary),
            child: Stack(children: [
              Positioned(
                top: 0,
                child: ClipPath(
                  clipper: WaveClipperOne(flip: true),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    color: Get.theme.colorScheme.primary,
                  ),
                ),
              ),
              Positioned(
                  top: 60,
                  left: 10,
                  child: SizedBox(
                    width: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(LocaleKeys.trip_price.tr),
                        Text(trip.price!.toString()),
                        const Divider(),
                      ],
                    ),
                  )),
              Positioned(
                  top: 10,
                  right: 5,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Neumorphic(
                      padding: const EdgeInsets.all(5),
                      style: const NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.circle()),
                      child: Center(
                        child: NeumorphicText(
                          trip.company!.name!,
                          textStyle: NeumorphicTextStyle(fontSize: 12),
                          curve: Curves.linear,
                          style: const NeumorphicStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  )),
              Positioned(
                  top: 10,
                  child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Column(
                        children: [
                          trip.category!.idCategoryMain == 9 ||
                                  trip.category!.idCategoryMain == 12
                              ? DefaultIcon.svg(
                                  path: 'icons/plane1.svg',
                                  width: 30,
                                  height: 30,
                                  color: Get.theme.colorScheme.secondary,
                                )
                              : trip.category!.idCategoryMain == 10 ||
                                      trip.category!.idCategoryMain == 7
                                  ? DefaultIcon.svg(
                                      path: 'icons/bus.svg',
                                      width: 30,
                                      height: 30,
                                      color: Get.theme.colorScheme.secondary,
                                    )
                                  : DefaultIcon.svg(
                                      path: 'icons/boat.svg',
                                      width: 30,
                                      height: 30,
                                      color: Get.theme.colorScheme.secondary,
                                    ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(controller.category.value!.subCategory!
                                  .firstWhere((element) =>
                                      element.idCategoryMain ==
                                      trip.category!.idSubCategory)
                                  .nameCategoryMain!),
                              const SizedBox(
                                width: 3,
                              ),
                              const Text('&'),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(trip.category!.nameCategoryMain!)
                            ],
                          )
                        ],
                      )))),
              Positioned(
                  top: 80,
                  child: SizedBox(
                    height: 125,
                    width: MediaQuery.of(context).size.width,
                    child: Row(children: [
                      Expanded(
                        child: dataGoolandTime(),
                      ),
                      const VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      Expanded(child: dataLeft()),
                    ]),
                  ))
            ]),
          ),
        ),
      ),
    );
  }

  Widget dataGoolandTime() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.only(right: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(trip.fromCity!.name!),
              ClipPath(
                clipper: ArrowClipper(12, 9, Edge.LEFT),
                child: Container(
                    color: Get.theme.colorScheme.primary,
                    width: 100,
                    height: 20),
              ),
              Text(trip.toCity!.name!)
            ],
          ),
        ),
        const Divider(),
        Text(LocaleKeys.trip_dateAndTimeSeats.tr),
        Text(
            '${trip.dateGo!.day} - ${trip.dateGo!.month} - ${trip.dateGo!.year}'),
        const Divider(),
      ]),
    );
  }

  Widget dataLeft() {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          children: const [
            Text('عدد المقاعد المتاحة'),
            SizedBox(
              height: 1,
            ),
            Text('0'),
          ],
        ),
        const Divider(),
        Text(LocaleKeys.trip_dateAndTimeSeats.tr),
        const Text('0'),
        const Divider(),
      ]),
    );
  }
}

// ignore: must_be_immutable
class DefaultDropDownServices extends StatelessWidget {
  DefaultDropDownServices(
      {super.key,
      this.title,
      this.onSaved,
      required this.dataList,
      this.helpText,
      required this.onChanged,
      required this.value,
      this.colorTextShow = DefaultColor.textPrimary,
      this.height = 40,
      this.enableBorderColor = DefaultColor.primaryColor,
      this.focuseBorderColor = DefaultColor.sencondreColor,
      this.width = 100});
  String? title;
  Function(dynamic)? onSaved;
  List<dynamic>? dataList;
  String? helpText;
  Function(dynamic) onChanged;
  dynamic value;
  Color colorTextShow;
  double height = 40;
  Color enableBorderColor;
  Color focuseBorderColor;
  double width = 100;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (title == null)
              ? Container()
              : DefaultText(
                  title!,
                ),
          Center(
            child: DropdownButtonFormField<dynamic>(
                onSaved: onSaved,
                alignment: Alignment.topCenter,
                // ignore: prefer_const_constructors
                style: TextStyle(
                  height: 1,
                ),
                decoration: InputDecoration(
                    helperText: helpText,
                    contentPadding: const EdgeInsets.all(8.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(width: 1, color: enableBorderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(width: 1, color: focuseBorderColor))),
                value: value,
                items: dataList!
                    .map((e) => DropdownMenuItem<dynamic>(
                          value: e,
                          child: DefaultText(
                            e.value.nameArabic,
                          ),
                        ))
                    .toList(),
                onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}

Future bootomSheetBookingTrip(Trips trip, ServicesScreenController controller) {
  return Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TripCard(
                trip: trip,
                onlyShow: true,
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  const Text('نوع الحجز'),
                  Obx(() => itemIsFamilyWidget(controller))
                ],
              ),
              Obx(() => Column(children: [
                    Row(
                      children: [
                        Expanded(child: DefaultText('البالغين')),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        controller.incrementCountTravels(id: 1);
                                      },
                                      icon: const Icon(Icons.add))),
                              Expanded(
                                child: Obx(() => Center(
                                    child: DefaultText(controller
                                        .countAdult.value
                                        .toString()))),
                              ),
                              Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        controller.decrementCountTravels(id: 1);
                                      },
                                      icon: const Icon(Icons.remove))),
                            ],
                          ),
                        )
                      ],
                    ),
                    controller.groubeVauleIsFamily.value
                        ? Row(
                            children: [
                              Expanded(child: DefaultText('الأطفال اقل 12')),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: IconButton(
                                            onPressed: () {
                                              controller.incrementCountTravels(
                                                  id: 2);
                                            },
                                            icon: const Icon(Icons.add))),
                                    Expanded(
                                      child: Obx(() => Center(
                                            child: DefaultText(controller
                                                .countChildern.value
                                                .toString()),
                                          )),
                                    ),
                                    Expanded(
                                        child: IconButton(
                                            onPressed: () {
                                              controller.decrementCountTravels(
                                                  id: 2);
                                            },
                                            icon: const Icon(Icons.remove))),
                                  ],
                                ),
                              )
                            ],
                          )
                        : Container(),
                    controller.groubeVauleIsFamily.value
                        ? Row(
                            children: [
                              Expanded(
                                  child: DefaultText('الرضع اقل من سنتين')),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: IconButton(
                                            onPressed: () {
                                              controller.incrementCountTravels(
                                                  id: 3);
                                            },
                                            icon: const Icon(Icons.add))),
                                    Expanded(
                                      child: Obx(() => Center(
                                            child: DefaultText(controller
                                                .countbaby.value
                                                .toString()),
                                          )),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () {
                                          controller.decrementCountTravels(
                                              id: 3);
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : Container()
                  ])),
              Center(
                  child: GFButton(
                      text: 'done',
                      onPressed: () async {
                        Get.back();

                        controller.endBootmSheetBookingTrip(trip);
                      }))
            ],
          ),
        ),
      ),
      backgroundColor: Get.theme.colorScheme.secondary);
}

// Example 7
class DefaulteTabBr extends StatelessWidget {
  const DefaulteTabBr({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ContainedTabBarViewState> key = GlobalKey();
    ContainedTabBarView containedTabBarView = ContainedTabBarView(
      key: key,
      tabs: const [
        Text('First'),
        Text('Second'),
      ],
      views: [
        Container(color: Colors.red),
        Container(color: Colors.green),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Example 7'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => key.currentState?.previous(),
            child: const Icon(Icons.arrow_back_ios),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.blue,
              width: 200,
              height: 300,
              child: containedTabBarView,
            ),
          ),
          ElevatedButton(
            onPressed: () => key.currentState?.next(),
            child: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}

class TripCardUpdat extends GetView<ServicesScreenController> {
  const TripCardUpdat({super.key, required this.trip, this.onlyShow = false});

  final Trips trip;
  final bool? onlyShow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          if (!onlyShow!) {
            // await controller.endBootmSheetBookingTrip(trip);
            await controller.goToScreanBeneficiares(trip);
          }
        },
        child: DefaultCountainer(
          colorShadow: Get.theme.colorScheme.primary,
          height: 150,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    // SizedBox(
                    //     height: 50,
                    //     width: MediaQuery.of(context).size.width,
                    // child:
                    Center(
                        child: trip.category!.idCategoryMain == 9 ||
                                trip.category!.idCategoryMain == 12
                            ? DefaultIcon.svg(
                                path: 'icons/plane1.svg',
                                width: 30,
                                height: 30,
                                color: Get.theme.colorScheme.primary,
                              )
                            : trip.category!.idCategoryMain == 10 ||
                                    trip.category!.idCategoryMain == 7
                                ? DefaultIcon.svg(
                                    path: 'icons/bus.svg',
                                    width: 30,
                                    height: 30,
                                    color: Get.theme.colorScheme.primary,
                                  )
                                : DefaultIcon.svg(
                                    path: 'icons/boat.svg',
                                    width: 30,
                                    height: 30,
                                    color: Get.theme.colorScheme.primary,
                                  )),
                    const Spacer(),
                    DataWithLebal(
                        lebal: LocaleKeys.trip_method.tr,
                        data: controller.category.value!.subCategory!
                            .firstWhere((element) =>
                                element.idCategoryMain ==
                                trip.category!.idSubCategory)
                            .nameCategoryMain!),
                    const Spacer(),

                    DataWithLebal(
                        lebal: 'طريقة الرحلة',
                        data: trip.category!.nameCategoryMain!),
                    const Spacer(),

                    DataWithLebal(
                      lebal: LocaleKeys.trip_company.tr,
                      data: trip.company!.name!,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          DataWithoutLebal(data: trip.fromCity!.name),
                          Expanded(
                              child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Positioned(
                                  top: 33,
                                  child: DottedLine(
                                    lineLength: 150,
                                  )),
                              trip.category!.idCategoryMain == 9 ||
                                      trip.category!.idCategoryMain == 12
                                  ? Positioned(
                                      top: 0,
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: DefaultIcon.svg(
                                          path: 'icons/plane_run.svg',
                                          color: Get.theme.colorScheme.primary,

                                          // color: Get.theme.colorScheme.secondary,
                                        ),
                                      ),
                                    )
                                  : trip.category!.idCategoryMain == 10 ||
                                          trip.category!.idCategoryMain == 7
                                      ? Positioned(
                                          top: -2,
                                          child: Transform(
                                            alignment: Alignment.center,
                                            transform:
                                                Matrix4.rotationY(math.pi),
                                            child: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: DefaultIcon.svg(
                                                path: 'icons/busrun.svg',
                                                color: Get
                                                    .theme.colorScheme.primary,

                                                // color: Get.theme.colorScheme.secondary,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Positioned(
                                          top: -2,
                                          child: Transform(
                                            alignment: Alignment.center,
                                            transform:
                                                Matrix4.rotationY(math.pi),
                                            child: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: DefaultIcon.svg(
                                                path: 'icons/boat_run.svg',
                                                color: Get
                                                    .theme.colorScheme.primary,

                                                // color: Get.theme.colorScheme.secondary,
                                              ),
                                            ),
                                          ),
                                        )
                            ],
                          )),
                          DataWithoutLebal(data: trip.toCity!.name)
                        ],
                      ),
                    ),
                    Expanded(
                        child: DataWithLebal(
                            lebal: LocaleKeys.trip_dateAndTimeSeats.tr,
                            data: trip.getDateGo ?? 'no limited')),
                    Expanded(
                        child: DataWithLebal(
                            lebal: 'وقت الرحلة',
                            data: trip.timeLeave!.format(context))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DataWithoutLebal extends StatelessWidget {
  const DataWithoutLebal({
    super.key,
    required this.data,
  });

  final String? data;

  @override
  Widget build(BuildContext context) {
    return Text(data ?? '');
  }
}

class DataWithLebal extends StatelessWidget {
  const DataWithLebal({
    super.key,
    required this.lebal,
    required this.data,
  });
  final String lebal;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          lebal + DataConst.comme + data,
          style: Get.textTheme.headlineMedium,
        )
      ],
    );
  }
}

class ItemDrawer extends GetView<MainScreanController> {
  const ItemDrawer(
      {super.key,
      required this.path,
      required this.title,
      this.color,
      required this.reqAuth,
      this.onTap});
  final String path;
  final String title;
  final bool reqAuth;
  final Color? color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: reqAuth
          ? () {
              if (controller.currentUser != null) {
                onTap!();
              } else {}
            }
          : onTap,
      child: DefaultCountainer(
        child: ListTile(
          title: Text(
            title,
            style: Get.textTheme.headlineMedium,
          ),
          leading: DefaultIcon.svg(
            path: path,
            width: 30,
            height: 30,
            color: color,
          ),
        ),
      ),
    );
  }
}

class ItemTripRequest extends StatelessWidget {
  const ItemTripRequest({super.key, required this.userRequest});
  final UserRequest userRequest;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bottomSheetDetailRequestTrip(userRequest.requestTrip!);
      },
      child: DefaultCountainer(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: IconStateRequsteSelect(
            id: userRequest.state!.id!,
          ),
          title: Center(
              child: Text(
            userRequest.serviceName!,
            style: Get.textTheme.headlineMedium,
          )),
          subtitle: Column(
            children: [
              Text(
                'عدد الاشخاص'.toString() +
                    DataConst.comme +
                    userRequest.requestTrip!.infoBooking!.length.toString(),
                style: Get.textTheme.headlineSmall,
              ),
              Text(
                'وقت الحجز'.toString() +
                    DataConst.comme +
                    getDatetoString(userRequest.requestTrip!.bookingTime)!,
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
}

class ItemServiceRequest extends StatelessWidget {
  const ItemServiceRequest({super.key, required this.userRequest});
  final UserRequest userRequest;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bottomSheetDetailRequestServicePublic(
            userRequest.requestServicePublic!);
      },
      child: DefaultCountainer(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: IconStateRequsteSelect(
            id: userRequest.state!.id!,
          ),
          title: Center(
              child: Text(
            userRequest.serviceName!,
            style: Get.textTheme.headlineMedium,
          )),
          subtitle: Column(
            children: [
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
                    getDatetoString(userRequest
                        .requestServicePublic!.bookingServicesDate!)!,
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
}

Future bottomSheetDetailRequestTrip(RequestTrip requestTrip) async {
  return await Get.bottomSheet(DefaultCountainer(
    child: DefaultCountainer(
      padding: const EdgeInsets.all(8.0),
      height: Get.height / 2,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Text(
            'تفاصيل الطلب',
            style: Get.textTheme.headlineLarge,
          ),
        ),
        ExpansionTile(
          title: Text('تفاصيل الرحلة', style: Get.textTheme.headlineMedium),
          children: requestTrip.info!
              .map((e) => Column(
                    children: [
                      Text(
                          'اسم الشركة'.toString() +
                              DataConst.comme +
                              e.trip!.company!.name!,
                          style: Get.textTheme.headlineSmall),
                      Text(
                          LocaleKeys.trip_fromCity.tr +
                              DataConst.comme +
                              e.trip!.fromCity!.name! +
                              ' '.toString() +
                              LocaleKeys.trip_ToCity.tr +
                              ' '.toString() +
                              e.trip!.toCity!.name!,
                          style: Get.textTheme.headlineSmall),
                      Text(
                          'خطة الرحلة'.toString() +
                              DataConst.comme +
                              requestTrip.planTrip!.name!,
                          style: Get.textTheme.headlineSmall),
                      Text(
                          'وفت الرحلة'.toString() +
                              DataConst.comme +
                              getDatetoString(e.dateGo)!,
                          style: Get.textTheme.headlineSmall),
                      e.dataBack == null
                          ? Container()
                          : Text(
                              'وقت العودة'.toString() +
                                  DataConst.comme +
                                  getDatetoString(e.dataBack)!,
                              style: Get.textTheme.headlineSmall)
                    ],
                  ))
              .toList(),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: requestTrip.infoBooking!.length,
            itemBuilder: (context, index) {
              InfoBooking infoBooking = requestTrip.infoBooking![index];
              return ExpansionTile(
                title: Text(
                    'معلومات المسافر'.toString() +
                        DataConst.comme +
                        infoBooking.person.nameid!,
                    style: Get.textTheme.headlineMedium),
                children: [
                  Text(
                      LocaleKeys.personalData_gender.tr +
                          DataConst.comme +
                          infoBooking.person.getGender!,
                      style: Get.textTheme.headlineSmall),
                  Text(
                      'الحالة الاجتماعية'.toString() +
                          DataConst.comme +
                          infoBooking.person.getMartiall!,
                      style: Get.textTheme.headlineSmall),
                  Text(
                      'العمر'.toString() +
                          DataConst.comme +
                          getAge(infoBooking.person.datePirth!).toString(),
                      style: Get.textTheme.headlineSmall),
                  ExpansionTile(
                    title: Text('البينات المدخلة',
                        style: Get.textTheme.headlineMedium),
                    children: infoBooking.dataInputRequrment!.map((e) {
                      DataInputRequrment dataInputRequrment = e;
                      if (dataInputRequrment.idTypeFiled == 1) {
                        if (dataInputRequrment.mainRequire == null) {
                          return Text(
                              dataInputRequrment.subReqDetail!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.textValue!,
                              style: Get.textTheme.headlineSmall);
                        } else {
                          return Text(
                              dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.textValue!,
                              style: Get.textTheme.headlineSmall);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 2) {
                        if (dataInputRequrment.mainRequire == null) {
                          return Text(
                              dataInputRequrment.subReqDetail!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.urlFile!,
                              style: Get.textTheme.headlineSmall);
                        } else {
                          return Text(
                              dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.urlFile!,
                              style: Get.textTheme.headlineSmall);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 3) {
                        if (dataInputRequrment.mainRequire == null) {
                          return Text(
                              dataInputRequrment.subReqDetail!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.textValue!,
                              style: Get.textTheme.headlineSmall);
                        } else {
                          return Text(
                              dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.textValue!,
                              style: Get.textTheme.headlineSmall);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 4) {
                        if (dataInputRequrment.mainRequire == null) {
                          return Text(
                              dataInputRequrment.subReqDetail!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.textValue!,
                              style: Get.textTheme.headlineSmall);
                        } else {
                          return Text(
                              dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.textValue!,
                              style: Get.textTheme.headlineSmall);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 5) {
                        if (dataInputRequrment.mainRequire == null) {
                          return Text(
                              dataInputRequrment.subReqDetail!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.urlFile!,
                              style: Get.textTheme.headlineSmall);
                        } else {
                          return Text(
                              dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.urlFile!,
                              style: Get.textTheme.headlineSmall);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 8) {
                        if (dataInputRequrment.mainRequire == null) {
                          return Text(
                              dataInputRequrment.subReqDetail!.containt! +
                                  DataConst.comme +
                                  dataInputRequrment.subReqDetail!.choose!
                                      .firstWhere((element) =>
                                          element.idChooseSub ==
                                          dataInputRequrment.idChoice)
                                      .containt!,
                              style: Get.textTheme.headlineSmall);
                        } else {
                          return Text(
                              dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.mainRequire!.choose!
                                      .firstWhere((element) =>
                                          element.idChooseMain ==
                                          dataInputRequrment.idChoice)
                                      .containt!,
                              style: Get.textTheme.headlineSmall);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 9) {
                        if (dataInputRequrment.mainRequire == null) {
                          return Text(
                              dataInputRequrment.subReqDetail!.containt! +
                                  DataConst.comme +
                                  dataInputRequrment.subReqDetail!.choose!
                                      .firstWhere((element) =>
                                          element.idChooseSub ==
                                          dataInputRequrment.idChoice)
                                      .containt!,
                              style: Get.textTheme.headlineSmall);
                        } else {
                          return Text(
                              dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.mainRequire!.choose!
                                      .firstWhere((element) =>
                                          element.idChooseMain ==
                                          dataInputRequrment.idChoice)
                                      .containt!,
                              style: Get.textTheme.headlineSmall);
                        }
                      } else {
                        return Container();
                      }
                    }).toList(),
                  )
                ],
              );
            },
          ),
        )
      ]),
    ),
  ));
}

Future bottomSheetDetailRequestServicePublic(
    RequestServicePublic requestServicePublic) async {
  return await Get.bottomSheet(DefaultCountainer(
    child: DefaultCountainer(
      padding: const EdgeInsets.all(8.0),
      height: Get.height / 2,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Text(
            'تفاصيل الطلب',
            style: Get.textTheme.headlineLarge,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: requestServicePublic.infoBookingService!.length,
            itemBuilder: (context, index) {
              InfoBookingService infoBookingService =
                  requestServicePublic.infoBookingService![index];
              return ExpansionTile(
                title: Text(
                    'معلومات المسافر'.toString() +
                        DataConst.comme +
                        infoBookingService.person!.nameid!,
                    style: Get.textTheme.headlineMedium),
                children: [
                  Text(
                      LocaleKeys.personalData_gender.tr +
                          DataConst.comme +
                          infoBookingService.person!.getGender!,
                      style: Get.textTheme.headlineSmall),
                  Text(
                      'الحالة الاجتماعية'.toString() +
                          DataConst.comme +
                          infoBookingService.person!.getMartiall!,
                      style: Get.textTheme.headlineSmall),
                  Text(
                      'العمر'.toString() +
                          DataConst.comme +
                          getAge(infoBookingService.person!.datePirth!)
                              .toString(),
                      style: Get.textTheme.headlineSmall),
                  ExpansionTile(
                    title: Text('البينات المدخلة',
                        style: Get.textTheme.headlineMedium),
                    children: infoBookingService.dataInputRequrment!.map((e) {
                      DataInputRequrment dataInputRequrment = e;
                      if (dataInputRequrment.idTypeFiled == 1) {
                        if (dataInputRequrment.mainRequire == null) {
                          return Text(
                              dataInputRequrment.subReqDetail!.containt! +
                                  DataConst.comme +
                                  dataInputRequrment.textValue!,
                              style: Get.textTheme.headlineSmall);
                        } else {
                          return Text(
                              dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.textValue!,
                              style: Get.textTheme.headlineSmall);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 2) {
                        if (dataInputRequrment.mainRequire == null) {
                          return Text(
                              dataInputRequrment.subReqDetail!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.urlFile!,
                              style: Get.textTheme.headlineSmall);
                        } else {
                          return Text(
                              dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.urlFile!,
                              style: Get.textTheme.headlineSmall);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 3) {
                        if (dataInputRequrment.mainRequire == null) {
                          return Text(
                              dataInputRequrment.subReqDetail!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.textValue!,
                              style: Get.textTheme.headlineSmall);
                        } else {
                          return Text(
                              dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.textValue!,
                              style: Get.textTheme.headlineSmall);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 4) {
                        if (dataInputRequrment.mainRequire == null) {
                          return Text(
                              dataInputRequrment.subReqDetail!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.textValue!,
                              style: Get.textTheme.headlineSmall);
                        } else {
                          return Text(
                              dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.textValue!,
                              style: Get.textTheme.headlineSmall);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 5) {
                        if (dataInputRequrment.mainRequire == null) {
                          return Text(
                              dataInputRequrment.subReqDetail!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.urlFile!,
                              style: Get.textTheme.headlineSmall);
                        } else {
                          return Text(
                              dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.urlFile!,
                              style: Get.textTheme.headlineSmall);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 8) {
                        if (dataInputRequrment.mainRequire == null) {
                          return Text(
                              dataInputRequrment.subReqDetail!.containt! +
                                  DataConst.comme +
                                  dataInputRequrment.subReqDetail!.choose!
                                      .firstWhere((element) =>
                                          element.idChooseSub ==
                                          dataInputRequrment.idChoice)
                                      .containt!,
                              style: Get.textTheme.headlineSmall);
                        } else {
                          return Text(
                              dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.mainRequire!.choose!
                                      .firstWhere((element) =>
                                          element.idChooseMain ==
                                          dataInputRequrment.idChoice)
                                      .containt!,
                              style: Get.textTheme.headlineSmall);
                        }
                      } else if (dataInputRequrment.idTypeFiled == 9) {
                        if (dataInputRequrment.mainRequire == null) {
                          return Text(
                              dataInputRequrment.subReqDetail!.containt! +
                                  DataConst.comme +
                                  dataInputRequrment.subReqDetail!.choose!
                                      .firstWhere((element) =>
                                          element.idChooseSub ==
                                          dataInputRequrment.idChoice)
                                      .containt!,
                              style: Get.textTheme.headlineSmall);
                        } else {
                          return Text(
                              dataInputRequrment.mainRequire!.name! +
                                  DataConst.comme +
                                  dataInputRequrment.mainRequire!.choose!
                                      .firstWhere((element) =>
                                          element.idChooseMain ==
                                          dataInputRequrment.idChoice)
                                      .containt!,
                              style: Get.textTheme.headlineSmall);
                        }
                      } else {
                        return Container();
                      }
                    }).toList(),
                  )
                ],
              );
            },
          ),
        )
      ]),
    ),
  ));
}

class IconStateRequsteSelect extends StatelessWidget {
  const IconStateRequsteSelect({
    super.key,
    required this.id,
    this.size,
  });

  final int id;
  final double? size;

  @override
  Widget build(BuildContext context) {
    if (id == 1) {
      return DefaultIcon.svg(
        path: 'icons/wait.svg',
        width: size ?? 30,
        height: size ?? 30,
      );
    } else if (id == 2) {
      return DefaultIcon.svg(
        path: 'icons/progress.svg',
        width: size ?? 30,
        height: size ?? 30,
        color: Get.theme.colorScheme.primary,
      );
    } else if (id == 3) {
      return DefaultIcon.svg(
        path: 'icons/reject.svg',
        width: size ?? 30,
        height: size ?? 30,
      );
    } else if (id == 4) {
      return DefaultIcon.svg(
        path: 'icons/complete.svg',
        width: size ?? 30,
        height: size ?? 30,
      );
    } else {
      return DefaultIcon.svg(
        path: 'icons/about.svg',
        width: size ?? 30,
        height: size ?? 30,
      );
    }
  }
}

defaultBottomSheet({required String titleBottom, required List<Service> item}) {
  return Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Center(child: DefaultText(titleBottom)),
            Expanded(
              child: ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  Service servie = item[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.sunny,
                    ),
                    title: DefaultText(servie.name!),
                    //subtitle: DefaultText(ite),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                defaultButton(
                    onPressed: () {
                      Get.back();
                    },
                    isResponseve: false,
                    isIcon: false,
                    lable: 'تم',
                    width: 150)
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.white);
}

defaultShowDialog({
  required String title,
  required List<CategorySecondry?> itmes,
}) {
  HomeController controller = Get.put(HomeController());
  UiApp.defaultDeialog(
    title: title,
    content: Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: itmes
                .map((e) => Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        child: defaultButton(
                            onPressed: () {
                              controller.tempSevices = controller.tempSevices!
                                  .where((element) => element.category == null)
                                  .toList();

                              Get.back();
                              Get.toNamed(Routes.SERVICES_SCREEN);
                            },
                            isResponseve: false,
                            isIcon: false,
                            lable: e!.name!),
                      ),
                    ))
                .toList(),
          ),
        ),
        const Spacer()
      ],
    ),
  );
}

class SubTitleLabel extends StatelessWidget {
  const SubTitleLabel({
    Key? key,
    required this.lableSubTitle,
    required this.iconData,
  }) : super(key: key);

  final String lableSubTitle;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DefaultText(
          lableSubTitle,
          style: Get.textTheme.headlineLarge,
        ),
        IconButton(
            padding: const EdgeInsets.all(1),
            onPressed: () {},
            icon: Icon(
              iconData,
              size: OptionThemeWidget.labalMainTextSize,
            ))
      ],
    );
  }
}

class DefaultCircalProgress extends StatelessWidget {
  const DefaultCircalProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
        color: Get.theme.colorScheme.primary,
        size: 100,
      ),
    );
  }
}
