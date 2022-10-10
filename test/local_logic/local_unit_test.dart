

import 'package:flutter_test/flutter_test.dart';
import 'package:currency_converter/src/features/home/data/source/local_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async {
    final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final CurrencyLocalDataSourceImpl localSourceDataImpl =
      CurrencyLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  
  group('LOCAL_STORAGE_TEST', () {
    test('set_data', () async {
      expect(await localSourceDataImpl.cacheData({'key': 'value'}), true);
    });
    test('get_data', () async {
      expect(await localSourceDataImpl.getCachedData(false), {'key': 'value'});
    });
  });
}