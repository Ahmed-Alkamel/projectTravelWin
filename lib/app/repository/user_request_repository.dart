import 'package:get/get.dart';

import '../data/api/laravel_api.dart';
import '../models/basic/data_basic_management_customer_req.dart';
import '../models/basic/requst_service_booking.dart';
import '../models/basic/state_request.dart';
import '../models/basic/user_request.dart';

class UserRequestRepository {
  LaravelApi? _laravelApi;
  UserRequestRepository() {
    _laravelApi = Get.find<LaravelApi>();
  }

  Future<List<UserRequest>?> getRequestById(int id) async {
    return await _laravelApi!.getRequestUser(id);
  }

  Future<List<StateRequest>> getAllStatRequest() async {
    return await _laravelApi!.getStateRequest();
  }

  Future<List<UserRequest>> all() async {
    return _laravelApi!.getAllCustomerRequest();
  }

  Future<DataBasicCustomerRequest?> getDataBaic() async {
    return await _laravelApi!.getDataBasicManagementCutmerRequest();
  }

  Future<bool> changeState(int idCust, int idState, int idReq) async {
    return await _laravelApi!
        .changeStateRequestCustoemer(idCust, idReq, idState);
  }

  Future<List<UserRequest>> editeDatainput(List<DataInputRequrment> dataedidt,
      int type, int idRequest, int idStateReq) async {
    return await _laravelApi!
        .editeInputdataState(dataedidt, type, idRequest, idStateReq);
  }
}
