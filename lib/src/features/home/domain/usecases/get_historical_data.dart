import 'package:currency_converter/src/features/home/domain/entites/currency_historical_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/currency_repo.dart';

class GetHistoricalData {
  final CurrencyRepo repo;

  GetHistoricalData(this.repo);

  Future<Either<Failure, CurrencyHistoricalEntity>> call({bool? useCachedData}) async =>
      await repo.getHistoricalData(useCachedData: useCachedData);
}
