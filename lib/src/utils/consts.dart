import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

mixin Constants {
  // static const List<Color> priorityColors = [
  //   Color(0xffFC5565),
  //   Color(0xffFA9B4A),
  //   Color(0xff58BBF7),
  //   Color(0xff4CCB41),
  // ];
  // static const String taskBoxName = 'tasks';
  // static const String userBoxName = 'user';

  static final navigatorKey = GlobalKey<NavigatorState>();

  static void closeAppFunction() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
      return;
    }
    exit(0);
  }

  static Future<dynamic> errorMessage(
      {String? title, String? description, Function? onPressed}) async {
    return navigatorKey.currentContext == null
        ? const SizedBox.shrink()
        : showDialog<void>(
            context: navigatorKey.currentContext!,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title ?? "Alert"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(description ?? 'Error Occuered'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      if (onPressed != null) {
                        onPressed();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  TextButton(
                    child: const Text('Cancle'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
  }

  static TextStyle selectedTextStyle(bool isSelected) => TextStyle(
        color: isSelected ? Colors.white : const Color(0xff0063f5),
        fontSize: 14,
        fontFamily: "Gotham",
        fontWeight: FontWeight.w500,
      );

  static final BoxDecoration selectedDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    boxShadow: const [
      BoxShadow(
        color: Color(0x13000000),
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
    color: const Color(0xff0063f5),
  );

  static final BoxDecoration unselectedBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    border: Border.all(
      color: const Color(0xff0063f5),
      width: 1,
    ),
    boxShadow: const [
      BoxShadow(
        color: Color(0x13000000),
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
    color: const Color(0xfff8f9fa),
  );

  // static Future<void> showLoading(
  //     {String? title, String? description, Function? onPressed}) async {
  //   return showDialog<void>(
  //     context: navigatorKey.currentContext!,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return const Center(child: CircularProgressIndicator());
  //     },
  //   );
  // }

  //bool get navigatorKeyHoldingState => navigatorKey.currentState != null;

  //static void hideLoading() => navigatorKey.currentState!.pop();

  // static Future<String?> selectDate(
  //     {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: navigatorKey.currentContext!,
  //     initialDate: initialDate ?? DateTime.now(),
  //     firstDate: firstDate ?? DateTime.now(),
  //     lastDate: lastDate ??
  //         DateTime(DateTime.now().year + 100, DateTime.now().month,
  //             DateTime.now().day),
  //   );
  //   if (picked != null) {
  //     return formattedDate(picked);
  //   }
  //   return null;
  // }

  static String historicalDateLogic(bool currentDate) {
    if (currentDate) {
      return formattedDate(DateTime.now());
    }
    DateTime dateBeforeSevenDays =
        DateTime.now().subtract(const Duration(days: 7));
    return formattedDate(dateBeforeSevenDays);
  }

  static String formattedDate(DateTime date) =>
      DateFormat('yyyy-MM-dd').format(date);

  static final Map<String, num> currencies = {
    "Select": 1,
    "AED": 3.633928,
    "AFN": 87.064213,
    "ALL": 117.337138,
    "AMD": 401.381254,
    "ANG": 1.783281,
    "AOA": 430.066287,
    "ARS": 147.326576,
    "AUD": 1.521416,
    "AWG": 1.783338,
    "AZN": 1.682693,
    "BAM": 1.949847,
    "BBD": 1.997841,
    "BDT": 101.172233,
    "BGN": 1.956969,
    "BHD": 0.37333,
    "BIF": 2027.217547,
    "BMD": 0.989369,
    "BND": 1.409083,
    "BOB": 6.837208,
    "BRL": 5.115722,
    "BSD": 0.989449,
    "BTC": 4.8717857e-05,
    "BTN": 80.682949,
    "BWP": 13.045093,
    "BYN": 2.509699,
    "BYR": 19391.636862,
    "BZD": 1.994431,
    "CAD": 1.345893,
    "CDF": 2024.249539,
    "CHF": 0.971852,
    "CLF": 0.033709,
    "CLP": 930.145684,
    "CNY": 7.040337,
    "COP": 4533.200758,
    "CRC": 619.931069,
    "CUC": 0.989369,
    "CUP": 26.218285,
    "CVE": 109.524353,
    "CZK": 24.487866,
    "DJF": 175.830599,
    "DKK": 7.438097,
    "DOP": 52.980681,
    "DZD": 138.91454,
    "EGP": 19.451494,
    "ERN": 14.840538,
    "ETB": 52.065587,
    "EUR": 1,
    "FJD": 2.282444,
    "FKP": 0.855405,
    "GBP": 0.8716,
    "GEL": 2.748813,
    "GGP": 0.855405,
    "GHS": 10.384653,
    "GIP": 0.855405,
    "GMD": 54.997772,
    "GNF": 8656.980617,
    "GTQ": 7.816708,
    "GYD": 207.012589,
    "HKD": 7.7664,
    "HNL": 24.487147,
    "HRK": 7.524547,
    "HTG": 119.719285,
    "HUF": 421.102281,
    "IDR": 15042.666548,
    "ILS": 3.509535,
    "IMP": 0.855405,
    "INR": 80.719321,
    "IQD": 1444.479072,
    "IRR": 41949.255425,
    "ISK": 140.717792,
    "JEP": 0.855405,
    "JMD": 150.958769,
    "JOD": 0.70148,
    "JPY": 142.956964,
    "KES": 119.617268,
    "KGS": 79.475637,
    "KHR": 4088.07408,
    "KMF": 493.348695,
    "KPW": 890.432349,
    "KRW": 1400.630375,
    "KWD": 0.306219,
    "KYD": 0.824641,
    "KZT": 464.664228,
    "LAK": 16398.794985,
    "LBP": 1506.315231,
    "LKR": 361.156359,
    "LRD": 152.057884,
    "LSL": 17.660086,
    "LTL": 2.92135,
    "LVL": 0.598459,
    "LYD": 4.922139,
    "MAD": 10.812321,
    "MDL": 19.244814,
    "MGA": 4155.350588,
    "MKD": 61.830552,
    "MMK": 2077.864014,
    "MNT": 3190.163747,
    "MOP": 8.000059,
    "MRO": 353.204644,
    "MUR": 45.258784,
    "MVR": 15.285476,
    "MWK": 1013.571957,
    "MXN": 19.811227,
    "MYR": 4.581274,
    "MZN": 63.151453,
    "NAD": 17.660674,
    "NGN": 409.974781,
    "NIO": 35.627037,
    "NOK": 10.392587,
    "NPR": 129.092679,
    "NZD": 1.723145,
    "OMR": 0.38096,
    "PAB": 0.989549,
    "PEN": 3.921363,
    "PGK": 3.482499,
    "PHP": 58.062112,
    "PKR": 220.829582,
    "PLN": 4.819,
    "PYG": 6984.76808,
    "QAR": 3.602268,
    "RON": 4.934282,
    "RSD": 117.348955,
    "RUB": 60.599111,
    "RWF": 1032.406789,
    "SAR": 3.720493,
    "SBD": 8.063453,
    "SCR": 12.949634,
    "SDG": 560.972386,
    "SEK": 10.821513,
    "SGD": 1.408768,
    "SHP": 1.362755,
    "SLL": 15805.173576,
    "SOS": 562.461025,
    "SRD": 28.379562,
    "STD": 20477.945484,
    "SVC": 8.658177,
    "SYP": 2485.82018,
    "SZL": 17.452574,
    "THB": 37.041829,
    "TJS": 9.8097,
    "TMT": 3.472686,
    "TND": 3.217448,
    "TOP": 2.396051,
    "TRY": 18.378914,
    "TTD": 6.702809,
    "TWD": 31.224467,
    "TZS": 2307.208782,
    "UAH": 36.543732,
    "UGX": 3779.555649,
    "USD": 0.989369,
    "UYU": 40.791341,
    "UZS": 10907.796337,
    "VND": 23621.19031,
    "VUV": 117.69722,
    "WST": 2.696603,
    "XAF": 653.999849,
    "XAG": 0.047769,
    "XAU": 0.000576,
    "XCD": 2.67382,
    "XDR": 0.768101,
    "XOF": 653.478562,
    "XPF": 118.825561,
    "YER": 247.589709,
    "ZAR": 17.586994,
    "ZMK": 8905.514457,
    "ZMW": 15.60869,
    "ZWL": 318.576488
  };
}
