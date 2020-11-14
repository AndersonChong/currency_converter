import 'package:http/http.dart';
import 'dart:convert';

class Currency {
  var _accessKey = '6f64709d2060a5354bc6c63122b26884';
  var _apiEndpoint = 'latest';
  var jsonResponse;
  var base = 'EUR'; // Default base
  var target = 'USD'; // Default target
  double baseValue = 1; // Default base value
  double targetValue = 0;

  Future<void> getCurrencyRate() async {
    var response = await get(
        'http://data.fixer.io/api/$_apiEndpoint?access_key=$_accessKey');
    jsonResponse = jsonDecode(response.body);
  }

  void convertCurrency() {
    var fromEurConversion = jsonResponse['rates'][target];
    var toEurConversion = jsonResponse['rates'][base];

    print('$fromEurConversion and $toEurConversion');

    if (base == 'EUR' && target != 'EUR') {
      targetValue = baseValue * fromEurConversion;
    } else if (base != 'EUR' && target != 'EUR') {
      double newBase = baseValue / toEurConversion;
      targetValue = newBase * fromEurConversion;
    } else if (base != 'EUR' && target == 'EUR') {
      targetValue = baseValue / toEurConversion;
    } else {
      targetValue = baseValue;
    }

    targetValue = double.parse(targetValue.toStringAsFixed(2));

    print('$base: $baseValue = $target: $targetValue');
  }
}
