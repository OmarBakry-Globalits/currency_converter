import 'package:currency_converter/src/features/home/domain/repositories/currency_repo.dart';
import 'package:currency_converter/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../entites/currency_entity.dart';

class GetLatestDataUseCase {
  final CurrencyRepo repo;

  GetLatestDataUseCase(this.repo);

  Future<Either<Failure, CurrencyEntity>> call({bool? useCachedData}) async =>
      await repo.getLatestData(useCachedData: useCachedData);
}
