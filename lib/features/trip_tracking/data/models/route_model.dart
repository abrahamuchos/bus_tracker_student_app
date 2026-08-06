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
    return RouteModel(
      id: json['id'] as int,
      name: json['name'] as String,
      polylineEncoded: json['polylineEncoded'] as String,
      originName: json['origin']['name'] as String?,
      originLat: Parsers.toDouble(json['origin']['lat']),
      originLng: Parsers.toDouble(json['origin']['lng']),
      destinationName: json['destination']['name'] as String?,
      destinationLat: Parsers.toDouble(json['destination']['lat']),
      destinationLng: Parsers.toDouble(json['destination']['lng']),
    );
  }
}

