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
    final Map<String, dynamic> data =
        json.containsKey('data') ? json['data'] as Map<String, dynamic> : json;

    return TripModel(
      id: data['id'] as int,
      busPlate: data['busPlate'] as String,
      status:
          data['status'] == 'active' ? TripStatus.active : TripStatus.finished,
      route: RouteModel.fromJson(data['route'] as Map<String, dynamic>),
    );
  }
}
