import 'package:currency_converter/src/core/error/failures.dart';
import 'package:currency_converter/src/core/network/network_info.dart';
import 'package:currency_converter/src/features/home/data/repositories/currency_repo_impl.dart';
import 'package:currency_converter/src/features/home/data/source/local_source.dart';
import 'package:currency_converter/src/features/home/data/source/remote_source.dart';
import 'package:currency_converter/src/features/home/domain/entites/currency_converter_entity.dart';
import 'package:currency_converter/src/features/home/domain/entites/currency_entity.dart';
import 'package:currency_converter/src/features/home/domain/entites/currency_historical_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:currency_converter/src/di.dart' as di;

class MockRepoSource extends Mock implements CurrencyRepoImpl {}

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //* To avoid the CustomDialog error.
  await di.init();
//---
  final MockRepoSource mockRepoSource = MockRepoSource();
  final CurrencyRepoImpl currencyRepoImpl = CurrencyRepoImpl(
    localLogic: di.sl<CurrencyLocalDataSourceImpl>(),
    currencyRepoImpl: mockRepoSource,
    networkInfo: di.sl<NetworkInfo>(),
    remoteLogic: di.sl<RemoteSourceDataImpl>(),
  );

  group('DATA_REPO_TEST', () {
    test('repo_getLatestData', () async {
      when(() => mockRepoSource.getLatestData()).thenAnswer((invocation) =>
          Future.value(Either.cond(() => false, () => const CurrencyEntity(),
              () => ServerFailure())));

      expect(
          await currencyRepoImpl.getLatestData(),
          Either.cond(() => false, () => const CurrencyEntity(),
              () => ServerFailure()));
    });

    test('repo_getHistoricalData', () async {
      when(() => mockRepoSource.getHistoricalData()).thenAnswer((invocation) =>
          Future.value(Either.cond(() => false,
              () => const CurrencyHistoricalEntity(), () => ServerFailure())));

      expect(
          await currencyRepoImpl.getHistoricalData(),
          Either.cond(() => false, () => const CurrencyHistoricalEntity(),
              () => ServerFailure()));
    });
    test('repo_getCurrencyConverterData', () async {
      when(() => mockRepoSource.getCurrencyConverterData(
              amount: '5', from: 'USD', to: 'EGP'))
          .thenAnswer((invocation) => Future.value(Either.cond(() => false,
              () => const CurrencyConverterEntity(), () => ServerFailure())));

      expect(
          await currencyRepoImpl.getCurrencyConverterData(
              amount: '5', from: 'USD', to: 'EGP'),
          Either.cond(() => false, () => const CurrencyConverterEntity(),
              () => ServerFailure()));
    });
  });
}
