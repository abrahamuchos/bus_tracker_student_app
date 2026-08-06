import 'package:equatable/equatable.dart';

class BusLocationEntity extends Equatable {
  final int tripId;
  final double lat;
  final double lng;
  final DateTime recordedAt;

  const BusLocationEntity({
    required this.tripId,
    required this.lat,
    required this.lng,
    required this.recordedAt,
  });

  @override
  List<Object?> get props => [tripId, lat, lng, recordedAt];
}
