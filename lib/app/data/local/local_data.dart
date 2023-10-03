class DataConst {
//   GlobalService globalService = Get.put(GlobalService());
//   //api laravel

//   static String baseUrl = Get.find<GlobalService>().baseUrl;
// //  static String baseUrl = 'http://10.0.2.2:5588/projectTravel/public/api/v1/';

  static const String comme = ' : ';

  static const channelUpdataState = 'public-updataRequestCustomer';
  static const channelCustomeServices = 'public-CustomeServices';
  static const channelDataInput = 'public-DataInputNotification';
  static const channelCustomeUser = 'public-CustomUser';
  static const channelNotification = 'public-Notiification';
  static const channelChat = 'public-Chat';
  static const channelChatService = 'channel-MwssageCustumer';
}

class UntilHelper {
  static RegExp onlynumberReq = RegExp(r'^\d+\.?\d{0,2}');
}
