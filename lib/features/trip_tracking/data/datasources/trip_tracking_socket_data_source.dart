import 'dart:async';
import 'dart:convert';

import 'package:bus_tracker/core/constants/api_constants.dart';
import 'package:bus_tracker/core/error/exceptions.dart';
import 'package:bus_tracker/features/trip_tracking/data/models/bus_location_model.dart';
import 'package:pusher_client_socket/pusher_client_socket.dart';

abstract class TripTrackingSocketDataSource {
  Stream<BusLocationModel> watchBusLocation(int tripId);

  Future<void> stopWatching();
}

class TripTrackingSocketDataSourceImpl extends TripTrackingSocketDataSource {
  PusherClient? _client;
  Channel? _channel;
  StreamController<BusLocationModel>? _controller;

  @override
  Future<void> stopWatching() async{
    _channel?.unsubscribe();
    _client?.disconnect();
    await _controller?.close();
    _channel = null;
    _client = null;
    _controller = null;
  }

  @override
  Stream<BusLocationModel> watchBusLocation(int tripId) {
    _controller = StreamController<BusLocationModel>.broadcast(
      onCancel: () => stopWatching,
    );

    _connect(tripId);

    return _controller!.stream;
  }

  Future<void> _connect(int tripId) async {
    try {
      final options = PusherOptions(
        key: ApiConstants.reverbAppKey,
        host: ApiConstants.reverbHost,
        wsPort: ApiConstants.reverbPort,
        encrypted: ApiConstants.reverbUseTLS,
        autoConnect: false,
        authOptions: PusherAuthOptions(
          // No se usa: 'bus.{trip_id}' es un canal público.
          // Se deja apuntando a un endpoint válido de tu API por si en el
          // futuro se agrega canales privados con auth.
          '${ApiConstants.baseUrl}/broadcasting/auth',
        ),
      );

      final client = PusherClient(options: options);

      _client = client;

      client.onConnectionError((error) {
        _controller?.addError(WebSocketException(error.toString()));
      });

      client.onError((error) {
        _controller?.addError(WebSocketException(error.toString()));
      });

      client.connect();

      final channel = client.channel('bus.$tripId');
      _channel = channel;

      channel.bind('location.updated', _handleEvent);
    } catch (e) {
      _controller?.addError(WebSocketException(e.toString()));
    }
  }

  void _handleEvent(dynamic data) {
    try {
      final Map<String, dynamic> json =
          data is String
              ? jsonDecode(data) as Map<String, dynamic>
              : data as Map<String, dynamic>;
      _controller?.add(BusLocationModel.fromJson(json));

    } catch (e) {
      _controller?.addError(WebSocketException('Invalid payload: $e'));
    }
  }
}
