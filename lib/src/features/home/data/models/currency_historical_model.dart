//     final currencyConverterModel = currencyConverterModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entites/currency_historical_entity.dart';

CurrencyHistoricalModel currencyHistoricalModelFromJson(String str) =>
    CurrencyHistoricalModel.fromJson(json.decode(str));

// String currencyConverterModelToJson(CurrencyConverterModel data) =>
//     json.encode(data.toJson());

class CurrencyHistoricalModel extends CurrencyHistoricalEntity {
  const CurrencyHistoricalModel({
    String? base,
    DateTime? endDate,
    Map<String, dynamic>? rates,
    DateTime? startDate,
    bool? success,
    bool? timeseries,
  }) : super(
            base: base,
            endDate: endDate,
            rates: rates,
            success: success,
            timeseries: timeseries);

  // String? base;
  // DateTime? endDate;
  // Map<String, Rate>? rates;
  // DateTime? startDate;
  // bool? success;
  // bool? timeseries;

  factory CurrencyHistoricalModel.fromJson(Map<String, dynamic> json) =>
      CurrencyHistoricalModel(
        base: json["base"],
        endDate: DateTime.parse(json["end_date"]),
        rates: Map.from(json["rates"]).map((k, v) =>
            MapEntry<String, Map<String, num>>(
                k,
                Map.from(v)
                    .map((key, value) => MapEntry<String, num>(key, value)))),
        startDate: DateTime.parse(json["start_date"]),
        success: json["success"],
        timeseries: json["timeseries"],
      );

  // Map<String, dynamic> toJson() => {
  //     "base": base,
  //     "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
  //     "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  //     "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
  //     "success": success,
  //     "timeseries": timeseries,
  // };
}

// class Rate {
//   Rate({
//     this.currency,
//   });

//   num? currency;

  
// }
