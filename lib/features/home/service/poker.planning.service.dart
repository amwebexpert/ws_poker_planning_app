import 'package:ws_poker_planning_app/service.locator.dart';
import 'package:ws_poker_planning_app/services/logger/logger.service.dart';
import 'package:ws_poker_planning_app/services/websocket/websocket.service.dart';

class PokerPlanningService {
  final LoggerService logger = serviceLocator.get();
  final WebSocketService webSocketService = serviceLocator.get();

  void startSession({required String hostname, required String roomUUID, required bool isSecure}) {
    Uri uri = buildWebSocketURI(hostname, roomUUID, isSecure);
    webSocketService.openConnection(uri);
  }

  Uri buildWebSocketURI(String hostname, String roomUUID, bool isSecure) {
    final String protocol = isSecure ? 'wss' : 'ws';
    final String uri = '$protocol://$hostname/ws?roomUUID=$roomUUID';
    return Uri.parse(uri);
  }

  void sendMessage() {
    webSocketService.sink?.add('{"type":"vote","payload":{"username":"Andre-Flutter-Guy"}}');
  }
}
