import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();

  factory SocketManager() {
    return _instance;
  }

  IO.Socket? _socket;

  SocketManager._internal();

  void connect(String url) {
    _socket =
        IO.io(url, IO.OptionBuilder().setTransports(['websocket']).build());
  }

  IO.Socket get socket => _socket!;
}
