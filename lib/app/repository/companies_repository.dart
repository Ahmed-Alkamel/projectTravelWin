import 'package:get/get.dart';

import '../data/api/laravel_api.dart';
import '../models/basic/company.dart';
import '../models/basic/data_basic_add_provider.dart';

class CompaniesRepository {
  LaravelApi? _laravelApi;
  CompaniesRepository() {
    _laravelApi = Get.find<LaravelApi>();
  }
  Future<List<Company>> all() {
    return _laravelApi!.getAllCompany();
  }

  Future<Company?> addCompany(Company company) async {
    return await _laravelApi!.addCompany(company);
  }

  Future<DataBasicAddCompany?> getDataBasic() async {
    return await _laravelApi!.getDataBasicCompany();
  }
}
