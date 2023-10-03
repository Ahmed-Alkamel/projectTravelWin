import 'package:get/get.dart';

import '../data/api/laravel_api.dart';
import '../models/basic/data_basic_add_trip.dart';
import '../models/basic/request_services.dart';
import '../models/basic/trips.dart';

class TripsRepository {
  LaravelApi? _laravelApi;
  TripsRepository() {
    _laravelApi = Get.find<LaravelApi>();
  }

  Future<List<Trips>> all() {
    _laravelApi = Get.find<LaravelApi>();
    return _laravelApi!.getAllTrips();
  }

  Future<bool> addRequstBooking(RequestServicesModelSend data) async {
    return await _laravelApi!.addRequstServiceTrip(data);
  }

  Future<DataBasicAddTrip?> getDataBasicAddTrip() async {
    // var dd = await _laravelApi!.getDataBasictoAddTrip();
    return await _laravelApi!.getDataBasictoAddTrip();
  }

  Future<Trips?> addTrip(Trips trip) async {
    return await _laravelApi!.addTrip(trip);
  }
}
