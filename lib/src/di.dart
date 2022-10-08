import 'package:currency_converter/src/core/network/network_info.dart';
import 'package:currency_converter/src/features/home/data/repositories/currency_repo_impl.dart';
import 'package:currency_converter/src/features/home/data/source/local_source.dart';
import 'package:currency_converter/src/features/home/data/source/remote_source.dart';
import 'package:currency_converter/src/features/home/domain/repositories/currency_repo.dart';
import 'package:currency_converter/src/features/home/domain/usecases/get_converted_data.dart';
import 'package:currency_converter/src/features/home/domain/usecases/get_historical_data.dart';
import 'package:currency_converter/src/features/home/domain/usecases/get_latest_data.dart';
import 'package:currency_converter/src/features/home/presentation/bloc/currency/currency_cubit.dart';
import 'package:currency_converter/src/features/home/presentation/bloc/currency_converter/currency_converter_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
// BLOC
  sl.registerFactory(() => CurrencyCubit(getLatestData: sl(),getHistoricalData: sl()));
   sl.registerFactory(() => CurrencyConverterCubit(getConvertedData: sl()));

// UseCase
  sl.registerLazySingleton(() => GetLatestDataUseCase(sl()));
  sl.registerLazySingleton(() => GetHistoricalData(sl()));
  sl.registerLazySingleton(() => GetConvertedData(sl()));

// repo
  sl.registerLazySingleton<CurrencyRepo>(() =>
      CurrencyRepoImpl(localLogic: sl(), remoteLogic: sl(), networkInfo: sl()));

  sl.registerLazySingleton<CurrencyLocalDataSourceImpl>(
      () => CurrencyLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<RemoteSourceDataImpl>(() => RemoteSourceDataImpl());
// Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

// Plugins
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
