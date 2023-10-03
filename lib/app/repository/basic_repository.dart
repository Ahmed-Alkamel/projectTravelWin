import 'package:get/get.dart';

import '../data/api/laravel_api.dart';
import '../models/basic/data_basic.dart';

class DataBasicRepository {
  LaravelApi? _laravelApi;
  DataBasicRepository() {
    _laravelApi = Get.find<LaravelApi>();
  }
  Future<DataBasic?> all() async {
    return await _laravelApi!.getAllDataBasic();
  }
}
