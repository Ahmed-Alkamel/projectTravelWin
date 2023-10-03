// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

enum SubsicrubeChannel {
  notification,
  updateState,
  channelDataInput,
  channelCustomeUser,
  channelChat,
  channalChatServicer,
  all,
  no,
}

class WebsocketChannalHelper {
  // static Uri url = Uri.parse('ws://10.0.2.2:6001/app/ProjectTravel_key');
  static Uri url = Uri.parse('ws://localhost:6001/app/ProjectTravel_key');
  // static Uri url = Uri.parse('ws://192.168.137.1:6001/app/ProjectTravel_key');
  // static Uri url = Uri.parse('ws://192.168.207.26:6001/app/ProjectTravel_key');
  static WebSocketChannel? channal;

  static WebSocketChannel? init() {
    try {
      return WebSocketChannel.connect(url);
    } catch (e) {
      if (e is WebSocketChannelException) {
        // print(e.message);
      }
      return null;
    }
  }

  static Stream read() {
    if (channal != null) {
      return channal!.stream;
    } else {
      return Stream.periodic(const Duration(seconds: 6));
    }
  }
}

class ConfigeSubsucribeWebSocker {
  final String event;
  final Map<String, dynamic> data;
  ConfigeSubsucribeWebSocker({
    required this.event,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'event': event,
      'data': data,
    };
  }

  factory ConfigeSubsucribeWebSocker.fromMap(Map<String, dynamic> map) {
    return ConfigeSubsucribeWebSocker(
        event: map['event'] as String,
        data: Map<String, dynamic>.from(
          (map['data'] as Map<String, dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory ConfigeSubsucribeWebSocker.fromJson(String source) =>
      ConfigeSubsucribeWebSocker.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

// class WebSocketHelper {
//   final String url;
//   late WebSocketChannel _channel;
//   dynamic _subscriptions;
//   StreamController _streamController = StreamController();
//   WebSocketHelper(this.url) {
//     // _connect();
//   }

//   void connect() {
//     _channel = WebSocketChannel.connect(Uri.parse(url));
//     // _channel.stream.listen(_handleMessage);
//   }

//   dynamic _handleMessage(dynamic message) {
//     return json.decode(message);
//   }

//   void subscribe(ConfigeSubsucribeWebSocker key, String event) {
//     _sendSubscription(key);

//     _channel.stream.listen((event) {
// // if()
//       var data = _handleMessage(event);
//       var dataMessage = data['data'];
//       if (data['event'] == event) {
//         if (dataMessage != null) {
//           dataMessage = json.decode(dataMessage);
//           if (dataMessage['id'] == '1') {
//             _streamController.add(event);
//           }
//         } else {}
//       } else {}
//     });
//   }

//   Stream get data => _streamController.stream;
//   void unsubscribe(ConfigeSubsucribeWebSocker key) {
//     _subscriptions.remove(key);
//     _sendUnsubscription(key);
//   }

//   void _sendSubscription(ConfigeSubsucribeWebSocker key) {
//     _channel.sink.add(json.encode(key.toMap()));
//   }

//   void _sendUnsubscription(ConfigeSubsucribeWebSocker key) {
//     _channel.sink.close();
//   }

//   void close() {
//     _channel.sink.close();
//   }
// }
