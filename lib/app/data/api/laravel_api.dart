import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:projecttravelwin/app/commen/ui.dart';
import 'package:projecttravelwin/app/models/basic/databasicaddServie.dart';
import 'package:projecttravelwin/app/models/basic/requst_service_booking.dart';

import '../../Helper/diohelper.dart';
import '../../models/basic/category.dart';
import '../../models/basic/chat.dart';
import '../../models/basic/company.dart';
import '../../models/basic/customer.dart';
import '../../models/basic/data_basic.dart';
import '../../models/basic/data_basic_add_provider.dart';
import '../../models/basic/data_basic_add_trip.dart';
import '../../models/basic/data_basic_management_customer_req.dart';
import '../../models/basic/proccess_app.dart';
import '../../models/basic/request_services.dart';
import '../../models/basic/service.dart';
import '../../models/basic/state_request.dart';
import '../../models/basic/trips.dart';
import '../../models/basic/user_request.dart';

class LaravelApi extends GetxService {
  Future<LaravelApi> init() async {
    return this;
  }

  Future<List<Service>?> getAllServices() async {
    List? data = await DioHelpper.postData(path: 'ShowServices').then((value) {
      if (value.data['state'] as bool) {
        return value.data['data'];
      } else {
        return null;
      }
    });
    List<Service> tempServices = data!.map((e) => Service.fromMap(e)).toList();

    return tempServices;
  }

  Future<Service?> getServicesId(int id) async {
    var respons =
        await DioHelpper.postData(data: {'idService': id}, path: 'ServiceById');
    if (respons.data['state']) {
      return Service.fromMap(respons.data['data']);
    } else {
      return null;
    }
  }

  Future<DataBasic?> getAllDataBasic() async {
    var respons = await DioHelpper.postData(data: null, path: 'BaseData/index');
    if (respons.data['state']) {
      DataBasicModel data = DataBasicModel.fromMap(respons.data);
      return data.data!;
    } else {
      return null;
    }
  }

  Future<List<Category>> getAllCategory() async {
    var respons = await DioHelpper.getData(path: 'category');

    if (respons.data['state']) {
      CategoryModel categoryModel = CategoryModel.fromMap(respons.data);

      return categoryModel.data!;
    } else {
      return [];
    }
  }

  Future<List<Company>> getAllCompany() async {
    Map<String, dynamic>? data =
        await DioHelpper.getData(path: 'Company').then((value) {
      if (value.data['state'] as bool) {
        return value.data;
      } else {
        return null;
      }
    });
    CompanyModel companies = CompanyModel.fromMap(data!);

    return companies.data!;
  }

  Future<List<Trips>> getAllTrips() async {
    Map<String, dynamic>? data =
        await DioHelpper.getData(path: 'trips').then((value) {
      if (value.data['state'] as bool) {
        return value.data;
      } else {
        return null;
      }
    });
    TripsModel trips = TripsModel.fromMap(data!);

    return trips.data!;
  }

  Future<Category> getCategoryById(int id) async {
    try {
      var respons =
          await DioHelpper.postData(data: {'id': id}, path: 'getCategory');
      if (respons.data['state']) {
        return Category.fromMap(respons.data['data']);
      } else {
        return Category();
      }
    } catch (e) {
      return Category();
    }
  }

  Future<List<Service>> getServicedByCategoryId(int id) async {
    try {
      var respons = await DioHelpper.postData(
          data: {'id': id}, path: 'ServiceByCategryid');
      List<Service> services = [];

      var data = ServicesModel.fromMap(respons.data);
      if (data.state) {
        services = data.data ?? [];
        return services;
      } else {
        return services;
      }
    } catch (e) {
      return [];
    }
  }

  Future<bool> addRequstServiceTrip(RequestServicesModelSend data) async {
    try {
      var datasend = data.toMap();

      var response =
          await DioHelpper.postData(path: 'BookingTrip/add', data: datasend);

      if (response.data['state'] == true) {
        return true;
      } else {
        // print(response.data);
        return false;
      }
    } catch (e) {
      if (e is dio.DioError) {
        // print(e.response!.data);
        return false;
      }
      return false;
    }
  }

  Future<bool> addRequstServiceBooking(RequestServicesModelSend data) async {
    try {
      var datasend = data.toMap();

      var response = await DioHelpper.postData(
          path: 'ServicesBooking/Add', data: datasend);
      // print(datasend);
      if (response.data['state'] == true) {
        return true;
      } else {
        print(response.data);
        return false;
      }
    } catch (e) {
      if (e is dio.DioError) {
        print(e.response!.data);
        return false;
      }
      return false;
    }
  }

