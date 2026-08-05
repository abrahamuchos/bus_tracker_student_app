import 'dart:async';

import 'package:bus_tracker/core/error/exceptions.dart';
import 'package:bus_tracker/core/error/failures.dart';
import 'package:bus_tracker/core/network/network_info.dart';
import 'package:bus_tracker/features/trip_tracking/data/datasources/trip_tracking_remote_data_source.dart';
import 'package:bus_tracker/features/trip_tracking/data/datasources/trip_tracking_socket_data_source.dart';
import 'package:bus_tracker/features/trip_tracking/domain/entities/BusLocationEntity.dart';
import 'package:bus_tracker/features/trip_tracking/domain/entities/trip.dart';
import 'package:bus_tracker/features/trip_tracking/domain/repositories/trip_tracking_repository.dart';
import 'package:dartz/dartz.dart';

class TripTrackingRepositoryImpl implements TripTrackingRepository {
  final TripTrackingRemoteDataSource remoteDataSource;
  final TripTrackingSocketDataSource socketDataSource;
  final NetworkInfo networkInfo;

  TripTrackingRepositoryImpl( {
    required this.remoteDataSource,
    required this.socketDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, TripEntity>> getActiveTrip() async{
    if(!await networkInfo.isConnected){
      return const Left(NetworkFailure());
    }

    try{
      final trip = await remoteDataSource.getActiveTrip();
      return Right(trip);
    }on ServerException catch(e){
      return Left(ServerFailure(e.message));
    }on NetworkException catch(e){
      return Left(NetworkFailure(e.message));
    }

  }

  @override
  Future<void> stopWatching() => socketDataSource.stopWatching();

  @override
  Stream<Either<Failure, BusLocationEntity>> watchBusLocation(int tripId) {
    final controller = StreamController<Either<Failure, BusLocationEntity>>();

    final subscription = socketDataSource.watchBusLocation(tripId).listen(
          (location) => controller.add(Right(location)),
      onError: (error) {
        final message = error is WebSocketException ? error.message : error.toString();
        controller.add(Left(WebSocketFailure(message)));
      },
      onDone: () => controller.close(),
    );

    controller.onCancel = () {
      subscription.cancel();
      socketDataSource.stopWatching();
    };

    return controller.stream;
  }
}
