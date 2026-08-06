class ServerException implements Exception{
  final String message;

  ServerException([this.message = 'A server error has occurred']);
}

class CacheException implements Exception{
  final String message;

  CacheException([this.message = 'A local cache error has occurred']);
}

class WebSocketException implements Exception {
  final String message;
  WebSocketException([this.message = 'Error on WebSocket']);
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Error on network']);
}