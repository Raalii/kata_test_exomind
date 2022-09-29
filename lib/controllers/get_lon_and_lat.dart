import 'package:dio/dio.dart';
import 'package:meteo/config/APIs/weather_api.dart';
import 'package:meteo/model/geolocation.dart';

import 'errors.dart';

// get longitude and latitude of city. Must be well written
Future<GeolocationWithError> getLonAndLat({required String query}) async {
  try {
    Response response = await dio.get(
      geocoderUrlExtension,
      queryParameters: {
        'q': query,
        'limit': 1,
        'appid': APIKEYWEATHER,
      },
      options: Options(
        headers: {
          'Content-type': 'application/json',
          'Accept': "application/json",
        },
      ),
    );
    var data = Map<String, dynamic>.from(response.data[0]);
    Geolocation map = Geolocation.fromJson(
      {
        "lat": data['lat'],
        "lon": data['lon'],
        "country": data['country'],
      },
    );
    return GeolocationWithError(response: map, error: null);
  } on DioError catch (e) {
    return GeolocationWithError(response: null, error: handleError(e));
  }
}
