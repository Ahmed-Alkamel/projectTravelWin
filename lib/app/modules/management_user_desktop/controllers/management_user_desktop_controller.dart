import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projecttravelwin/app/commen/ui.dart';

import '../../../models/basic/proccess_app.dart';
import '../../../models/basic/user_request.dart';
import '../../../repository/managment_user_repository.dart';

class ManagementUserDesktopController extends GetxController {
  RxBool isLoading = RxBool(false);
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  ManagmentUserRepository? _repository;
  List<ProcessApp> data = [];
  Employees? newEmply;

  ScrollController controllerScroll = ScrollController();
  @override
  void onInit() async {
    _repository = ManagmentUserRepository();
    await loadData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  loadData() async {
    isLoading.value = true;
    data = await _repository!.all();
    newEmply = Employees();
    newEmply!.permisstion = data;
    isLoading.value = false;
  }

  void updatePermisstion(String s) {
    update([s]);
  }

  Future<void> saveEmploy() async {
    isLoading.value = true;
    Employees? temp = await _repository!.saveData(newEmply!);
    if (temp == null) {
      UiApp.snakfaild('فشل', 'فشلة عملية الاضافة');
    } else {
      UiApp.snakSecess('نجح', "تمت عملية الاضافة بنجاح");
      newEmply = null;
      newEmply = Employees();
      newEmply!.permisstion = data;
    }
    isLoading.value = false;
  }
}
