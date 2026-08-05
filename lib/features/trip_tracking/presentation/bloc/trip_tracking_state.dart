import 'package:bus_tracker/features/trip_tracking/domain/entities/BusLocationEntity.dart';
import 'package:bus_tracker/features/trip_tracking/domain/entities/trip.dart';
import 'package:equatable/equatable.dart';

enum TripTrackingStatus { initial, loading, trackingActive, failure }

class TripTrackingState extends Equatable {
  final TripTrackingStatus status;
  final TripEntity? trip;
  final BusLocationEntity? busLocation;
  final String? errorMessage;
  final bool isReconnecting;

  const TripTrackingState({
    this.status = TripTrackingStatus.initial,
    this.trip,
    this.busLocation,
    this.errorMessage,
    this.isReconnecting = false,
  });

  TripTrackingState copyWith({
    TripTrackingStatus? status,
    TripEntity? trip,
    BusLocationEntity? busLocation,
    String? errorMessage,
    bool? isReconnecting,
  }) {
    return TripTrackingState(
      status: status ?? this.status,
      trip: trip ?? this.trip,
      busLocation: busLocation ?? this.busLocation,
      errorMessage: errorMessage ?? this.errorMessage,
      isReconnecting: isReconnecting ?? this.isReconnecting
    );
  }

  @override
  List<Object?> get props => [
    status,
    trip,
    busLocation,
    errorMessage,
    isReconnecting,
  ];
}
