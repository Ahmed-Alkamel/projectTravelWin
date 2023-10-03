import 'package:get/get.dart';
import 'package:projecttravelwin/app/models/basic/user_request.dart';

import '../data/api/laravel_api.dart';
import '../models/basic/proccess_app.dart';

class ManagmentUserRepository {
  LaravelApi? _laravelApi;
  ManagmentUserRepository() {
    _laravelApi = Get.find<LaravelApi>();
  }
  Future<List<ProcessApp>> all() async {
    return await _laravelApi!.getAllProcessPermission();
  }

  Future<Employees?> saveData(Employees newEmply) async {
    return await _laravelApi!.addEmployee(newEmply);
  }
}
