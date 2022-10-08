
import 'package:currency_converter/src/features/home/domain/entites/currency_converter_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CurrencyConverterState extends Equatable {
  const CurrencyConverterState();

  @override
  List<Object> get props => [];
}

class CurrencyConverterInitial extends CurrencyConverterState {}


class LoadingState extends CurrencyConverterState {}
class FromStateChanges extends CurrencyConverterState {}
class ToStateChanges extends CurrencyConverterState {}

class LoadedState extends CurrencyConverterState {
  final CurrencyConverterEntity currencyEntity;

  const LoadedState({required this.currencyEntity});

  @override
  List<Object> get props => [currencyEntity];
}


class ErrorState extends CurrencyConverterState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
