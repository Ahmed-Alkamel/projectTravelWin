import 'package:dio/dio.dart';
import 'package:get/get.dart' as gt;
import 'dart:io' as oi;
import '../services/global_services.dart';
import 'package:path_provider/path_provider.dart' as pa;

class DioHelpper {
  static late Dio dio;
  static late Dio dioBackgroud;
  static String urlbase = 'http:///localhost:5588/projectTravel/public/api/v1/';
  static init() async {
    dio = Dio(BaseOptions(
        baseUrl: gt.Get.find<GlobalService>().baseUrl,
        receiveDataWhenStatusError: true));
  }

  initialbackgroud() {
    dioBackgroud =
        Dio(BaseOptions(baseUrl: urlbase, receiveDataWhenStatusError: true));
  }

  static Future<Response> postData({dynamic data, required String path}) async {
    print(data);
    gt.Get.log(dio.options.baseUrl + path);
    return await dio.post<Map<String, dynamic>>(path, data: data);
  }

  Future<bool> postDataBackgroud({dynamic data, required String path}) async {
    gt.Get.log(urlbase + path);
    var respons =
        await dioBackgroud.post<Map<String, dynamic>>(path, data: data);
    if (respons.data!['state']) {
      return true;
    } else {
      return false;
    }
  }

  static Future<Response> getData({required String path}) async {
    gt.Get.log(dio.options.baseUrl + path);
    return await dio.get<Map<String, dynamic>>(
      path,
    );
  }

  static Future<Response> getDataById(
      {required String path,
      required Map<String, dynamic> queryParameters}) async {
    gt.Get.log(dio.options.baseUrl + path);
    return await dio.get<Map<String, dynamic>>(path,
        queryParameters: queryParameters);
  }

  static Future<Response> downloadFile(String path) async {
    final dioDwomload = Dio(BaseOptions(
        responseType: ResponseType.bytes, receiveDataWhenStatusError: true));

    return await dioDwomload.get(
      path,
    );
  }
}
