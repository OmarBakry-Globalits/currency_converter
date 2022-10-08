import 'dart:convert';

import 'package:currency_converter/src/features/home/domain/entites/currency_entity.dart';

CurrencyModel currencyModelFromJson(String str) =>
    CurrencyModel.fromJson(json.decode(str));

String currencyModelToJson(CurrencyModel data) => json.encode(data.toJson());

class CurrencyModel extends CurrencyEntity {
  const CurrencyModel({
    String? base,
    DateTime? date,
    Map<String, dynamic>? rates,
    bool? success,
    int? timestamp,
  }) : super(
            base: base,
            date: date,
            rates: rates,
            success: success,
            timestamp: timestamp);

  // String? base;
  // DateTime? date;
  // Map<String, double>? rates;
  // bool? success;
  // int? timestamp;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
      base: json["base"],
      date: json["date"] == null ? null : DateTime.parse(json["date"]),
      rates: json["rates"] == null
          ? null
          : Map.from(json["rates"])
              .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
      success: json["success"],
      timestamp: json["timestamp"]);

  Map<String, dynamic> toJson() => {
        "base": base,
        "date":
            "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "rates":
            Map.from(rates!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "success": success,
        "timestamp": timestamp,
      };
}
