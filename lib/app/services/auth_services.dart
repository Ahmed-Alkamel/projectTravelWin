import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/basic/user_request.dart';
import '../repository/auth_employee_repository .dart';
import '../routes/app_pages.dart';

class AuthUserService extends GetxService {
  GetStorage box = GetStorage();
  AuthEmployeesRepository authUserRepository = AuthEmployeesRepository();
  Employees? user;

  Future<AuthUserService> init() async {
    if (await isLogin()) {
      user = Employees.fromJson(box.read('user'));
    }
    return this;
  }

  Future<bool> isLogin() async {
    if (box.read('user') != null) {
      return true;
    } else {
      return false;
    }
  }

  Future logout() async {
    // await box.remove('user');
    user = null;
    await Get.offAllNamed(Routes.AUTH);
  }

  Future loginUser(Employees user) async {
    // await box.write('user', user.toJson());
    this.user = user;
    // print(this.user.toString());
  }

  // Future refresh() async {
  //   if (await isLogin()) {
  //     Employees? userUpdate = await authUserRepository.refresh(user!.idCus!);
  //     if (userUpdate != null) {
  //       await loginUser(userUpdate);
  //     }
  //   }
  // }
}
