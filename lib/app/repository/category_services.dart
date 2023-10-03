import 'package:get/get.dart';

import '../data/api/laravel_api.dart';
import '../models/basic/category.dart';

class CategoryRepository {
  LaravelApi? _laravelApi;
  CategoryRepository() {
    _laravelApi = Get.find<LaravelApi>();
  }
  Future<List<Category>> all() async {
    return await _laravelApi!.getAllCategory();
  }

  Future<Category> getCategoryById(int id) async {
    return await _laravelApi!.getCategoryById(id);
  }
}
