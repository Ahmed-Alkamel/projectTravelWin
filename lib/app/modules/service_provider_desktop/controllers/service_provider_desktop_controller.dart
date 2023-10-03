import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projecttravelwin/app/commen/ui.dart';
import 'package:projecttravelwin/app/models/basic/company.dart';
import 'package:projecttravelwin/app/models/services/global_services.dart';

import '../../../models/basic/data_basic_add_provider.dart';
import '../../../repository/companies_repository.dart';

class ServiceProviderDesktopController extends GetxController {
  RxBool isloadAddScreen = RxBool(false);
  CompaniesRepository? _companiesRepository;
  GlobalKey<FormState> keyFomeadd = GlobalKey<FormState>();
  DataBasicAddCompany? dataBasic;
  RxList<Company> allCompany = RxList();
  Company? newCompany;
  @override
  void onInit() async {
    _companiesRepository = CompaniesRepository();
    await loadData();
    super.onInit();
  }

  loadData() async {
    isloadAddScreen.value = true;
    dataBasic = await _companiesRepository!.getDataBasic();
    allCompany.value = await _companiesRepository!.all();
    isloadAddScreen.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updatecheckService() {
    update([
      'checkService',
    ]);
  }

  void updateserviceProvider() {
    update([
      'serviceProvider',
    ]);
  }

  saveCompany() async {
    isloadAddScreen.value = true;
    Company? temp = await _companiesRepository!.addCompany(newCompany!);
    if (temp == null) {
      UiApp.snakfaild('فشل', "فشلة عملية الاضافة");
    } else {
      Get.back();
      allCompany.add(temp);
      UiApp.snakSecess('تم', "تمت الاضافة بنجاح");
    }
    isloadAddScreen.value = false;
  }

  void test() {
    print(newCompany!.toMap());
    print('object');
  }
}
