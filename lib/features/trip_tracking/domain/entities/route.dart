import 'package:equatable/equatable.dart';

class RouteEntity extends Equatable {
  final int id;
  final String name;
  final String polylineEncoded;
  final String? originName;
  final double originLat;
  final double originLng;
  final String? destinationName;
  final double destinationLat;
  final double destinationLng;

  const RouteEntity({
    required this.id,
    required this.name,
    required this.polylineEncoded,
    required this.originLat,
    required this.originLng,
    required this.destinationLat,
    required this.destinationLng,
    this.originName,
    this.destinationName,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    polylineEncoded,
    originLat,
    originLng,
    destinationLat,
    destinationLng,
    originName,
    destinationName,
  ];
}

