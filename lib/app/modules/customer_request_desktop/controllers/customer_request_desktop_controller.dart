import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projecttravelwin/app/commen/ui.dart';
import 'package:projecttravelwin/app/models/basic/requst_service_booking.dart';
import 'package:projecttravelwin/app/models/basic/user_request.dart';

import '../../../models/basic/data_basic_management_customer_req.dart';
import '../../../repository/user_request_repository.dart';

class CustomerRequestDesktopController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = RxBool(false);

  UserRequestRepository? _userRequestRepository;
  List<UserRequest> allRequest = [];
  DataBasicCustomerRequest? databasic;
  List<DataInputRequrment> dataedidt = [];
  @override
  void onInit() async {
    _userRequestRepository = UserRequestRepository();

    await loadData();
    super.onInit();
  }

  loadData() async {
    isLoading.value = true;
    allRequest = await _userRequestRepository!.all();
    databasic = await _userRequestRepository!.getDataBaic();
    sortAllRequest();
    isLoading.value = false;
  }

  sortAllRequest() {
    allRequest.sort((y, x) {
      if (x.requestTrip != null) {
        if (y.requestTrip == null) {
          return x.requestTrip!.bookingTime!
              .compareTo(y.requestServicePublic!.bookingServicesDate!);
        } else {
          return x.requestTrip!.bookingTime!
              .compareTo(y.requestTrip!.bookingTime!);
        }
      } else {
        if (y.requestTrip != null) {
          return x.requestServicePublic!.bookingServicesDate!
              .compareTo(y.requestTrip!.bookingTime!);
        } else {
          return x.requestServicePublic!.bookingServicesDate!
              .compareTo(y.requestServicePublic!.bookingServicesDate!);
        }
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // animationController.dispose();
    super.onClose();
  }

  void updatestateRequement(String idStataRequement) {
    update([idStataRequement]);
  }

  Future<bool> reciverequest(
      {required int idCust, required int idState, required int idReq}) async {
    isLoading.value = true;
    bool tem =
        await _userRequestRepository!.changeState(idCust, idState, idReq);
    isLoading.value = false;
    return tem;
  }

  void addEditeData(DataInputRequrment dataInputRequrment) {
    int index = dataedidt
        .indexWhere((element) => element.idprim == dataInputRequrment.idprim);
    if (index != -1) {
      dataedidt[index] = dataInputRequrment;
    } else {
      dataedidt.add(dataInputRequrment);
    }
  }

  editetoServer(
      {required int type,
      required int idRequest,
      required int idStateReq}) async {
    // if (dataedidt.isNotEmpty) {
    isLoading.value = true;
    List<UserRequest> temp = await _userRequestRepository!
        .editeDatainput(dataedidt, type, idRequest, idStateReq);
    if (temp.isNotEmpty) {
      allRequest = temp;
      sortAllRequest();
      dataedidt.clear();
      UiApp.snakSecess('نجحة العملية', 'نجحة العملية التسجيل');
      Get.back();
    } else {
      UiApp.snakfaild('فشل', 'لم تتم عملية التحديث');
    }
    isLoading.value = false;
    update(['listRequest']);
    Get.back();

    // print(dataedidt.map((e) => e.toMapedit()).toList());
    // }
  }

  void updatestateRequest() {
    update(['stateRequest']);
  }

  void updastateRequestName() {
    update(['stateRequestName']);
  }
}
