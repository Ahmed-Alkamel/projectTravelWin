import 'package:get/get.dart';

import '../data/api/laravel_api.dart';
import '../models/basic/customer.dart';
import '../models/basic/user_request.dart';

class AuthEmployeesRepository {
  LaravelApi? _laravelApi;
  AuthEmployeesRepository() {
    _laravelApi = Get.find<LaravelApi>();
  }
  singInUser(User user) async {
    return _laravelApi!.singInUser(user);
  }

  Future<Employees?> login(String ident, String password) async {
    return await _laravelApi!.loginEmployees(ident, password);
  }

  Future<User?> refresh(int id) async {
    return await _laravelApi!.refreshUser(id);
  }
}
