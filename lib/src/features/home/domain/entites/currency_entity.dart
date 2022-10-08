import 'package:equatable/equatable.dart';

class CurrencyEntity extends Equatable {
  const CurrencyEntity({
    this.base,
    this.date,
    this.rates,
    this.success,
    this.timestamp,
  });

  final String? base;
  final DateTime? date;
  final Map<String, dynamic>? rates;
  final bool? success;
  final int? timestamp;

  @override
  List<Object?> get props => [base, date, rates, success, timestamp];
}
