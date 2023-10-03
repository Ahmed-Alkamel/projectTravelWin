import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:projecttravelwin/app/Helper/validation.dart';

import '../../../data/local/local_data.dart';
import '../../../models/basic/proccess_app.dart';
import '../../widgets/default_widget.dart';
import '../../widgets/main_widget.dart';
import '../../widgets/main_widget_desktop.dart';
import '../controllers/management_user_desktop_controller.dart';

class AddUserView extends GetView<ManagementUserDesktopController> {
  const AddUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleAppBarDesktop(title: 'اضافة مستخدم'),
        iconTheme: IconThemeData(color: Get.theme.colorScheme.secondary),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value
          ? const DefaultCircalProgress()
          : Container(
              padding:
                  const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
              height: Get.height,
              width: Get.width,
              child: Form(
                key: controller.keyForm,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(8.0),
                      child: defaultButton(
                          isResponseve: false,
                          isIcon: false,
                          lable: 'حفظ ',
                          onPressed: () async {
                            if (controller.keyForm.currentState!.validate()) {
                              await controller.saveEmploy();
                            }
                          }),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: DefaultCountainer(
                            height: Get.height * 0.8,
                            // width: Get.width * 0.7,
                            borderRadius: 25,
                            padding: const EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  BorderCoverWidget(
                                    label: 'الاسم',
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      width: Get.width * 0.6,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: DefaultTextFormField(
                                              initialValue: controller
                                                  .newEmply!.name!.frisName,
                                              label: 'الاسم الاول',
                                              isborderall: true,
                                              hintText: ' ادخل الاسم الاول',
                                              validator: (p0) =>
                                                  ValidatorApp.getVaidator(
                                                      ValidateType.required,
                                                      p0),
                                              onchange: (value) {
                                                controller.newEmply!.name!
                                                    .frisName = value;
                                              },
                                            ),
                                          ),
                                          const Spacer(),
                                          Expanded(
                                            flex: 3,
                                            child: DefaultTextFormField(
                                              initialValue: controller
                                                  .newEmply!.name!.lastName,
                                              label: 'الاسم الثاني',
                                              isborderall: true,
                                              hintText: ' ادخل الاسم الثاني',
                                              validator: (p0) =>
                                                  ValidatorApp.getVaidator(
                                                      ValidateType.required,
                                                      p0),
                                              onchange: (value) {
                                                controller.newEmply!.name!
                                                    .lastName = value;
                                              },
                                            ),
                                          ),
                                          const Spacer(),
                                          Expanded(
                                            flex: 3,
                                            child: DefaultTextFormField(
                                              initialValue: controller
                                                  .newEmply!.name!.surName,
                                              label: "اللقب",
                                              isborderall: true,
                                              hintText: "ادخل اللقب",
                                              validator: (p0) =>
                                                  ValidatorApp.getVaidator(
                                                      ValidateType.required,
                                                      p0),
                                              onchange: (value) {
                                                controller.newEmply!.name!
                                                    .surName = value;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  BorderCoverWidget(
                                    label: "العنوان",
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      width: Get.width * 0.6,
                                      child: DefaultTextFormField(
                                        initialValue:
                                            controller.newEmply!.address,
                                        isborderall: true,
                                        hintText: "ادخل العنوان",
                                        validator: (p0) =>
                                            ValidatorApp.getVaidator(
                                                ValidateType.required, p0),
                                        onchange: (value) {
                                          controller.newEmply!.address = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  BorderCoverWidget(
                                    label: 'الراتب',
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      width: Get.width * 0.6,
                                      child: DefaultTextFormField(
                                        initialValue:
                                            controller.newEmply!.salary == null
                                                ? '0'
                                                : controller.newEmply!.salary!
                                                    .toString(),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              UntilHelper.onlynumberReq)
                                        ],
                                        isborderall: true,
                                        hintText: "ادخل الراتب",
                                        validator: (p0) =>
                                            ValidatorApp.getVaidator(
                                                ValidateType.required, p0),
                                        onchange: (value) {
                                          if (value.isNotEmpty) {
                                            controller.newEmply!.salary =
                                                double.parse(value);
                                          } else {
                                            controller.newEmply!.salary = 0;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  BorderCoverWidget(
                                    label: 'رقم التواصل',
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      width: Get.width * 0.6,
                                      child: DefaultTextFormField(
                                        initialValue:
                                            controller.newEmply!.numberPhone,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              UntilHelper.onlynumberReq)
                                        ],
                                        isborderall: true,
                                        hintText: "ادخل رقم التواصل",
                                        validator: (p0) =>
                                            ValidatorApp.getVaidator(
                                                ValidateType.required, p0),
                                        onchange: (value) {
                                          controller.newEmply!.numberPhone =
                                              value;
                                        },
                                      ),
                                    ),
                                  ),
                                  BorderCoverWidget(
                                    label: 'كلمة السر',
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      width: Get.width * 0.6,
                                      child: DefaultTextFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              UntilHelper.onlynumberReq)
                                        ],
                                        hidpass: true,
                                        isborderall: true,
                                        hintText: 'ادخل كلمة السر',
                                        validator: (p0) =>
                                            ValidatorApp.getVaidator(
                                                ValidateType.passord, p0),
                                        onchange: (value) {
                                          controller.newEmply!.password = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  BorderCoverWidget(
                                    label: 'تاكيد كلمة السر',
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      width: Get.width * 0.6,
                                      child: DefaultTextFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              UntilHelper.onlynumberReq)
                                        ],
                                        hidpass: true,
                                        isborderall: true,
                                        hintText: "ادخل تاكيد كلمة السر",
                                        validator: (p0) =>
                                            ValidatorApp.getVaidator(
                                                ValidateType.passwordConfigre,
                                                p0,
                                                confirm: controller
                                                    .newEmply!.password),
                                        onchange: (value) {
                                          controller.newEmply!.password = value;
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: DefaultCountainer(
                              // color: Colors.amber,
                              height: Get.height * 0.8,
                              // width: Get.width * 0.27,
                              borderRadius: 25,
                              padding: const EdgeInsets.all(10),
                              child: ListView.separated(
                                  controller: controller.controllerScroll,
                                  itemBuilder: (context, index) {
                                    return PermissionView(
                                      item: controller
                                          .newEmply!.permisstion![index],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    if (controller.data.length - 1 == index) {
                                      return Container();
                                    } else {
                                      return Divider(
                                          color: Get.theme.colorScheme.primary);
                                    }
                                  },
                                  itemCount: controller
                                      .newEmply!.permisstion!.length)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )),
    );
  }
}

class PermissionView extends GetView<ManagementUserDesktopController> {
  const PermissionView({
    required this.item,
    super.key,
  });
  final ProcessApp item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              item.name!,
              style: Get.textTheme.headlineMedium,
            ),
          ),
          Expanded(
              flex: 3,
              child: Column(
                  children: item.permission!
                      .asMap()
                      .entries
                      .map((e) => Row(
                            children: [
                              const Spacer(),
                              Expanded(
                                child: Text(
                                  e.value.name!,
                                  style: Get.textTheme.headlineSmall,
                                ),
                              ),
                              const Spacer(),
                              GetBuilder<ManagementUserDesktopController>(
                                // init: MyController(),
                                id: 'permistion'.toString() + e.key.toString(),
                                initState: (_) {},
                                builder: (_) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Checkbox(
                                          value: e.value.allow ?? false,
                                          onChanged: (value) {
                                            if (value == null) {
                                              e.value.allow = false;
                                              e.value.deny = true;
                                            } else if (value) {
                                              e.value.allow = true;
                                              e.value.deny = false;
                                            } else {
                                              e.value.allow = false;
                                              e.value.deny = true;
                                            }

                                            controller.updatePermisstion(
                                                'permistion'.toString() +
                                                    e.key.toString());
                                          }),
                                      Text(
                                        'سماح',
                                        style: Get.textTheme.headlineSmall,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Checkbox(
                                          value: e.value.deny ?? true,
                                          onChanged: (value) {
                                            if (value == null) {
                                              e.value.deny = false;
                                              e.value.allow = true;
                                            } else if (value) {
                                              e.value.deny = true;
                                              e.value.allow = false;
                                            } else {
                                              e.value.deny = false;
                                              e.value.allow = true;
                                            }

                                            controller.updatePermisstion(
                                                'permistion'.toString() +
                                                    e.key.toString());
                                          }),
                                      Text(
                                        'منع',
                                        style: Get.textTheme.headlineSmall,
                                      ),
                                    ],
                                  );
                                },
                              )
                            ],
                          ))
                      .toList()))
        ],
      ),
    );
  }
}
