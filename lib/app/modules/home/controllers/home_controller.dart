import 'package:get/get.dart';


import '../../../models/basic/category.dart';
import '../../../models/basic/service.dart';
import '../../../repository/category_services.dart';
import '../../../repository/services_travel.dart';

class HomeController extends GetxController {
  List<Service>? servicsImportaint = [];
  List<Category>? category = [];
  ServicesRepository? _repository;
  CategoryRepository? _categoryRepository;
  List<Service>? tempSevices = [];
  HomeController() {
    _repository = ServicesRepository();
    _categoryRepository = CategoryRepository();
  }
  @override
  void onInit() async {
    category = await _categoryRepository!.all();
    servicsImportaint = await _repository!.all();
    category!.sort((a, b) => a.idCategoryMain!.compareTo(b.idCategoryMain!));
    update(['CardServicesList']);

    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  onSelectCategory(Category category) {
    tempSevices = servicsImportaint!
        .where((element) =>
            category.idCategoryMain == element.category!.idCategoryMain!)
        .toList();
  }

  Future extractCategorySecondery() async {
    // List<Service> temp2 = tempSevices!
    //     .where((element) => element.categorySecondry != null)
    //     .toList();

    // if (temp2.isEmpty) {
    //   defaultBottomSheet(item: tempSevices!, titleBottom: 'الخدمات');
    // } else {
    //   List<CategorySecondry?> categorySecondry = temp2.map((e) {
    //     if (e.categorySecondry != null) {
    //       return e.categorySecondry!;
    //     }
    //   }).toList()
    //     ..toSet().toList();
    //   categorySecondry = categorySecondry.toSet().toList();

    //   await defaultShowDialog(title: 'قم بالختيار', itmes: categorySecondry);
    // }
    // if (categorySecondry != null) {
    //   // print('object');
    //   //

    //   //await
    // } else {
    //   //
    // }
  }
}
