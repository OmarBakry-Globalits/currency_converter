import 'package:equatable/equatable.dart';

class CurrencyHistoricalEntity extends Equatable {
  const CurrencyHistoricalEntity({
    this.base,
    this.endDate,
    this.rates,
    this.startDate,
    this.success,
    this.timeseries,
  });

  final String? base;
  final DateTime? endDate;
  final Map<String, dynamic>? rates;
  final DateTime? startDate;
  final bool? success;
  final bool? timeseries;

  @override
  List<Object?> get props =>
      [base, endDate, rates, startDate, success, timeseries];
}

// class Rate {
//   Rate({
//     this.currency,
//   });

//   num? currency;

//   factory Rate.fromJson(Map<String, dynamic> json) => Rate(
//         currency: json["EGP"],
//       );

//   Map<String, dynamic> toJson() => {
//         "EGP": currency,
//       };
// }
