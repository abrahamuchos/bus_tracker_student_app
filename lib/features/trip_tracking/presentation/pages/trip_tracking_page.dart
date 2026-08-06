import 'package:bus_tracker/features/trip_tracking/presentation/bloc/trip_tracking_bloc.dart';
import 'package:bus_tracker/features/trip_tracking/presentation/bloc/trip_tracking_event.dart';
import 'package:bus_tracker/features/trip_tracking/presentation/bloc/trip_tracking_state.dart';
import 'package:bus_tracker/features/trip_tracking/presentation/utils/polyline_decoder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bus_tracker/core/di/injection_container.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripTrackingPage extends StatelessWidget {
  const TripTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TripTrackingBloc>()..add(const TripTrackingStarted()),
      child: const _TripTrackingView(),
    );
  }
}


class _TripTrackingView extends StatefulWidget {
  const _TripTrackingView({super.key});

  @override
  State<_TripTrackingView> createState() => _TripTrackingViewState();
}

class _TripTrackingViewState extends State<_TripTrackingView> {
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bus Tracker')),
      body: BlocConsumer<TripTrackingBloc, TripTrackingState>(
        listener: (context, state) {
          final bus = state.busLocation;
          if (bus != null && _mapController != null) {
            _mapController!.animateCamera(
              CameraUpdate.newLatLng(LatLng(bus.lat, bus.lng)),
            );
          }
        },
        builder: (context, state) {
          if (state.status == TripTrackingStatus.initial ||
              state.status == TripTrackingStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.trip == null) {
            return Center(
              child: Text(state.errorMessage ?? 'No hay un bus activo ahora mismo'),
            );
          }

          final trip = state.trip!;
          final route = trip.route;
          final routePoints = PolylineDecoder.decode(route.polylineEncoded);
          final bus = state.busLocation;

          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(route.originLat, route.originLng),
                  zoom: 14,
                ),
                onMapCreated: (controller) => _mapController = controller,
                polylines: {
                  Polyline(
                    polylineId: const PolylineId('route'),
                    points: routePoints,
                    color: Colors.blueAccent,
                    width: 4,
                  ),
                },
                markers: {
                  Marker(
                    markerId: const MarkerId('origin'),
                    position: LatLng(route.originLat, route.originLng),
                    infoWindow: InfoWindow(title: route.originName),
                  ),
                  Marker(
                    markerId: const MarkerId('destination'),
                    position: LatLng(route.destinationLat, route.destinationLng),
                    infoWindow: InfoWindow(title: route.destinationName),
                  ),
                  if (bus != null)
                    Marker(
                      markerId: const MarkerId('bus'),
                      position: LatLng(bus.lat, bus.lng),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueAzure,
                      ),
                      infoWindow: InfoWindow(title: 'Bus ${trip.busPlate}'),
                    ),
                },
              ),
              if (state.isReconnecting)
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Material(
                    color: Colors.orange.shade700,
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Text(
                        'Reconectando con el bus...',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
