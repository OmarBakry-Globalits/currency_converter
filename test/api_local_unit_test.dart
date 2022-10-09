// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

//import 'package:currency_converter/src/app.dart';
//import 'package:currency_converter/src/core/error/failures.dart';
import 'package:currency_converter/src/features/home/data/models/currency_converter_model.dart';
import 'package:currency_converter/src/features/home/data/models/currency_historical_model.dart';
import 'package:currency_converter/src/features/home/data/models/currency_model.dart';
import 'package:currency_converter/src/features/home/data/source/local_source.dart';
import 'package:currency_converter/src/features/home/data/source/remote_source.dart';
import 'package:flutter/material.dart';
// import 'package:currency_converter/src/features/home/domain/entites/currency_entity.dart';
// import 'package:currency_converter/src/features/home/presentation/bloc/currency/currency_cubit.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:mockito/mockito.dart';

class MockRemoteSource extends Mock implements RemoteSourceDataImpl {}


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //! To avoid the dialog error.

  final MockRemoteSource mockRemoteSource = MockRemoteSource();
  final RemoteSourceDataImpl remoteSourceDataImpl =
      RemoteSourceDataImpl(remoteSourceDataImpl: mockRemoteSource);

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final CurrencyLocalDataSourceImpl localSourceDataImpl =
      CurrencyLocalDataSourceImpl(
          sharedPreferences: sharedPreferences);

  setUp(() {});
  tearDown(() {});

  group('LOCAL_STORAGE_TEST', () {
    test('set_data', () async {
      expect(await localSourceDataImpl.cacheData({'key': 'value'}), true);
    });
    test('get_data', () async {
      expect(await localSourceDataImpl.getCachedData(false),{'key': 'value'});
    });
  });

  group('API_REMOTE_TEST', () {
    test('getLatestData', () async {
      when(() => mockRemoteSource.getLatestData())
          .thenAnswer((realInvocation) => Future.value(const CurrencyModel()));

      expect(await remoteSourceDataImpl.getLatestData(), const CurrencyModel());
    });

    test('getHistoricalData', () async {
      when(() => mockRemoteSource.getHistoricalData()).thenAnswer(
          (realInvocation) => Future.value(const CurrencyHistoricalModel()));

      expect(await remoteSourceDataImpl.getHistoricalData(),
          const CurrencyHistoricalModel());
    });
    test('getCurrencyConverterData', () async {
      when(() => mockRemoteSource.getCurrencyConverterData(
              amount: '5', from: 'USD', to: 'EGP'))
          .thenAnswer(
              (realInvocation) => Future.value(CurrencyConverterModel()));

      expect(
          await remoteSourceDataImpl.getCurrencyConverterData(
              amount: '5', from: 'USD', to: 'EGP'),
          CurrencyConverterModel());
    });
  });
}
