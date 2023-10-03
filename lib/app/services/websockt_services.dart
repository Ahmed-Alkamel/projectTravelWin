import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Helper/websocket_helper.dart';
import '../data/local/local_data.dart';

class WebsocketBaseClassServices extends GetxService {
  WebSocketChannel? channal;

  StreamController streamController = StreamController();

  bool get isConnected {
    if (channal == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<WebsocketBaseClassServices> connect(SubsicrubeChannel type) async {
    channal = WebsocketChannalHelper.init();
    switch (type) {
      case SubsicrubeChannel.updateState:
        {
          await subscribeWithChannelSpecific(ConfigeSubsucribeWebSocker(
              data: {'channel': DataConst.channelUpdataState},
              event: 'pusher:subscribe'));
        }
        return this;
      case SubsicrubeChannel.notification:
        {
          await subscribeWithChannelSpecific(ConfigeSubsucribeWebSocker(
              data: {'channel': DataConst.channelNotification},
              event: 'pusher:subscribe'));
          return this;
        }

      case SubsicrubeChannel.channelDataInput:
        {
          await subscribeWithChannelSpecific(ConfigeSubsucribeWebSocker(
              data: {'channel': DataConst.channelDataInput},
              event: 'pusher:subscribe'));
          return this;
        }
      case SubsicrubeChannel.channelCustomeUser:
        {
          await subscribeWithChannelSpecific(ConfigeSubsucribeWebSocker(
              data: {'channel': DataConst.channelCustomeUser},
              event: 'pusher:subscribe'));
          return this;
        }
      case SubsicrubeChannel.channelChat:
        {
          await subscribeWithChannelSpecific(ConfigeSubsucribeWebSocker(
              data: {'channel': DataConst.channelChat},
              event: 'pusher:subscribe'));
          return this;
        }
      case SubsicrubeChannel.channalChatServicer:
        {
          await subscribeWithChannelSpecific(ConfigeSubsucribeWebSocker(
              data: {'channel': DataConst.channelChatService},
              event: 'pusher:subscribe'));
          return this;
        }

      case SubsicrubeChannel.all:
        {
          if (!isConnected) {
            await subscribeWithChannelSpecific(ConfigeSubsucribeWebSocker(
                data: {'channel': DataConst.channelCustomeServices},
                event: 'pusher:subscribe'));
            await subscribeWithChannelSpecific(ConfigeSubsucribeWebSocker(
                data: {'channel': DataConst.channelDataInput},
                event: 'pusher:subscribe'));
            await subscribeWithChannelSpecific(ConfigeSubsucribeWebSocker(
                data: {'channel': DataConst.channelCustomeUser},
                event: 'pusher:subscribe'));
            await subscribeWithChannelSpecific(ConfigeSubsucribeWebSocker(
                data: {'channel': DataConst.channelChat},
                event: 'pusher:subscribe'));
          }
          return this;
        }
      default:
        {
          return this;
        }
    }
  }

  Future<void> subscribeWithChannelSpecific(
      ConfigeSubsucribeWebSocker configeSubsucribe) async {
    if (isConnected) {
      channal!.sink.add(json.encode(configeSubsucribe.toMap()));
    }
  }

  Stream? listenToEventSpecific(String event, int id) {
    StreamController specific = StreamController();
    int? idRec;
    if (isConnected) {
      channal!.stream.listen((message) async {
        final data = json.decode(message);
        var dataMessage = data['data'];
        // print(dataMessage);
        if (data['event'] == event) {
          if (dataMessage != null) {
            dataMessage = json.decode(dataMessage);
            idRec = dataMessage['id'] as int;
            if (idRec! == id) {
              specific.add(dataMessage['info']);
              // channal!.sink.add(json.encode({
              //   // "event": "pusher:ping",

              //   // "data": {'identifier': 1}
              //   'event': 'event-received',
              //   'identifier': 1,
              // }));
            }
          }
        }
      });
      return specific.stream;
    } else {
      return null;
    }
  }

  StreamController? listenToEventSpecificWithConstrant(String event) {
    StreamController specific = StreamController();
    int? idRec;
    if (isConnected) {
      channal!.stream.listen((message) async {
        final data = json.decode(message);
        var dataMessage = data['data'];
        // print(dataMessage);
        if (data['event'] == event) {
          if (dataMessage != null) {
            dataMessage = json.decode(dataMessage);
            // idRec = dataMessage['id'] as int;
            // if (idRec! == id) {
            specific.add(dataMessage['info']);
            // channal!.sink.add(json.encode({
            //   // "event": "pusher:ping",

            //   // "data": {'identifier': 1}
            //   'event': 'event-received',
            //   'identifier': 1,
            // }));
            // }
          }
        }
      });
      return specific;
    } else {
      return null;
    }
  }

  closeChannal() async {
    if (isConnected) {
      await channal!.sink.close();
    }
  }

  Stream get data => streamController.stream;
}
