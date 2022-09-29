// handle error
class GeolocationWithError {
  final Geolocation? response;
  final String? error;

  GeolocationWithError({this.response, this.error});
}

// geolocation model to get the latitude and longitude of the API
class Geolocation {
  late final double lat;
  late final double lon;
  late final String country;

  Geolocation({required this.lat, required this.lon, required this.country});

  Geolocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['country'] = country;

    return data;
  }
}
