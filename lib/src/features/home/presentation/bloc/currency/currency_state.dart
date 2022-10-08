import 'package:currency_converter/src/features/home/domain/entites/currency_historical_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entites/currency_entity.dart';

abstract class CurrencyState extends Equatable {
  const CurrencyState();

  @override
  List<Object> get props => [];
}

class CurrencyInitial extends CurrencyState {}

class LoadingState extends CurrencyState {}

class LatestSelected extends CurrencyState {}

class HistoricalSelected extends CurrencyState {}

class LoadedCurrencyState extends CurrencyState {
  final CurrencyEntity currencyEntity;

  const LoadedCurrencyState({required this.currencyEntity});

  @override
  List<Object> get props => [currencyEntity];
}


class LoadedHistoricalState extends CurrencyState {
  final CurrencyHistoricalEntity historicalEntity;

  const LoadedHistoricalState({required this.historicalEntity});

  @override
  List<Object> get props => [historicalEntity];
}

class ErrorState extends CurrencyState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
