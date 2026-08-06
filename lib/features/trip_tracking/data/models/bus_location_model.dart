import 'package:bus_tracker/core/utils/parsers.dart';
import 'package:bus_tracker/features/trip_tracking/domain/entities/bus_location.dart';

class BusLocationModel extends BusLocationEntity {
  const BusLocationModel({
    required super.tripId,
    required super.lat,
    required super.lng,
    required super.recordedAt,
  });

  factory BusLocationModel.fromJson(Map<String, dynamic> json){
    return BusLocationModel(
        tripId: json['tripId'] as int,
        lat: Parsers.toDouble(json['lat']),
        lng: Parsers.toDouble(json['lng']),
        recordedAt: DateTime.parse(json['recordedAt'] as String)
    );
  }

}
