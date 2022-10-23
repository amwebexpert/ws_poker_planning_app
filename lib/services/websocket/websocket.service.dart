import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:ws_poker_planning_app/service.locator.dart';
import 'package:ws_poker_planning_app/services/logger/logger.service.dart';

class WebSocketService {
  final LoggerService logger = serviceLocator.get();

  Uri? _uri;
  WebSocketChannel? _channel;
  Stream<dynamic>? stream;

  void openConnection(Uri uri) {
    if (_channel != null) {
      return;
    }

    logger.info('Opening connection to $uri...');
    _uri = uri;
    _channel = WebSocketChannel.connect(uri);
    stream = _channel?.stream.asBroadcastStream();

    stream?.listen(onData, cancelOnError: true, onDone: onDone, onError: onError);
  }

  WebSocketSink? get sink => _channel?.sink;

  void onData(data) => logger.info('onData: $data');
  void onDone() {
    logger.info('onDone. Reopening connection...');
    _channel = null;
    openConnection(_uri!);
  }

  void onError(Object data, StackTrace stackTrace) => logger.error(data.toString(), stackTrace: stackTrace);
}
