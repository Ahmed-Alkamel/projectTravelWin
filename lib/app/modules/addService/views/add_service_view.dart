import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:projecttravelwin/app/modules/widgets/main_widget.dart';
import 'package:projecttravelwin/app/theme/color.dart';

import '../../../Helper/validation.dart';
import '../../../models/basic/category.dart';
import '../../../models/basic/currencies.dart';
import '../../../models/basic/identitfy_card.dart';
import '../../../models/basic/main_requiremnt.dart';
import '../../../models/basic/sub_requiremnt.dart';
import '../../../models/basic/type_filed.dart';
import '../../widgets/default_widget.dart';
import '../controllers/add_service_controller.dart';

class AddServiceView extends GetView<AddServiceController> {
  const AddServiceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'اضافة خدمة',
            style: Get.textTheme.titleLarge,
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Get.theme.colorScheme.secondary),
        ),
        body: Obx(() => controller.isLoading.value
            ? const DefaultCircalProgress()
            : Center(
                child: DefaultCountainer(
                  padding: const EdgeInsets.only(
                      top: 15, left: 10, right: 10, bottom: 10),
                  width: Get.size.width * 0.9,
                  height: Get.height * 0.9,
                  borderRadius: 25,
                  child: Form(
                    key: controller.keyPublicForm,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        BorderCoverWidget(
                          label: 'اسم الخدمة',
                          child: DefaultTextFormField(
                            isborderall: true,
                            hintText: 'ادخل اسم الخدمة',
                            validator: (p0) => ValidatorApp.getVaidator(
                                ValidateType.required, p0),
                            onchange: (value) async {
                              controller.newService.name = value;
                            },
                          ),
                        ),
                        BorderCoverWidget(
                          child: FilePickerApp(
                              main: 'ايقونة الخدمة( اختياري)',
                              onTap: () async {
                                await controller.filePiicker();
                                controller.newService.pathImage =
                                    controller.fileCurrent == null
                                        ? null
                                        : base64Encode((await File(
                                                controller.fileCurrent!.path)
                                            .readAsBytes()));
                              }),
                        ),
                        BorderCoverWidget(
                          label: 'تصنيف الخدمة',
                          child: Row(
                            children: [
                              // const Spacer(),
                              Expanded(
                                flex: 3,
                                child: DefaultDropDownForm(
                                    dataList: controller.categroy,
                                    onChanged: (value) {
                                      Category category = value;

                                      if (category.subCategory!.isNotEmpty) {
                                        controller.adjest(
                                            1, category.subCategory!);
                                      } else {
                                        controller.newService.category = value;
                                        controller.islevel2.value = [];
                                        controller.islevel3.value = [];
                                      }
                                      controller.updataServicesDetails();
                                    },
                                    value: controller.categroy.first),
                              ),
                              const Spacer(),
                              Expanded(
                                flex: 3,
                                child: Obx(() => controller.islevel2.isEmpty
                                    ? Container()
                                    : DefaultDropDownForm(
                                        dataList: controller.islevel2,
                                        onChanged: (value) {
                                          Category category = value;
                                          // controller.newService.category = value;

                                          if (category
                                              .subCategory!.isNotEmpty) {
                                            controller.adjest(
                                                2, category.subCategory!);
                                          } else {
                                            controller.islevel3.value = [];
                                          }
                                        },
                                        value: controller.islevel2.first)),
                              ),
                              const Spacer(),
                              Expanded(
                                flex: 3,
                                child: Obx(() => controller.islevel3.isEmpty
                                    ? Container()
                                    : DefaultDropDownForm(
                                        dataList: controller.islevel3,
                                        label:
                                            const Text('اختيار التصنيف اجباري'),
                                        onChanged: (value) {
                                          Category category = value;
                                          if (category
                                              .subCategory!.isNotEmpty) {
                                            // controller.adjest(
                                            //     3, category.subCategory!);
                                          } else {
                                            controller.newService.category =
                                                value;
                                          }
                                        },
                                        value: controller.islevel3.first)),
                              ),
                              // const Spacer(),
                            ],
                          ),
                        ),
                        GetBuilder<AddServiceController>(
                          // init: MyController(),
                          id: 'ServicesDetails',
                          initState: (_) {},
                          builder: (_) {
                            return controller.checkIsTripCategry
                                ? Container()
                                : BorderCoverWidget(
                                    label: 'السعر',
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: DefaultTextFormField(
                                            validator: (p0) =>
                                                ValidatorApp.getVaidator(
                                                    ValidateType.required, p0),
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  // RegExp(r'^[0-9]d{3}$'

                                                  RegExp(r'^\d+\.?\d{0,2}')),
                                            ],
                                            isborderall: true,
                                            label: 'السعر',
                                            onchange: (value) {
                                              if (value.isNotEmpty) {
                                                controller
                                                        .newService
                                                        .serviceDetails!
                                                        .priceService =
                                                    double.parse(value);
                                              }
                                            },
                                          ),
                                        ),
                                        const Spacer(),
                                        Expanded(
                                          flex: 3,
                                          child: DefaultDropDownForm(
                                              label: const Text(
                                                'نوع العملة',
                                                // style: Get.textTheme.headlineSmall,
                                              ),
                                              dataList: controller
                                                  .dataBasic!.currencies,
                                              validator: (p0) =>
                                                  ValidatorApp.getVaidator(
                                                      ValidateType.required,
                                                      p0 is Currencies
                                                          ? p0.name
                                                          : p0),
                                              onChanged: (value) {
                                                if (value is Currencies) {
                                                  controller
                                                      .newService
                                                      .serviceDetails!
                                                      .currencie = value;
                                                }
                                              },
                                              value: controller.newService
                                                  .serviceDetails!.currencie),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        ),
                        BorderCoverWidget(
                          label: 'تلميحات',
                          child: GetBuilder<AddServiceController>(
                            id: 'hintView',
                            initState: (_) {},
                            builder: (_) {
                              return Column(
                                children: [
                                  controller.hintHot.isEmpty
                                      ? Center(
                                          child: Text(
                                            'لا توجد تلميحات',
                                            style: Get.textTheme.headlineSmall,
                                          ),
                                        )
                                      : Column(
                                          children: controller.hintHot
                                              .asMap()
                                              .entries
                                              .map((e) => Row(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            controller.hintHot
                                                                .removeAt(
                                                                    e.key);
                                                            controller
                                                                .updatehintView();
                                                          },
                                                          icon: Icon(
                                                              Icons.close,
                                                              color: Get
                                                                  .theme
                                                                  .colorScheme
                                                                  .primary)),
                                                      Text(
                                                        (1 + e.key).toString() +
                                                            '- '.toString() +
                                                            e.value.name!,
                                                        style: Get.textTheme
                                                            .headlineSmall,
                                                      ),
                                                    ],
                                                  ))
                                              .toList(),
                                        ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (controller
                                              .controllerHint.text.isNotEmpty) {
                                            controller.hintHot.add(
                                                MainRequirment(
                                                    name: controller
                                                        .controllerHint.text,
                                                    typeFiled:
                                                        TypeFiled(id: 10)));
                                            controller.controllerHint.clear();
                                            controller.updatehintView();
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            Icon(Icons.add,
                                                color: Get
                                                    .theme.colorScheme.primary),
                                            Text(
                                              'اضافة',
                                              style:
                                                  Get.textTheme.headlineSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                      DefaultTextFormField(
                                        controller: controller.controllerHint,
                                        width: Get.width * 0.6,
                                        isborderall: false,
                                        hintText: 'ادخل محتوى التلميح',
                                        // onchange: (p0) {

                                        // },
                                      )
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                        BorderCoverWidget(
                            label: 'بطاقة الهوية المسموحة',
                            child: GetBuilder<AddServiceController>(
                              id: 'selectIdentityCard',
                              // init: AddServiceController(),
                              // initState: (_) {},
                              builder: (_) {
                                return DefaultCheckBox(
                                  data: controller.dataBasic!.identities,
                                  onChangedCustom: (value, index) {
                                    if (value == true) {
                                      controller.newService.identitfyRequerment!
                                          .add(controller
                                              .dataBasic!.identities[index]);
                                    } else if (value == false) {
                                      controller.newService.identitfyRequerment!
                                          .removeAt(controller
                                              .dataBasic!.identities
                                              .indexWhere((element) =>
                                                  element ==
                                                  controller.dataBasic!
                                                      .identities[index]));
                                    }
                                    controller.updateSelectIdentey();
                                  },
                                );
                              },
                            )),
                        GetBuilder<AddServiceController>(
                          id: 'MainRequerment',
                          initState: (_) {},
                          builder: (_) {
                            GlobalKey<FormState> keyFormMainRequerment =
                                GlobalKey<FormState>();

                            return BorderCoverWidget(
                                label: 'المتطلبات الاساسية',
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      if (controller.newService.mainRequirment!
                                          .isNotEmpty)
                                        Column(
                                            children:
                                                controller
                                                    .newService.mainRequirment!
                                                    .asMap()
                                                    .entries
                                                    .map((e) => Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    DefaultTextFormField(
                                                                  initialValue:
                                                                      e.value
                                                                          .name,
                                                                  isborderall:
                                                                      true,
                                                                  label:
                                                                      'اسم المتطلب',
                                                                  hintText:
                                                                      'ادخل اسم المتطلب',
                                                                  onchange:
                                                                      (value) {
                                                                    e.value.name =
                                                                        value;
                                                                    controller
                                                                        .updateDropDowntypeMain();
                                                                  },
                                                                ),
                                                              ),
                                                              const Spacer(),
                                                              Expanded(
                                                                flex: 2,
                                                                child: GetBuilder<
                                                                    AddServiceController>(
                                                                  id: 'DropDowntypeMain',
                                                                  // init: AddServiceController(),
                                                                  initState:
                                                                      (_) {},
                                                                  builder: (_) {
                                                                    return e.value.name ==
                                                                                null ||
                                                                            e.value.name!
                                                                                .isEmpty
                                                                        ? Container()
                                                                        : DefaultDropDownForm(
                                                                            validator: (p0) =>
                                                                                ValidatorApp.getVaidator(ValidateType.required, p0 is TypeFiled ? p0.name : null),
                                                                            label: Text(
                                                                              'قم بختيار نوع المتطلب',
                                                                              style: Get.textTheme.headlineSmall,
                                                                            ),
                                                                            dataList: controller.dataBasic?.typeFiled,
                                                                            onChanged: (value) async {
                                                                              if (controller.keyPublicForm.currentState!.validate()) {
                                                                                e.value.typeFiled = value;
                                                                                if (e.value.typeFiled!.id == 8 || e.value.typeFiled!.id == 9) {
                                                                                  GlobalKey<FormState> keyAddChoiceMain = GlobalKey<FormState>();
                                                                                  await Get.defaultDialog(
                                                                                      confirm: defaultButton(
                                                                                          isResponseve: true,
                                                                                          isIcon: false,
                                                                                          lable: 'تم',
                                                                                          onPressed: () {
                                                                                            Get.back();
                                                                                          }),
                                                                                      title: "اضافة خيار للمتطلب",
                                                                                      content: GetBuilder<AddServiceController>(
                                                                                        id: 'AddChoice',
                                                                                        // init:
                                                                                        //     AddServiceController(),
                                                                                        initState: (_) {},
                                                                                        builder: (_) {
                                                                                          return SizedBox(
                                                                                            width: Get.width / 2,
                                                                                            height: Get.height / 2,
                                                                                            child: Column(
                                                                                              children: [
                                                                                                SingleChildScrollView(
                                                                                                    child: Column(
                                                                                                  children: e.value.choose
                                                                                                          ?.asMap()
                                                                                                          .entries
                                                                                                          .map(
                                                                                                            (edialog) => Container(
                                                                                                              margin: const EdgeInsets.all(8.0),
                                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                                              child: Row(
                                                                                                                children: [
                                                                                                                  Expanded(
                                                                                                                    child: DefaultTextFormField(
                                                                                                                      label: '  الخيار رقم '.toString() + (edialog.key + 1).toString(),
                                                                                                                      isborderall: true,
                                                                                                                      onchange: (p0) {
                                                                                                                        edialog.value.containt = p0;
                                                                                                                      },
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  IconButton(
                                                                                                                      onPressed: () {
                                                                                                                        e.value.choose?.removeAt(edialog.key);
                                                                                                                        controller.updateAddChoice();
                                                                                                                      },
                                                                                                                      icon: const Icon(Icons.close))
                                                                                                                ],
                                                                                                              ),
                                                                                                            ),
                                                                                                          )
                                                                                                          .toList() ??
                                                                                                      [],
                                                                                                )),
                                                                                                GestureDetector(
                                                                                                  onTap: () {
                                                                                                    e.value.choose!.add(Choose());
                                                                                                    controller.updateAddChoice();
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
                                                                                          );
                                                                                        },
                                                                                      ));
                                                                                }

                                                                                controller.updateMainRequerment();
                                                                              }
                                                                            },
                                                                            value: e.value.typeFiled);
                                                                  },
                                                                ),
                                                              ),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    controller
                                                                        .newService
                                                                        .mainRequirment!
                                                                        .removeAt(
                                                                            e.key);
                                                                    controller
                                                                        .updateMainRequerment();
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .close))
                                                            ],
                                                          ),
                                                        ))
                                                    .toList()),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                if (controller
                                                    .keyPublicForm.currentState!
                                                    .validate()) {
                                                  controller.newService
                                                      .mainRequirment!
                                                      .add(MainRequirment());
                                                  controller
                                                      .updateMainRequerment();
                                                }
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                color: Get
                                                    .theme.colorScheme.primary,
                                              )),
                                          Center(
                                            child: Text(
                                              'اضافة متطلب رئيسي',
                                              style:
                                                  Get.textTheme.headlineSmall,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                          },
                        ),
                        BorderCoverWidget(
                            label: 'متطلب مخصص',
                            child: GetBuilder<AddServiceController>(
                              id: 'SubRequrment',
                              // init: AddServiceController(),
                              initState: (_) {},
                              builder: (_) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Column(
                                        children:
                                            controller
                                                .newService.subRequiremnts!
                                                .asMap()
                                                .entries
                                                .map((e) => Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  BorderCoverWidget(
                                                                      label:
                                                                          'الجنس',
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          controller
                                                                              .dataBasic!
                                                                              .gender
                                                                              .singleWhere((element) => element.idGender == e.value.gender)
                                                                              .nameAr!,
                                                                          style: Get
                                                                              .textTheme
                                                                              .headlineSmall,
                                                                        ),
                                                                      )),
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  BorderCoverWidget(
                                                                      label:
                                                                          'الحالة الاجتماعية',
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          controller
                                                                              .dataBasic!
                                                                              .martialStatus
                                                                              .singleWhere((element) => element.idMartial == e.value.idMartial)
                                                                              .nameAr!,
                                                                          style: Get
                                                                              .textTheme
                                                                              .headlineSmall,
                                                                        ),
                                                                      )),
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Expanded(
                                                                child:
                                                                    BorderCoverWidget(
                                                              label:
                                                                  'الفترة العمرية',
                                                              child: Center(
                                                                child: Text(
                                                                    ' من '.toString() +
                                                                        e.value
                                                                            .moreThanAge
                                                                            .toString() +
                                                                        ' الى  '
                                                                            .toString() +
                                                                        e.value
                                                                            .lessThanAge
                                                                            .toString(),
                                                                    style: Get
                                                                        .textTheme
                                                                        .headlineSmall),
                                                              ),
                                                            )),
                                                            Flexible(
                                                                child:
                                                                    Container()),
                                                            if (controller
                                                                        .newService
                                                                        .subRequiremnts !=
                                                                    null ||
                                                                controller
                                                                    .newService
                                                                    .subRequiremnts!
                                                                    .isNotEmpty)
                                                              Expanded(
                                                                  child: IconButton(
                                                                      onPressed: () {
                                                                        controller
                                                                            .newService
                                                                            .subRequiremnts!
                                                                            .removeAt(e.key);
                                                                        controller
                                                                            .updateSubRequerment();
                                                                      },
                                                                      icon: Icon(Icons.close)))
                                                          ],
                                                        ),
                                                      ],
                                                    ))
                                                .toList(),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                SubRequiremnt? sub =
                                                    await addSubRequermentDialog(
                                                        controller.dataBasic!,
                                                        controller);
                                                if (sub != null) {
                                                  controller.newService
                                                      .subRequiremnts!
                                                      .add(sub);
                                                }

                                                controller
                                                    .updateSubRequerment();
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                color: Get
                                                    .theme.colorScheme.primary,
                                              )),
                                          Center(
                                            child: Text(
                                              'اضافة متطلب مخصص',
                                              style:
                                                  Get.textTheme.headlineSmall,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            )),
                        Container(
                          margin: const EdgeInsets.all(6.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: defaultButton(
                                    isResponseve: true,
                                    isIcon: false,
                                    lable: 'حفظ',
                                    // icon: const Icon(
                                    //   Icons.save,
                                    //   color: DefaultColor.doneColocr,
                                    // ),
                                    onPressed: () async {
                                      if (controller.keyPublicForm.currentState!
                                          .validate()) {
                                        await controller.addService();
                                      }
                                    }),
                              ),
                              const Spacer(),
                              Expanded(
                                  child: defaultButton(
                                      isResponseve: true,
                                      isIcon: false,
                                      lable: 'خروج',
                                      icon: const Icon(
                                        Icons.close,
                                        color: DefaultColor.canselColor,
                                      ),
                                      onPressed: () {
                                        controller.test();
                                      }))
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              )));
  }
}

class DefaultCheckBox extends StatelessWidget {
  const DefaultCheckBox({
    super.key,
    required this.data,
    required this.onChangedCustom,
  });

  final List<dynamic> data;
  final void Function(bool?, int) onChangedCustom;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: data is List<IdentitfyCard>
          ? data
              .asMap()
              .entries
              .map((e) => Row(
                    children: [
                      Obx(() => Checkbox(
                          value: e is MapEntry<int, IdentitfyCard>
                              ? e.value.isSelected.value
                              : false,
                          onChanged: (value) {
                            if (e is MapEntry<int, IdentitfyCard>) {
                              e.value.isSelected.value = value ?? false;
                            }
                            onChangedCustom(value, e.key);
                          })),
                      Text(
                        e is MapEntry<int, IdentitfyCard>
                            ? e.value.name!
                            : "".toString(),
                        style: Get.textTheme.headlineSmall,
                      )
                    ],
                  ))
              .toList()
          : [],
    );
  }
}
