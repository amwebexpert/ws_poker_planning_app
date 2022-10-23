import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:ws_poker_planning_app/service.locator.dart';
import 'package:ws_poker_planning_app/services/logger/logger.service.dart';

class WebSocketService {
  final LoggerService logger = serviceLocator.get();
  final StreamController<dynamic> streamController = StreamController<dynamic>();

  Uri? _uri;
  bool shouldReconnectOnClose = true;
  WebSocketChannel? _channel;

  void openConnection(Uri uri) {
    if (_channel != null) {
      return;
    }

    logger.info('Opening connection to $uri...');
    _uri = uri;
    _channel = WebSocketChannel.connect(uri);
    _channel?.stream.listen(onData, cancelOnError: true, onDone: onDone, onError: onError);
  }

  void closeConnection() {
    shouldReconnectOnClose = false;
    _channel?.sink.close();
    _channel = null;
    streamController.sink.close();
  }

  void sendData(dynamic data) => _channel?.sink.add(data);

  void onData(dynamic data) {
    logger.info('onData: $data');
    streamController.sink.add(data);
  }

  void onDone() {
    final detail = ' ${_channel?.closeCode ?? ''} ${_channel?.closeReason ?? ''}'.trim();
    logger.info('onDone with code: $detail. Reopening connection...');
    _channel = null;
    if (shouldReconnectOnClose) {
      openConnection(_uri!);
    }
  }

  void onError(Object data, StackTrace stackTrace) {
    logger.error(data.toString(), stackTrace: stackTrace);
    onDone();
  }
}
