// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Helper/validation.dart';
import '../../../translations/locale.dart';
import '../../widgets/default_widget.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Obx(
        () => controller.isloading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: controller.keyFormSingin,
                child: SizedBox(
                  width: Get.width,
                  child: Column(
                    children: [
                      DefaultCountainer(
                        color: Get.theme.colorScheme.primary,
                        width: Get.width,
                        height: 50,
                        child: Center(
                          child: Text(
                            LocaleKeys.authScrean_createAcount.tr,
                            style: Get.textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                DefaultIcon.svg(
                                  path: 'icons/gmail.svg',
                                  height: 50,
                                  width: 50,
                                ),
                                Center(
                                  child: Text(
                                    LocaleKeys.buttons_sign_in_google.tr,
                                    style: Get.textTheme.headlineMedium,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Divider(
                                      color: Get.theme.colorScheme.primary,
                                      thickness: 2,
                                    ),
                                    Positioned(
                                      top: -5,
                                      left: Get.width / 2 - 5,
                                      child: Container(
                                        color: Get.theme.colorScheme.secondary,
                                        child: Text(LocaleKeys.authScrean_or.tr,
                                            style: Get.textTheme.headlineSmall),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                FormCreatAcount(controller: controller)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    ));
  }
}

class FormCreatAcount extends StatelessWidget {
  FormCreatAcount({super.key, required this.controller});
  AuthController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTextFormField(
          isborderall: true,
          hintText: LocaleKeys.createAcount_nameHint.tr,
          // initialValue: controller.user.nikName,
          label: LocaleKeys.createAcount_name.tr,
          validator: (p0) =>
              ValidatorApp.getVaidator(ValidateType.required, p0),
          suffixIcon: const Icon(Icons.person),
          onchange: (p0) {
            controller.user.nikName = p0;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        DefaultTextFormField(
          isborderall: true,
          hintText: LocaleKeys.createAcount_phoneNumberHint.tr,
          keyboardType: TextInputType.phone,
          validator: (p0) => ValidatorApp.getVaidator(ValidateType.number, p0),
          // initialValue: controller.user.numberPhone,
          label: LocaleKeys.createAcount_phoneNumber.tr,
          suffixIcon: const Icon(Icons.contact_emergency),
          onchange: (p0) {
            controller.user.numberPhone = p0;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        DefaultTextFormField(
          isborderall: true,
          hintText: LocaleKeys.createAcount_emailHint.tr,
          label: LocaleKeys.createAcount_email.tr,
          validator: (p0) => ValidatorApp.getVaidator(ValidateType.email, p0),
          // initialValue: controller.user.emailAddress,
          suffixIcon: const Icon(Icons.email),
          onchange: (p0) {
            controller.user.emailAddress = p0;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        DefaultTextFormField(
          isborderall: true,
          hintText: LocaleKeys.createAcount_passwordHint.tr,
          suffixIcon: const Icon(Icons.password),
          validator: (p0) => ValidatorApp.getVaidator(ValidateType.passord, p0),
          // initialValue: controller.user.password,
          label: LocaleKeys.createAcount_password.tr,
          hidpass: controller.showPassword,
          onchange: (p0) {
            controller.user.password = p0;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        DefaultTextFormField(
          isborderall: true,
          hintText: LocaleKeys.createAcount_passwordConformHint.tr,
          suffixIcon: const Icon(Icons.password),
          label: LocaleKeys.createAcount_passwordConform.tr,
          validator: (p0) => ValidatorApp.getVaidator(
              ValidateType.passwordConfigre, p0,
              confirm: controller.user.password),
          hidpass: controller.showPassword,
          // initialValue: controller.user.password,
          onchange: (p0) {},
        ),
        const SizedBox(
          height: 20,
        ),
        defaultButton(
            onPressed: () async {
              if (controller.keyFormSingin.currentState!.validate()) {
                // await controller.singIn(context);
              }
            },
            isResponseve: false,
            isIcon: true,
            lable: LocaleKeys.buttons_sign_in.tr,
            icon: const Icon(
              Icons.account_box,
              color: Colors.white,
            )),
      ],
    );
  }
}
