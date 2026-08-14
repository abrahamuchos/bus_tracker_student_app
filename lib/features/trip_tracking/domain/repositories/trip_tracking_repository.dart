import 'package:bus_tracker/core/error/failures.dart';
import 'package:bus_tracker/features/trip_tracking/domain/entities/bus_location.dart';
import 'package:bus_tracker/features/trip_tracking/domain/entities/trip.dart';
import 'package:dartz/dartz.dart';

abstract class TripTrackingRepository{

  Future<Either<Failure, TripEntity>> getActiveTrip();

  Stream<Either<Failure, BusLocationEntity>> watchBusLocation(int tripId);
  
  Future<void> stopWatching();
}