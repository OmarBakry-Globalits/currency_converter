import 'package:currency_converter/src/core/error/exceptions.dart';
import 'package:currency_converter/src/features/home/data/models/currency_converter_model.dart';
import 'package:currency_converter/src/features/home/data/models/currency_historical_model.dart';
import 'package:currency_converter/src/features/home/data/models/currency_model.dart';
import 'package:currency_converter/src/utils/consts.dart';
import 'package:currency_converter/src/utils/end_points_url.dart';
import 'package:http/http.dart' as http;

abstract class RemoteSourceData {
  Future<CurrencyModel> getLatestData();
  Future<CurrencyHistoricalModel> getHistoricalData();
  Future<CurrencyConverterModel> getCurrencyConverterData(
      {required String amount, required String from, required String to});
}

class RemoteSourceDataImpl implements RemoteSourceData {
  @override
  Future<CurrencyModel> getLatestData() async {
    try {
      http.Response response = await http.get(Uri.parse(EndPoints.latestURL));
      if (response.statusCode == 200) {
        return currencyModelFromJson(response.body);
      }
    } catch (e) {
      Constants.errorMessage(description: e.toString());
    }
    throw ServerException();
  }

  @override
  Future<CurrencyHistoricalModel> getHistoricalData() async {
    try {
      http.Response response =
          await http.get(Uri.parse(EndPoints.historicalURL));
      if (response.statusCode == 200) {
        return currencyHistoricalModelFromJson(response.body);
      }
    } catch (e) {
      Constants.errorMessage(description: e.toString());
    }
    throw ServerException();
  }

  @override
  Future<CurrencyConverterModel> getCurrencyConverterData(
      {required String amount,
      required String from,
      required String to}) async {
    try {
      http.Response response = await http.get(Uri.parse(
          EndPoints.converterURL(from: from, to: to, amount: amount)));
      if (response.statusCode == 200) {
        return currencyConverterModelFromJson(response.body);
      }
    //  print("res ${response.body}");
    //  print("res ${response.statusCode}");
    //  print("res ${response.request?.url}");
    } catch (e) {
      Constants.errorMessage(description: e.toString());
    }

    throw ServerException();
  }
}