  Future<bool> notificationRecieve(int id) async {
    try {
      var response = await DioHelpper.postData(
          path: 'notification/recive', data: {'id': id});
      // print(datasend);
      if (response.statusCode == 200) {
        return true;
      } else {
        // print(response.data);
        return false;
      }
    } catch (e) {
      if (e is dio.DioError) {
        // print(e.response!.data);
        return false;
      }
      return false;
    }
  }

  singInUser(User user) async {
    var respons =
        await DioHelpper.postData(path: 'customer/sigin', data: user.toMap());
    if (respons.data['state'] == true) {
      return User.fromMap(respons.data['data']);
    } else if (respons.data['massege'] == "23000") {
      return 23000;
    } else {
      // print(respons.data);
      return -999;
    }
  }

  Future<User?> loginUser(String ident, String password) async {
    try {
      var respons = await DioHelpper.postData(
          path: 'customer/login', data: {'ident': ident, 'password': password});
      if (respons.data['state'] == true) {
        return User.fromMap(respons.data['data']);
      } else {
        print(respons.data);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Employees?> loginEmployees(String ident, String password) async {
    try {
      var respons = await DioHelpper.postData(
          path: 'employees/login',
          data: {'ident': ident, 'password': password});
      if (respons.data['state'] == true) {
        return Employees.fromMap(respons.data['data']);
      } else {
        print(respons.data);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<UserRequest>?> getRequestUser(int id) async {
    try {
      var respons = await DioHelpper.postData(
          path: 'CustomerRequest/read', data: {'id': id});
      if (respons.statusCode == 200) {
        var model = CutomerRequestModel.fromMap(respons.data);
        return model.data;
      } else {
        return null;
      }
    } catch (e) {
      // print(e);
      return null;
    }
  }

  Future<List<StateRequest>> getStateRequest() async {
    try {
      var respons = await DioHelpper.postData(path: 'BaseData/getStateRequest');
      if (respons.data['state']) {
        return StateRequestModel.fromMap(respons.data).data!;
      } else {
        return [];
      }
    } catch (e) {
      // print(e);
      return [];
    }
  }

  Future<List<Chat>> getAllChatById(int idChat) async {
    try {
      var respons = await DioHelpper.postData(
          path: 'chat/read', data: {'idChat': idChat});
      if (respons.data['state']) {
        return ChatModel.fromMap(respons.data).data!;
      } else {
        return [];
      }
    } catch (e) {
      // print(e);
      return [];
    }
  }

  Future<Chat?> sendChatToServer(int idChat, String containt) async {
    try {
      var respons = await DioHelpper.postData(
          path: 'chat/toServer',
          data: {'idChat': idChat, 'containt': containt});
      if (respons.data['state']) {
        return Chat.fromMap(respons.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      // print(e);
      return null;
    }
  }

  Future<bool> verifyMessageServer(int id) async {
    try {
      var respons = await DioHelpper.postData(
          path: 'chat/verifyMessage', data: {'id': id});
      if (respons.data['state']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<User?> refreshUser(int id) async {
    try {
      var respons =
          await DioHelpper.postData(path: 'customer/refresh', data: {'id': id});
      if (respons.data['state']) {
        return User.fromMap(respons.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      Get.log(e.toString());
      return null;
    }
  }

  Future<DataBasicOfAddServic?> getDataBasicService() async {
    try {
      var response =
          await DioHelpper.postData(path: 'BaseData/getDataAddService');
      if (response.data['state']) {
        return DataBasicOfAddServicModel.fromMap(response.data).data;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

//دالة الرفع الى  السرفر
  Future<Service?> addService(Service service) async {
    try {
      var response = await DioHelpper.postData(
          path: 'Services/add', data: service.toMap());
      if (response.data['state']) {
        return Service.fromMap(response.data['data']);
      } else {
        print(response.data);
        return null;
      }
    } catch (e) {
      Get.log(e.toString());
      return null;
    }
  }

  Future<Trips?> addTrip(Trips trip) async {
    try {
      // print(service.toMap());
      var response =
          await DioHelpper.postData(path: 'trips/add', data: trip.toMap());
      if (response.data['state']) {
        return Trips.fromMap(response.data['data']);
      } else {
        print(response.data);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<DataBasicAddTrip?> getDataBasictoAddTrip() async {
    try {
      var respons = await DioHelpper.postData(path: 'BaseData/getDataAddTrip');
      // DataBasicAddTripModel temp=DataBasicAddTripModel.fromMap(respons.data);
      if (respons.data['state']) {
        DataBasicAddTrip datab =
            DataBasicAddTripModel.fromMap(respons.data).data!;
        return datab;
      } else {
        Get.log(respons.data['data'].toString());
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<DataBasicAddCompany?> getDataBasicCompany() async {
    try {
      var respons = await DioHelpper.postData(
        path: 'BaseData/getDataAddCompany',
      );
      if (respons.data['state']) {
        return DataBasicAddCompany.fromMap(respons.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Company?> addCompany(Company company) async {
    try {
      var respons =
          await DioHelpper.postData(path: 'Company/add', data: company.toMap());
      if (respons.data['state']) {
        return Company.fromMap(respons.data['data']);
      } else {
        print(respons.data);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<UserRequest>> getAllCustomerRequest() async {
    try {
      var respons = await DioHelpper.postData(path: 'CustomerRequest/all');
      if (respons.data['state']) {
        return CutomerRequestModel.fromMap(respons.data).data ?? [];
      } else {
        print(respons.data);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<DataBasicCustomerRequest?>
      getDataBasicManagementCutmerRequest() async {
    try {
      var respons =
          await DioHelpper.postData(path: 'BaseData/getDataToManagCustrequest');
      if (respons.data['state']) {
        return respons.data['data'] == null
            ? null
            : DataBasicCustomerRequest.fromMap(respons.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> changeStateRequestCustoemer(
      int idCust, int idReq, int idState) async {
    try {
      var respons =
          await DioHelpper.postData(path: 'CustomerRequest/updataState', data: {
        'idCust': idCust,
        'idReq': idReq,
        'idState': idState,
      });
      if (respons.data['state']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<UserRequest>> editeInputdataState(
      List<DataInputRequrment> dataedidt,
      type,
      int idRequest,
      int idStateReq) async {
    try {
      print(type.toString() +
          'dfs '.toString() +
          idRequest.toString() +
          " sdklfj ".toString() +
          idStateReq.toString());
      var respons = await DioHelpper.postData(
          path: 'CustomerRequest/EditeDStatDataInput',
          data: {
            'type': type,
            'idRequst': idRequest,
            'idStateReq': idStateReq,
            'data': dataedidt.map((e) => e.toMapedit()).toList()
          });

      if (respons.data['state']) {
        return CutomerRequestModel.fromMap(respons.data).data ?? [];
      } else {
        print(respons.data);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Info>> getTripsReport() async {
    try {
      var respons = await DioHelpper.postData(path: 'report/cities');
      if (respons.data['state']) {
        return InfoModel.fromMap(respons.data).data ?? [];
      } else {
        print(respons.data);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<UserRequest>> getReportAllRequest() async {
    try {
      var respons = await DioHelpper.postData(path: 'report/custumorRequest');
      if (respons.data['state']) {
        return CutomerRequestModel.fromMap(respons.data).data ?? [];
      } else {
        print(respons.data);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<StateRequest>> getDataBasicReport() async {
    try {
      var respons =
          await DioHelpper.postData(path: 'BaseData/getReportDataBasic');
      if (respons.data['state']) {
        return respons.data['data'] != null
            ? List<StateRequest>.from(
                (respons.data['data'] as List<dynamic>).map<StateRequest?>(
                  (x) => StateRequest.fromMap(x as Map<String, dynamic>),
                ),
              )
            : [];
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<ProcessApp>> getAllProcessPermission() async {
    try {
      var respons = await DioHelpper.postData(path: "BaseData/getManageUser");
      if (respons.data['state']) {
        return ProcessAppModel.fromMap(respons.data).data ?? [];
      } else {
        print(respons.data);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Employees?> addEmployee(Employees newEmply) async {
    try {
      var respons = await DioHelpper.postData(
          path: 'employees/add', data: newEmply.toMap());
      if (respons.data['state']) {
        return Employees.fromMap(respons.data['data']);
      } else {
        String message = respons.data.toString();
        if (message.contains('NumberPhoneCompaniesUnique')) {
          await UiApp.snakfaild('فشل ', 'رقم الجوال مستخدم لمستخدم اخر');
        } else if (message.contains('for key \'PRIMARY')) {
          await UiApp.snakfaild('فشل ', 'الاسم الذي قمت بادخالة موجود مسبقا');
        }
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<ChatData>> getAllChat() async {
    try {
      var respons = await DioHelpper.postData(path: 'chat/readAllAdmin');
      if (respons.data['state']) {
        return ChatDataModel.fromMap(respons.data).data ?? [];
      } else {
        print(respons.data);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  sendChatCustomer(int idChat, String containt, int idEmp) async {
    try {
      var respons = await DioHelpper.postData(path: 'chat/toClint', data: {
        'idChat': idChat,
        'containt': containt,
        'idEmp': idEmp,
      });
      if (respons.data['state']) {
        print(respons.data);
      } else {
        print(respons.data);
      }
    } catch (e) {
      print(e);
    }
  }
}
