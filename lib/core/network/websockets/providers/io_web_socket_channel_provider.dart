import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/io.dart';

@singleton
class IOWebSocketChannelProvider {
  IOWebSocketChannel? _ioWebSocketChannel;

  void closeSocketChannel() {
    _ioWebSocketChannel?.sink.close();
  }

  void setSocketChannel(IOWebSocketChannel? value) {
    _ioWebSocketChannel = value;
  }

  IOWebSocketChannel? getSocketChannel() => _ioWebSocketChannel;
}
