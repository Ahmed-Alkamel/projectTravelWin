import 'package:get/get.dart';

class Socket extends GetConnect {
  GetSocket userMessages() {
    return socket('http://travelproject.developer:6001/app/ProjectTravel_key');
  }
}
