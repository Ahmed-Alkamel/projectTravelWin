import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Helper/validation.dart';

import '../../../translations/locale.dart';
import '../../widgets/default_widget.dart';
import '../controllers/auth_controller.dart';
import 'auth_view.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => controller.isloading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                layoutPage(),
                Align(
                  alignment: Alignment.center,
                  child: DefaultCountainer(
                    borderRadius: 25,
                    width: Get.width / 3 * 2,
                    height: Get.height / 2,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.buttons_login.tr,
                          style: Get.textTheme.titleLarge!.merge(
                              TextStyle(color: Get.theme.colorScheme.primary)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Form(
                            key: controller.keyForm,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  DefaultTextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    isborderall: true,
                                    onchange: (p0) {
                                      controller.ident = p0;
                                    },
                                    hintText: 'ادخل رقم الجوال',
                                    validator: (p0) {
                                      return ValidatorApp.getVaidator(
                                          ValidateType.required, p0);
                                    },
                                    label: "رقم الجوال",
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  DefaultTextFormField(
                                    isborderall: true,
                                    hintText:
                                        LocaleKeys.authScrean_pasword_hint.tr,
                                    label: LocaleKeys.authScrean_pasword.tr,
                                    hidpass: controller.showPassword,
                                    validator: (p0) => ValidatorApp.getVaidator(
                                        ValidateType.passord, p0),
                                    onchange: (p0) {
                                      controller.password = p0;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  defaultButton(
                                      onPressed: () async {
                                        if (controller.keyForm.currentState!
                                            .validate()) {
                                          await controller.loginUser();
                                        }
                                      },
                                      isResponseve: false,
                                      isIcon: true,
                                      lable: LocaleKeys.buttons_login.tr,
                                      icon: const Icon(
                                        Icons.login,
                                        color: Colors.white,
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
    ));
  }

  Row layoutPage() {
    return Row(
      children: [
        Expanded(
          child: DefaultCountainer(
            width: Get.width / 2,
            height: Get.height,
            color: Get.theme.colorScheme.primary,
          ),
        ),
        Expanded(
          child: DefaultCountainer(
            width: Get.width / 2,
            height: Get.height,
            color: Get.theme.colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
