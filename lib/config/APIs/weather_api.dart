import 'package:dio/dio.dart';
// define variable for api

// Can change the key if you want to test the error
const String APIKEYWEATHER = "516a5b490ae1b5915920928742ce0d1b";

const String _basePath = "https://api.openweathermap.org";

const String geocoderUrlExtension = "/geo/1.0/direct";

const String weatherUrlExtension = "/data/2.5/weather";

// dio variable to handle post/get/del request
final Dio dio = Dio(
  BaseOptions(
    baseUrl: _basePath,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    contentType: 'application/json',
  ),
);
