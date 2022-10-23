import 'dart:async';
import 'dart:convert';

import 'package:ws_poker_planning_app/features/home/service/poker.planning.service.model.dart';
import 'package:ws_poker_planning_app/service.locator.dart';
import 'package:ws_poker_planning_app/services/logger/logger.service.dart';
import 'package:ws_poker_planning_app/services/websocket/websocket.service.dart';

class PokerPlanningService {
  final LoggerService logger = serviceLocator.get();
  final WebSocketService webSocketService = serviceLocator.get();
  final StreamController<PokerPlanningSession> _streamController = StreamController<PokerPlanningSession>();

  Stream<PokerPlanningSession> get stream => _streamController.stream;

  void startSession({required String hostname, required String roomUUID, required bool isSecure}) {
    Uri uri = buildWebSocketURI(hostname, roomUUID, isSecure);

    webSocketService.openConnection(uri);
    webSocketService.streamController.stream.listen((data) {
      Map<String, dynamic> dataMap = jsonDecode(data);
      PokerPlanningSession session = PokerPlanningSession.fromJson(dataMap);
      _streamController.sink.add(session);
    });
  }

  void stopSession() {
    webSocketService.closeConnection();
    _streamController.sink.close();
  }

  Uri buildWebSocketURI(String hostname, String roomUUID, bool isSecure) {
    final String protocol = isSecure ? 'wss' : 'ws';
    final String uri = '$protocol://$hostname/ws?roomUUID=$roomUUID';
    return Uri.parse(uri);
  }

  void sendMessage() {
    String jsonData = '{"type":"vote","payload":{"username":"Andre-Flutter-Guy"}}';
    webSocketService.sendData(jsonData);
  }
}
