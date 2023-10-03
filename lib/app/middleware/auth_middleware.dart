// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/basic/user_request.dart';
import '../routes/app_pages.dart';
import '../services/auth_services.dart';

class AuthMiddleware extends GetMiddleware {
//   @override
//   int? priority;
  bool isdone = false;
  @override
  RouteSettings? redirect(String? route) {
    Employees? user = Get.find<AuthUserService>().user;
    if (route == Routes.AUTH) {
      if (user != null) {
        return const RouteSettings(
          name: Routes.MAIN_SCREAN,
        );
      }
    } else if (route == Routes.SERVICES_SCREEN_BENEFITES) {
      if (user == null) {
        return const RouteSettings(name: Routes.AUTH, arguments: 1);
      }
    } else if (route == Routes.SERVICES_Public_BENEFITES) {
      if (user == null) {
        return const RouteSettings(name: Routes.AUTH, arguments: 2);
      }
    } else if (route == Routes.ChatScreen) {
      if (user == null) {
        return const RouteSettings(name: Routes.AUTH);
      }
    }
  }
}
