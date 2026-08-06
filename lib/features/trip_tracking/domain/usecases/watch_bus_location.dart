import 'package:bus_tracker/core/error/failures.dart';
import 'package:bus_tracker/features/trip_tracking/domain/entities/bus_location.dart';
import 'package:bus_tracker/features/trip_tracking/domain/repositories/trip_tracking_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class WatchBusLocationParams extends Equatable {
  final int tripId;

  const WatchBusLocationParams(this.tripId);

  @override
  List<Object?> get props => [tripId];
}

class WatchBusLocation {
  final TripTrackingRepository repository;

  WatchBusLocation(this.repository);

  Stream<Either<Failure, BusLocationEntity>> call(
    WatchBusLocationParams params,
  ) {
    return repository.watchBusLocation(params.tripId);
  }
}
