// To parse this JSON data, do
//
//     final currencyConverterModel = currencyConverterModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entites/currency_converter_entity.dart';

CurrencyConverterModel currencyConverterModelFromJson(String str) =>
    CurrencyConverterModel.fromJson(json.decode(str));

String currencyConverterModelToJson(CurrencyConverterModel data) =>
    json.encode(data.toJson());

class CurrencyConverterModel extends CurrencyConverterEntity {
  const CurrencyConverterModel({
    DateTime? date,
    Info? info,
    Query? query,
    num? result,
    bool? success,
  }) : super(
            date: date,
            result: result,
            success: success,
            query: query,
            info: info);

  factory CurrencyConverterModel.fromJson(Map<String, dynamic> json) =>
      CurrencyConverterModel(
        date: DateTime.parse(json["date"]),
        info: Info.fromJson(json["info"]),
        query: Query.fromJson(json["query"]),
        result: json["result"].toDouble(),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "info": info?.toJson(),
        "query": query?.toJson(),
        "result": result,
        "success": success,
      };
}
