import 'package:bus_tracker/features/trip_tracking/data/models/route_model.dart';
import 'package:bus_tracker/features/trip_tracking/domain/entities/trip.dart';

class TripModel extends TripEntity {
  const TripModel({
    required super.id,
    required super.busPlate,
    required super.status,
    required super.route,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] as int,
      busPlate: json['busPlate'] as String,
      status: json['status'] == 'active' ? TripStatus.active : TripStatus.finished,
      route: RouteModel.fromJson(json['route'] as Map<String, dynamic>),
    );
  }
}
