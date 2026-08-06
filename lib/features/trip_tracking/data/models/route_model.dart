import 'package:bus_tracker/core/utils/parsers.dart';
import 'package:bus_tracker/features/trip_tracking/domain/entities/route.dart';

class RouteModel extends RouteEntity {
  const RouteModel({
    required super.id,
    required super.name,
    required super.polylineEncoded,
    required super.originLat,
    required super.originLng,
    required super.destinationLat,
    required super.destinationLng,
    super.destinationName,
    super.originName,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data =
    json.containsKey('data') ? json['data'] as Map<String, dynamic> : json;

    final origin = data['origin'] as Map<String, dynamic>;
    final destination = data['destination'] as Map<String, dynamic>;

    return RouteModel(
      id: data['id'] as int,
      name: data['name'] as String,
      polylineEncoded: data['polylineEncoded'] as String,
      originName: origin['name'] as String?,
      originLat: Parsers.toDouble(origin['lat']),
      originLng: Parsers.toDouble(origin['lng']),
      destinationName: destination['name'] as String?,
      destinationLat: Parsers.toDouble(destination['lat']),
      destinationLng: Parsers.toDouble(destination['lng']),
    );
  }
}

