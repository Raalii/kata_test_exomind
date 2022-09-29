import 'package:dio/dio.dart';
import 'package:meteo/config/APIs/weather_api.dart';
import 'package:meteo/controllers/errors.dart';
import 'package:meteo/model/weather.dart';

// Get the weather of the current time. Lontitude and latitude will be user to locate the place
Future<WeatherResponseWithError> getWeather(
    {required double lat, required double lon}) async {
  try {
    Response response = await dio.get(
      weatherUrlExtension,
      queryParameters: {'lat': lat, 'lon': lon, 'appid': APIKEYWEATHER},
      options: Options(
        headers: {
          'Content-type': 'application/json',
          'Accept': "application/json",
        },
      ),
    );
    var data = Map<String, dynamic>.from(response.data);
    // print("valeur de data : $data");
    WeatherResponse map = WeatherResponse.fromJson(data);
    return WeatherResponseWithError(response: map, error: null);
  } on DioError catch (e) {
    return WeatherResponseWithError(response: null, error: handleError(e));
  }
}
