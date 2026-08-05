import 'package:bus_tracker/core/constants/api_constants.dart';
import 'package:bus_tracker/core/network/network_info.dart';
import 'package:bus_tracker/features/trip_tracking/data/datasources/trip_tracking_api.dart';
import 'package:bus_tracker/features/trip_tracking/data/datasources/trip_tracking_remote_data_source.dart';
import 'package:bus_tracker/features/trip_tracking/data/datasources/trip_tracking_socket_data_source.dart';
import 'package:bus_tracker/features/trip_tracking/data/repositories/trip_tracking_repository_impl.dart';
import 'package:bus_tracker/features/trip_tracking/domain/repositories/trip_tracking_repository.dart';
import 'package:bus_tracker/features/trip_tracking/domain/usecases/get_active_trip.dart';
import 'package:bus_tracker/features/trip_tracking/domain/usecases/watch_bus_location.dart';
import 'package:bus_tracker/features/trip_tracking/presentation/bloc/trip_tracking_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // --- Features trip_tracking ---

  //Data sources
  sl.registerLazySingleton<TripTrackingRemoteDataSource>(
    () => TripTrackingRemoteDataSourceImpl(sl()), // recibe TripTrackingApi
  );
  sl.registerLazySingleton<TripTrackingSocketDataSource>(
    () => TripTrackingSocketDataSourceImpl(),
  );

  //Repository
  sl.registerLazySingleton<TripTrackingRepository>(
    () => TripTrackingRepositoryImpl(
      remoteDataSource: sl(),
      socketDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //Use case
  sl.registerLazySingleton(() => GetActiveTrip(sl()));
  sl.registerLazySingleton(() => WatchBusLocation(sl()));

  //Retrofit client
  sl.registerLazySingleton<TripTrackingApi>(
    () => TripTrackingApi(sl(), baseUrl: ApiConstants.baseUrl),
  );

  //Bloc
  sl.registerFactory(
    () => TripTrackingBloc(
      getActiveTrip: sl(),
      watchBusLocation: sl(),
      repository: sl(),
    ),
  );

  // --- Core ---
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // --- External ---
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
}
