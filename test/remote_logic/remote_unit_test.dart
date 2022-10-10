
import 'package:currency_converter/src/core/error/exceptions.dart';
import 'package:currency_converter/src/features/home/data/source/remote_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteSource extends Mock implements RemoteSourceDataImpl {}

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //* To avoid the CustomDialog error.
  final MockRemoteSource mockRemoteSource = MockRemoteSource();
  final RemoteSourceDataImpl remoteSourceDataImpl =
      RemoteSourceDataImpl(remoteSourceDataImpl: mockRemoteSource);
      
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