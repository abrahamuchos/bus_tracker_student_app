import 'package:bus_tracker/core/error/failures.dart';
import 'package:bus_tracker/core/usecase/usecase.dart';
import 'package:bus_tracker/features/trip_tracking/domain/entities/bus_location.dart';
import 'package:bus_tracker/features/trip_tracking/domain/repositories/trip_tracking_repository.dart';
import 'package:bus_tracker/features/trip_tracking/domain/usecases/get_active_trip.dart';
import 'package:bus_tracker/features/trip_tracking/domain/usecases/watch_bus_location.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'trip_tracking_event.dart';
import 'trip_tracking_state.dart';

class TripTrackingBloc extends Bloc<TripTrackingEvent, TripTrackingState> {
  final GetActiveTrip getActiveTrip;
  final WatchBusLocation watchBusLocation;
  final TripTrackingRepository repository; // solo para stopWatching

  TripTrackingBloc({
    required this.getActiveTrip,
    required this.watchBusLocation,
    required this.repository,
  }) : super(const TripTrackingState()) {
    on<TripTrackingStarted>(_onStarted);
  }

  Future<void> _onStarted(
      TripTrackingStarted event,
    Emitter<TripTrackingState> emit,
  ) async {
    emit(state.copyWith(status: TripTrackingStatus.loading));

    final result = await getActiveTrip(NoParams());

    await result.fold(
      (failure) async {
        emit(
          state.copyWith(
            status: TripTrackingStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (trip) async {
        emit(
          state.copyWith(status: TripTrackingStatus.trackingActive, trip: trip),
        );

        // emit.forEach mantiene vivo este handler mientras el stream emita.
        // Bloc cancela la suscripción automáticamente si el Bloc se cierra.
        await emit.forEach<Either<Failure, BusLocationEntity>>(
          watchBusLocation(WatchBusLocationParams(trip.id)),
          onData:
              (either) => either.fold(
                (failure) => state.copyWith(
                  status: TripTrackingStatus.failure,
                  errorMessage: failure.message,
                ),
                (location) => state.copyWith(
                  busLocation: location,
                  isReconnecting: false,
                  errorMessage: null,
                ),
              ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    repository.stopWatching();
    return super.close();
  }
}
