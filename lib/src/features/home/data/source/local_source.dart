import 'package:currency_converter/src/core/error/exceptions.dart';
import 'package:currency_converter/src/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

abstract class CurrencyLocalDataSource {
  Future<Map<String, dynamic>?>? getCachedData(bool historicalData);
  Future<bool> cacheData(Map<String, double> rates,
      {bool historicalData = false});
}

const String _cachedData = "CACHED_DATA";

const String _cachedHistoryData = "CACHED_HISTORYICAL_DATA";

class CurrencyLocalDataSourceImpl implements CurrencyLocalDataSource {
  final SharedPreferences sharedPreferences;

  CurrencyLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> cacheData(Map<String, dynamic> rates,
      {bool historicalData = false}) async {
    try {
      String jsonData = json.encode(rates);
      return await sharedPreferences.setString(
          historicalData ? _cachedHistoryData : _cachedData, jsonData);
    } catch (e) {
      Constants.errorMessage(description: e.toString());

      return Future.value(false);
    }
  }

  @override
  Future<Map<String, dynamic>?>? getCachedData(bool historicalData) async {
    try {
      final String? jsonString = sharedPreferences
          .getString(historicalData ? _cachedHistoryData : _cachedData);
      if (jsonString != null) {
        Map<String, dynamic>? m = json.decode(jsonString);
        return Future.value(m);
      }
    } catch (e) {
      Constants.errorMessage(description: e.toString());
      debugPrint(e.toString());
    }
    throw EmptyCacheException();
  }
}
