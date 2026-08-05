import 'package:bus_tracker/core/error/exceptions.dart';
import 'package:bus_tracker/features/trip_tracking/data/datasources/trip_tracking_api.dart';
import 'package:bus_tracker/features/trip_tracking/data/models/trip_model.dart';
import 'package:dio/dio.dart';

//Nota: TripTrackingApi vs TripTrackingRemoteDataSource (Para futuros eventos)
//Este es el encargado de manejar las excepciones y data de retrofit
//Es el adaptador entre esa herramienta de bajo nivel (retrofit) y mi arquitectura.
abstract class TripTrackingRemoteDataSource{
  Future<TripModel> getActiveTrip();
}

class TripTrackingRemoteDataSourceImpl implements TripTrackingRemoteDataSource{
  final TripTrackingApi api;
  TripTrackingRemoteDataSourceImpl(this.api);

  @override
  Future<TripModel> getActiveTrip() async {
    try {
      return await api.getActiveTrip();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw NetworkException();
      }
      throw ServerException(e.message ?? 'Error al obtener el trip activo');
    }
  }


}