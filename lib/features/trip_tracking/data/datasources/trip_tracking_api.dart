import 'package:bus_tracker/features/trip_tracking/data/models/trip_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'trip_tracking_api.g.dart';

@RestApi()
abstract class TripTrackingApi{
  factory TripTrackingApi(Dio dio, {String baseUrl}) = _TripTrackingApi;

  @GET('/trips/active')
  Future<TripModel> getActiveTrip();

}