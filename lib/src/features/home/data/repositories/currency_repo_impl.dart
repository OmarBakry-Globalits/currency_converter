import 'package:currency_converter/src/core/error/exceptions.dart';
import 'package:currency_converter/src/core/network/network_info.dart';
import 'package:currency_converter/src/features/home/data/models/currency_model.dart';
import 'package:currency_converter/src/core/error/failures.dart';
import 'package:currency_converter/src/features/home/domain/entites/currency_converter_entity.dart';
import 'package:currency_converter/src/features/home/domain/entites/currency_historical_entity.dart';
import 'package:currency_converter/src/features/home/domain/repositories/currency_repo.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entites/currency_entity.dart';
import '../models/currency_converter_model.dart';
import '../models/currency_historical_model.dart';
import '../source/local_source.dart';
import '../source/remote_source.dart';

class CurrencyRepoImpl implements CurrencyRepo {
  final CurrencyLocalDataSourceImpl localLogic;
  final RemoteSourceDataImpl remoteLogic;
  final NetworkInfo networkInfo;
  CurrencyRepoImpl({
    required this.localLogic,
    required this.remoteLogic,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CurrencyEntity>> getLatestData(
      {bool? useCachedData = false}) async {
    if (useCachedData != null && useCachedData) {
      return _useCachedData();
    }
    if (await networkInfo.isConnected) {
      try {
        final CurrencyModel currencyModel = await remoteLogic.getLatestData();
        localLogic.cacheData(currencyModel.rates!);
        return Right(currencyModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return _useCachedData();
    }
  }

  Future<Either<Failure, CurrencyEntity>> _useCachedData() async {
    try {
      final Map<String, dynamic>? localRates =
          await localLogic.getCachedData(false);
      return Right(CurrencyModel(rates: localRates));
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  Future<Either<Failure, CurrencyHistoricalEntity>>
      _useCachedHistoricalData() async {
    try {
      final Map<String, dynamic>? localRates =
          await localLogic.getCachedData(true);
      return Right(CurrencyHistoricalModel(rates: localRates));
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, CurrencyHistoricalEntity>> getHistoricalData(
      {bool? useCachedData = false}) async {
    if (useCachedData != null && useCachedData) {
      return _useCachedHistoricalData();
    }
    if (await networkInfo.isConnected) {
      try {
        final CurrencyHistoricalModel currencyModel =
            await remoteLogic.getHistoricalData();
        localLogic.cacheData(currencyModel.rates!, historicalData: true);
        return Right(currencyModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return _useCachedHistoricalData();
    }
  }

  @override
  Future<Either<Failure, CurrencyConverterEntity>> getCurrencyConverterData( {required String amount,
      required String from,
      required String to}) async{
    if (await networkInfo.isConnected) {
      try {
        final CurrencyConverterModel currencyModel =
            await remoteLogic.getCurrencyConverterData(amount: amount, from: from, to: to);
        return Right(currencyModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
