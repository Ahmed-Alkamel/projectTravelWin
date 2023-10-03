import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projecttravelwin/app/commen/ui.dart';
import 'package:projecttravelwin/app/models/basic/category.dart';
import 'package:projecttravelwin/app/models/basic/databasicaddServie.dart';
import 'package:projecttravelwin/app/models/basic/main_requiremnt.dart';
import 'package:projecttravelwin/app/models/basic/service.dart';

import '../../../repository/services_travel.dart';

class AddServiceController extends GetxController {
  var isLoading = false.obs;
  RxList<Category> islevel2 = RxList<Category>();
  RxList<Category> islevel3 = RxList<Category>();
  ServicesRepository? _servicesRepository;
  List<Category> categroy = [];
  DataBasicOfAddServic? dataBasic;
  List<MainRequirment> hintHot = [];
  Service newService = Service();

  GlobalKey<FormState> keyPublicForm = GlobalKey<FormState>();
  File? fileCurrent;

  TextEditingController controllerHint = TextEditingController();

  bool get checkIsTripCategry {
    if (newService.category!.idCategoryMain == 1) {
      return true;
    } else if (newService.category!.idCategoryMain! > 4) {
      return true;
    } else {
      return false;
    }
  }

  List<MainRequirment> get getHintFrom => newService.mainRequirment == null
      ? []
      : newService.mainRequirment!
          .where((element) => element.typeFiled!.id! == 10)
          .toList();

  // Widget get checkIsTripCategry => null;
  @override
  void onInit() async {
    _servicesRepository = ServicesRepository();
    await loadData();
    super.onInit();
  }

  loadData() async {
    isLoading.value = true;
    dataBasic = await _servicesRepository!.getDataBasic();
    categroy = dataBasic!.categories;
    // = categroy.first;
    islevel2.value = categroy.first.subCategory ?? [];
    islevel3.value = islevel2.first.subCategory ?? [];
    newService.category = islevel3.first;
    isLoading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  filePiicker() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['svg']);

    if (result != null) {
      fileCurrent = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  void adjest(int i, List<Category> value) {
    if (i == 1) {
      islevel2.value = value;

      islevel3.value = islevel2.first.subCategory ?? [];
      newService.category = islevel3.first;
    } else if (i == 2) {
      islevel3.value = value;
      newService.category = islevel3.first;
    }
  }

  void updateSelectIdentey() {
    update(['selectIdentityCard']);
  }

  void updateMainRequerment() {
    update(['MainRequerment']);
  }

  void updateAddChoice() {
    update(['AddChoice']);
  }

  void updateSubRequerment() {
    update(['SubRequrment']);
  }

  void updataGender() {
    update(['Gender']);
    updateDetailsSubRequement();
  }

  void updateisFamily() {
    update(['isFamly']);
    updateDetailsSubRequement();
  }

  void updateDetailsSubRequement() {
    update(['DetailsSubRequement']);
  }

  void updateAddChoiceSub() {
    update(['AddChoiceSub']);
    updateDetailsSubRequement();
  }

  void updateDropDownTypeFild() {
    update(['DropDownTypeFild']);
  }

  void updateDropDowntypeMain() {
    update(['DropDowntypeMain']);
  }

  void test() {
    print('hflskdjfl');
  }

//دالة اضافة خدمة
  addService() async {
    if (checkIsTripCategry) {
      newService.serviceDetails = null;
    }
    if (hintHot.isNotEmpty) {
      newService.mainRequirment!.addAll(hintHot);
    }

    isLoading.value = true;
    Service? temp = await _servicesRepository!.addService(newService);

    if (temp != null) {
      await UiApp.snakSecess('تم', 'تمت عملية الاضافة');
    } else {
      await UiApp.snakfaild('فشل', "فشلة عملية الاضافة");
    }
    hintHot.clear();
    newService.mainRequirment!.clear();
    newService.subRequiremnts?.clear();
    newService.identitfyRequerment?.clear();
    isLoading.value = false;
  }

  void updataServicesDetails() {
    update(['ServicesDetails']);
  }

  void updatehintView() {
    update(['hintView']);
  }
}
