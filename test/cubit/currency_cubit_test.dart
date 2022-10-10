import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter/src/features/home/data/models/currency_model.dart';
import 'package:currency_converter/src/features/home/domain/usecases/get_historical_data.dart';
import 'package:currency_converter/src/features/home/domain/usecases/get_latest_data.dart';
import 'package:currency_converter/src/features/home/presentation/bloc/currency/currency_cubit.dart';
import 'package:currency_converter/src/features/home/presentation/bloc/currency/currency_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:currency_converter/src/di.dart' as di;

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //* To avoid the CustomDialog error.

  await di.init();

  late CurrencyCubit currencyCubit;
  setUp(() {
    currencyCubit = CurrencyCubit(
        getLatestData: di.sl<GetLatestDataUseCase>(),
        getHistoricalData: di.sl<GetHistoricalData>());
  });
  group('CurrencyCubit', () {
    test('init state is loading state', () {
      expect(currencyCubit.state, LoadingState());
    });

    blocTest(
      'getLatestData',
      build: () => currencyCubit,
      act: (cubit) => currencyCubit.getLatestData(),
      expect: () => [
        LatestSelected(),
        const ErrorState(message: 'Server Exception'),
      ],
      
    );

    blocTest(
      'getHistoricalData',
      build: () => currencyCubit,
      act: (cubit) => currencyCubit.getHistoricalDataFunc(),
      expect: () => [
        LatestSelected(),
        const ErrorState(message: 'Server Exception'),
      ],
    );

    blocTest(
      'changeSelectionToHistorical',
      build: () => currencyCubit,
      act: (cubit) => currencyCubit.changeSelection(HistoricalSelected()),
      expect: () => [
        CurrencyInitial(),
        HistoricalSelected(),
        LoadingState(),
        LatestSelected(),
        const ErrorState(message: 'Server Exception'),
      ],
    );

    blocTest(
      'changeSelectionToLatest',
      build: () => currencyCubit,
      act: (cubit) => currencyCubit.changeSelection(LatestSelected()),
      expect: () => [
        CurrencyInitial(),
        LatestSelected(),
        const LoadedCurrencyState(currencyEntity: CurrencyModel(rates:{'key': 'value'})),
      ],
      tearDown: () => currencyCubit.close()
    );
  });
}
