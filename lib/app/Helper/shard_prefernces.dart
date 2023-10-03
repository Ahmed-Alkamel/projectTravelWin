import 'package:shared_preferences/shared_preferences.dart';

class ShardHelpar {
  static late SharedPreferences shard;

  static init() async {
    shard = await SharedPreferences.getInstance();
  }
}
