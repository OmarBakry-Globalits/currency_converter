import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entites/currency_converter_entity.dart';
import '../repositories/currency_repo.dart';

class GetConvertedData {
  final CurrencyRepo repo;

  GetConvertedData(this.repo);

  Future<Either<Failure, CurrencyConverterEntity>> call(
          {required String amount,
          required String from,
          required String to}) async =>
      await repo.getCurrencyConverterData(amount: amount, from: from, to: to);
}
