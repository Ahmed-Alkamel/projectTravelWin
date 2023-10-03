import 'package:get/get.dart';
import 'package:projecttravelwin/app/commen/ui.dart';

import '../../../models/basic/country.dart';
import '../../../models/basic/data_basic_add_trip.dart';
import '../../../models/basic/trips.dart';
import '../../../repository/trips_repository.dart';

class TripsDesktopController extends GetxController {
  TripsRepository? _tripsRepository;
  var isLoadAddService = false.obs;
  DataBasicAddTrip? dataBasciAdd;
  List<Trips>? trips;
  List<Trips> newTrips = [];
  Trips? newTrip;

  @override
  void onInit() async {
    if (Get.parameters['type'] == 'add') {
      await loaddataToadd();
    }
    super.onInit();
  }

  List<City> get getlocolGoalCity {
    if (dataBasciAdd != null) {
      if (dataBasciAdd!.countries != null) {
        Countries counry = dataBasciAdd!.countries!
            .singleWhere((element) => element.isLocal == true);
        if (counry.cities != null || counry.cities!.isNotEmpty) {
          return counry.cities!;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  List<Countries> get getGlobalCountry {
    if (dataBasciAdd != null) {
      if (dataBasciAdd!.countries != null) {
        return dataBasciAdd!.countries!
            .where((element) =>
                element.cities != null || element.cities!.isNotEmpty)
            .toList();
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  loaddataToadd() async {
    _tripsRepository ??= TripsRepository();
    isLoadAddService.value = true;
    dataBasciAdd = await _tripsRepository!.getDataBasicAddTrip();

    trips = await _tripsRepository!.all();
    // Trips trip = trips!.first;
    // trips = List.generate(200, (index) => trip);
    trips ?? [];
    isLoadAddService.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  List<City> getCiryLocal() {
    int idCityLocal =
        dataBasciAdd!.countries!.singleWhere((element) => element.isLocal!).id!;
    return dataBasciAdd!.cities!
        .where((element) => element.idCountry == idCityLocal)
        .toList();
  }

  void updateTripGoalCity() {
    update(['TripGoalCity']);
  }

  void updateFromCityGlobal() {
    update(['FromCityGlobal']);
  }

  List<City>? getCityGlobal(Countries? countries) {
    if (countries != null && countries.cities != null) {
      // updateFromCityGlobal();
      return countries.cities!;
    } else {
      // updateFromCityGlobal();
      return null;
    }
  }

  void updatetoCityGlobal() {
    update(['toCityGlobal']);
  }

  void updatetoCityForm() {
    update(['toCityForm']);
  }

  void updateTripGoalAllOver() {
    update(['TripGoalAllOver']);
  }

  void updatecheckDays() {
    update(['checkDays']);
  }

  void test() {
    print(newTrip!.toMap());
    print('object');
  }

  void updatetimeLeave() {
    update(['timeLeave']);
  }

  void updatetimeLive() {
    update(['timeLive', 'toTimeLive']);
  }

  Future<void> saveTrip() async {
    isLoadAddService.value = true;
    print(newTrip!.toMap());
    Trips? state = await _tripsRepository!.addTrip(newTrip!);
    if (state != null) {
      UiApp.snakSecess('تم', "تم اضافة الرحلة بنجاح");

      trips!.add(state);
    } else {
      UiApp.snakfaild('فشل', "فشلة عملية الاضافة");
    }
    isLoadAddService.value = false;
  }

  void updatecompanyServicesProvider() {
    update(['companyServicesProvider']);
  }

  void updatalocalToCity() {
    update(['localToCity']);
  }

  void updateselectCheckbox() {
    update(['selectCheckbox', 'atcountCustom']);
  }

// List<Countries>  getCountryGlobla() {

//   }
}
