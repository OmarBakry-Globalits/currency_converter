import 'package:currency_converter/src/features/home/domain/usecases/get_converted_data.dart';
import 'package:currency_converter/src/features/home/presentation/bloc/currency_converter/currency_converter_cubit.dart';
import 'package:currency_converter/src/features/home/presentation/bloc/currency_converter/currency_converter_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:currency_converter/src/di.dart' as di;
import 'package:bloc_test/bloc_test.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //* To avoid the CustomDialog error.

  await di.init();

  late CurrencyConverterCubit converterCubit;
  setUp(() {
    converterCubit =
        CurrencyConverterCubit(getConvertedData: di.sl<GetConvertedData>());
  });
  group('CurrencyConverterCubitTest', () {
    test('init state is CurrencyConverterInitial', () {
      expect(converterCubit.state, CurrencyConverterInitial());
    });

    blocTest(
      'onChangeValue From',
      build: () => converterCubit,
      act: (cubit) => converterCubit.onChangeValue(true, value: 'from'),
      expect: () => [CurrencyConverterInitial(), FromStateChanges()],
    );

    blocTest(
      'onChangeValue TO',
      build: () => converterCubit,
      act: (cubit) => converterCubit.onChangeValue(false, value: 'from'),
      expect: () => [CurrencyConverterInitial(), ToStateChanges()],
    );

    blocTest(
      'getConvertedDataFunc',
      build: () => converterCubit,
      act: (cubit) => converterCubit.getConvertedDataFunc(
          amount: '5', from: 'USD', to: 'EGP'),
      expect: () =>
          [LoadingState(), const ErrorState(message: 'Server Exception')],
    );
  });
}
