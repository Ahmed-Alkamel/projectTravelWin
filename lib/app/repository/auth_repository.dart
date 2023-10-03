import 'package:get/get.dart';

import '../data/api/laravel_api.dart';
import '../models/basic/customer.dart';

class AuthUserRepository {
  LaravelApi? _laravelApi;
  AuthUserRepository() {
    _laravelApi = Get.find<LaravelApi>();
  }
  singInUser(User user) {
    return _laravelApi!.singInUser(user);
  }

  Future<User?> login(String ident, String password) async {
    return await _laravelApi!.loginUser(ident, password);
  }

  Future<User?> refresh(int id) async {
    return await _laravelApi!.refreshUser(id);
  }
}
