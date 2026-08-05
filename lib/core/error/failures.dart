import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Not internet connection']);
}

class WebSocketFailure extends Failure {
  const WebSocketFailure([super.message = 'Error in WebSocket']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Error in Local Cache']);
}