import 'package:get/get.dart';

import '../data/api/laravel_api.dart';
import '../models/basic/databasicaddServie.dart';
import '../models/basic/request_services.dart';
import '../models/basic/service.dart';

class ServicesRepository {
  LaravelApi? _laravelApi;
  ServicesRepository() {
    _laravelApi = Get.find<LaravelApi>();
  }
  Future<List<Service>?>? all() {
    return _laravelApi!.getAllServices();
  }

  Future<Service?> getServiceById(int id) async {
    return await _laravelApi!.getServicesId(id);
  }

  Future<List<Service>> getServicedByCategory(int id) async {
    return await _laravelApi!.getServicedByCategoryId(id);
  }

  Future<bool> addRequstServicesbooking(RequestServicesModelSend data) async {
    return await _laravelApi!.addRequstServiceBooking(data);
  }

  Future<DataBasicOfAddServic?> getDataBasic() async {
    return await _laravelApi!.getDataBasicService();
  }

  Future<Service?> addService(Service service) async {
    return await _laravelApi!.addService(service);
  }
}
