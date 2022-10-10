import 'package:currency_converter/src/core/error/exceptions.dart';
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
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockRemoteSource extends Mock implements RemoteSourceDataImpl {}

class MockRepoSource extends Mock implements CurrencyRepoImpl {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //! To avoid the dialog error.

  final MockRemoteSource mockRemoteSource = MockRemoteSource();
  final RemoteSourceDataImpl remoteSourceDataImpl =
      RemoteSourceDataImpl(remoteSourceDataImpl: mockRemoteSource);

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final CurrencyLocalDataSourceImpl localSourceDataImpl =
      CurrencyLocalDataSourceImpl(sharedPreferences: sharedPreferences);

  final MockRepoSource mockRepoSource = MockRepoSource();
  final CurrencyRepoImpl currencyRepoImpl = CurrencyRepoImpl(
      localLogic: localSourceDataImpl,
      currencyRepoImpl: mockRepoSource,
      networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
      remoteLogic: remoteSourceDataImpl);
  setUp(() {});
  tearDown(() {});

//? DATA_REPO_TEST
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

//? LOCAL_STORAGE_TEST
  group('LOCAL_STORAGE_TEST', () {
    test('set_data', () async {
      expect(await localSourceDataImpl.cacheData({'key': 'value'}), true);
    });
    test('get_data', () async {
      expect(await localSourceDataImpl.getCachedData(false), {'key': 'value'});
    });
  });
  

//? API_REMOTE_TEST
  group('API_REMOTE_TEST', () {
    test('getLatestData', () async {
      when(() => mockRemoteSource.getLatestData())
          .thenAnswer((invocation) => throw ServerException());

      expect(() async => await remoteSourceDataImpl.getLatestData(),
          throwsA(isA<ServerException>()));
    });

    test('getHistoricalData', () async {
      when(() => mockRemoteSource.getHistoricalData())
          .thenAnswer((invocation) => throw ServerException());

      expect(()async=>await remoteSourceDataImpl.getHistoricalData(),
          throwsA(isA<ServerException>()));
    });
    test('getCurrencyConverterData', () async {
      when(() => mockRemoteSource.getCurrencyConverterData(
          amount: '5',
          from: 'USD',
          to: 'EGP')).thenAnswer((invocation) => throw ServerException());

      expect(
          ()async=>await remoteSourceDataImpl.getCurrencyConverterData(
              amount: '5', from: 'USD', to: 'EGP'),
          throwsA(isA<ServerException>()));
    });
  });
}
