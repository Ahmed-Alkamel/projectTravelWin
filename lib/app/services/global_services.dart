import 'package:get/get.dart';

import '../models/services/global_services.dart';

class GlobalService extends GetxService {
  late final Global global;

  Future<GlobalService> init() async {
    global = Global(
        // laravelBaseUrl: 'http://10.0.2.2:5588/projectTravel/public/',
        // apiPath: 'api/v1/');
        // laravelBaseUrl: 'http://192.168.137.1:5588/projectTravel/public/',
        // apiPath: 'api/v1/');
        laravelBaseUrl: 'https://testvlast.steptech2022.com/public/',
        apiPath: 'api/v1/');
    // laravelBaseUrl: 'http://localhost:5588/projectTravel/public/',
    // apiPath: 'api/v1/');
    // laravelBaseUrl: 'http://192.168.207.26:5588/projectTravel/public/',
    // apiPath: 'api/v1/');
    // global = Global(
    //     laravelBaseUrl: 'http://127.0.0.1:5588/projectTravel/public/',
    //     apiPath: 'api/v1');
    return this;
  }

  String get baseUrl => global.laravelBaseUrl! + global.apiPath!;
}
