import 'package:bus_tracker/core/error/failures.dart';
import 'package:bus_tracker/core/usecase/usecase.dart';
import 'package:bus_tracker/features/trip_tracking/domain/entities/trip.dart';
import 'package:bus_tracker/features/trip_tracking/domain/repositories/trip_tracking_repository.dart';
import 'package:dartz/dartz.dart';

class GetActiveTrip implements UseCase<TripEntity, NoParams>{
  final TripTrackingRepository repository;

  GetActiveTrip(this.repository);

  @override
  Future<Either<Failure, TripEntity>> call(NoParams params) {
    return repository.getActiveTrip();
  }

}