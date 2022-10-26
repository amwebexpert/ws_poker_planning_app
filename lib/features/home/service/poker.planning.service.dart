import 'dart:async';
import 'dart:convert';

import 'package:ws_poker_planning_app/features/home/service/poker.planning.service.model.dart';
import 'package:ws_poker_planning_app/service.locator.dart';
import 'package:ws_poker_planning_app/services/websocket/websocket.service.dart';

class PokerPlanningService {
  final WebSocketService _webSocketService = serviceLocator.get();
  final StreamController<PokerPlanningSession> _streamController = StreamController<PokerPlanningSession>();

  bool _isConnected = false;

  bool get isSessionStarted => _isConnected;
  Stream<PokerPlanningSession> get stream => _streamController.stream;

  void startSession(
      {required String hostname,
      required String roomUUID,
      required bool isSecure,
      required Function() onConnectionSuccess}) {
    final Uri uri = buildWebSocketURI(hostname, roomUUID, isSecure);

    if (_webSocketService.openConnection(uri)) {
      onConnectionSuccess();
      _isConnected = true;
    }

    _webSocketService.streamController.stream.listen((data) {
      final Map<String, dynamic> dataMap = jsonDecode(data);
      final PokerPlanningSession session = PokerPlanningSession.fromJson(dataMap);
      _streamController.sink.add(session);
    });
  }

  void stopSession() {
    _webSocketService.closeConnection();
    _streamController.sink.close();
    _isConnected = false;
  }

  Uri buildWebSocketURI(String hostname, String roomUUID, bool isSecure) {
    final String protocol = isSecure ? 'wss' : 'ws';
    final String uri = '$protocol://$hostname/ws?roomUUID=$roomUUID';
    return Uri.parse(uri);
  }

  void estimate(String username, String? estimate) {
    final bool hasEstimate = estimate != null;
    final estimatedAtISO8601 = hasEstimate ? DateTime.now().toIso8601String() : null;

    final UserEstimate userEstimate =
        UserEstimate(username: username, estimate: estimate, estimatedAtISO8601: estimatedAtISO8601);
    final UserMessage<UserEstimate> userMessage = UserMessage(type: MessageType.vote, payload: userEstimate);

    final String jsonData = jsonEncode(userMessage.toJson());
    _webSocketService.sendData(jsonData);
  }

  void remove(String username) {
    final String jsonData = jsonEncode({'type': MessageType.remove.name, 'payload': username});
    _webSocketService.sendData(jsonData);
  }

  void reset() {
    final String jsonData = jsonEncode({'type': MessageType.reset.name});
    _webSocketService.sendData(jsonData);
  }
}
