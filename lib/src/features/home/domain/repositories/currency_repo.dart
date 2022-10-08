import 'package:currency_converter/src/core/error/failures.dart';
import 'package:currency_converter/src/features/home/domain/entites/currency_converter_entity.dart';
import 'package:currency_converter/src/features/home/domain/entites/currency_historical_entity.dart';
import 'package:dartz/dartz.dart';

import '../entites/currency_entity.dart';

abstract class CurrencyRepo {
  Future<Either<Failure, CurrencyEntity>> getLatestData({bool? useCachedData});
  Future<Either<Failure, CurrencyHistoricalEntity>> getHistoricalData(
      {bool? useCachedData});
  Future<Either<Failure, CurrencyConverterEntity>> getCurrencyConverterData(
      {required String amount, required String from, required String to});
}
