import 'package:bus_tracker/features/trip_tracking/domain/entities/route.dart';
import 'package:equatable/equatable.dart';

enum TripStatus { active, finished }

class TripEntity extends Equatable{
  final int id;
  final String busPlate;
  final TripStatus status;
  final RouteEntity route;

  const TripEntity({
    required this.id,
    required this.busPlate,
    required this.status,
    required this.route
  });

  @override
  List<Object?> get props => [id, busPlate, status, route];

}