// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLocalesController extends GetxController {
  void changeLang(String codelang) {
    // ignore: unused_local_variable
    Locale locale = Locale(codelang);
  }
}
