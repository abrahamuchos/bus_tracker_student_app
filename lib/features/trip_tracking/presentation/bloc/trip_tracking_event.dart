import 'package:equatable/equatable.dart';

sealed class TripTrackingEvent extends Equatable {
  const TripTrackingEvent();

  @override
  List<Object?> get props => [];
}

/// Dispara t odo el flujo: carga el trip activo y luego
/// empieza a escuchar el WebSocket para ese trip.
class TripTrackingStarted extends TripTrackingEvent{
  const TripTrackingStarted();
}

