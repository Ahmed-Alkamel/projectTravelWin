// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:projecttravelwin/app/models/basic/state_request.dart';
import 'package:projecttravelwin/app/models/basic/user_request.dart';

import '../data/api/laravel_api.dart';
import '../models/basic/trips.dart';

class ReportRepository {
  LaravelApi? _laravelApi;
  ReportRepository() {
    _laravelApi = Get.find<LaravelApi>();
  }
  Future<List<Info>> allTrip() async {
    return await _laravelApi!.getTripsReport();
  }

  Future<List<UserRequest>> allUserRequest() async {
    return await _laravelApi!.getReportAllRequest();
  }

  Future<List<StateRequest>> dataBasic() async {
    return _laravelApi!.getDataBasicReport();
  }
}
