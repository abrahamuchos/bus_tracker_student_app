import 'package:equatable/equatable.dart';

class RouteEntity extends Equatable {
  final int id;
  final String name;
  final String polylineEncoded;
  final double originLat;
  final double originLng;
  final double destinationLat;
  final double destinationLnt;

  const RouteEntity({
    required this.id,
    required this.name,
    required this.polylineEncoded,
    required this.originLat,
    required this.originLng,
    required this.destinationLat,
    required this.destinationLnt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    polylineEncoded,
    originLat,
    originLng,
    destinationLat,
    destinationLnt,
  ];
}
