import 'consts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

mixin EndPoints {
  //static const String apiKey = '22IpdDCjNaYfv2xfg3SlTGtq837fPjHC';
  static final String _apiKey = dotenv.env['APIKEY']!;

  static final String latestURL =
      'https://api.apilayer.com/exchangerates_data/latest?symbols=&base=USD&apikey=$_apiKey';
  static String historicalURL =
      "https://api.apilayer.com/exchangerates_data/timeseries?start_date=${Constants.historicalDateLogic(false)}&end_date=${Constants.historicalDateLogic(true)}&base=USD&symbols=KWD&apikey=$_apiKey";

  static String converterURL(
          {required String from, required String to, required String amount}) =>
      "https://api.apilayer.com/exchangerates_data/convert?to=$to&from=$from&amount=$amount&apikey=$_apiKey";
}
