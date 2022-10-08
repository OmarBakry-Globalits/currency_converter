import 'package:currency_converter/src/features/home/domain/usecases/get_converted_data.dart';
import 'package:currency_converter/src/features/home/domain/usecases/get_latest_data.dart';
import 'package:currency_converter/src/features/home/presentation/bloc/currency/currency_cubit.dart';
import 'package:currency_converter/src/features/home/presentation/bloc/currency_converter/currency_converter_cubit.dart';
import 'package:currency_converter/src/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'features/home/domain/usecases/get_historical_data.dart';
import 'features/home/presentation/screen/home_base.dart';
import 'di.dart' as di;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      //! call this if you want to clear shared data while pausing the app
      // SharedPreferences.getInstance().then((value) => value.clear());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
            value: CurrencyCubit(
          getLatestData: di.sl<GetLatestDataUseCase>(),
          getHistoricalData: di.sl<GetHistoricalData>(),
        )),
        BlocProvider.value(
            value: CurrencyConverterCubit(
          getConvertedData: di.sl<GetConvertedData>(),
        )),
      ],
      child: MaterialApp(
        home: const HomeBase(),
        navigatorKey: Constants.navigatorKey,
      ),
    );
  }
}
