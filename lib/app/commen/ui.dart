import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/widgets/default_widget.dart';
import '../modules/widgets/main_widget_desktop.dart';
import '../theme/color.dart';

class UiApp {
  static snakSecess(String title, String message) {
    return Get.snackbar(title, message,
        borderRadius: 25,
        backgroundColor: Get.theme.colorScheme.secondary,
        icon: const Icon(
          Icons.done,
          color: Colors.green,
        ));
  }

  static snakfaild(String title, String message) {
    return Get.snackbar(title, message,
        borderRadius: 25,
        backgroundColor: Get.theme.colorScheme.secondary,
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ));
  }

  static snakNote(String title, String message) {
    return Get.snackbar(title, message,
        borderRadius: 25,
        backgroundColor: Get.theme.colorScheme.secondary,
        icon: const Icon(
          Icons.info,
          color: Colors.yellow,
        ));
  }

  static Future defaultDeialog(
      {required String title,
      Widget? confirm,
      Widget? cancel,
      EdgeInsetsGeometry? contentPadding,
      void Function()? onCancel,
      void Function()? onConfirm,
      Widget? content,
      TextStyle? titleStyle,
      Future<bool> Function()? onWillPop,
      Color? backgroundColor}) async {
    return await Get.defaultDialog(
        titleStyle: titleStyle ??
            Get.textTheme.titleMedium!
                .merge(TextStyle(color: Get.theme.colorScheme.primary)),
        content: SizedDilogContaint(child: content),
        title: title,
        confirm: confirm,
        cancel: cancel,
        contentPadding: contentPadding,
        backgroundColor: backgroundColor ?? Colors.white,
        onCancel: onCancel,
        onConfirm: onConfirm,
        onWillPop: onWillPop);
  }

  static Widget buttonDone(
      {required String lable, void Function()? onPressed}) {
    return defaultButton(
        isResponseve: true,
        isIcon: true,
        lable: lable,
        icon: Icon(
          Icons.check,
          color: Get.theme.colorScheme.secondary,
        ),
        color: DefaultColor.containTheme3,
        onPressed: onPressed);
  }

  static Widget buttonCansal(
      {required String lable, void Function()? onPressed}) {
    return defaultButton(
        isResponseve: true,
        isIcon: true,
        lable: lable,
        icon: Icon(
          Icons.cancel,
          color: Get.theme.colorScheme.secondary,
        ),
        color: DefaultColor.canselColor,
        onPressed: onPressed);
  }
}
