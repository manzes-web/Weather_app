import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../home_screen/weather.dart';

class FetchData {
  // http://api.weatherapi.com/v1/current.json?key=1bc0383d81444b58b1432929200711&q=48.8567,2.350

  static const url = 'https://api.openweathermap.org/data/2.5/weather';

  FetchData();

  Future<Weather?> getWeatherByCity(String city) async {
    Uri? uri;
    if (city.trim().isEmpty) {
      final position = await getCurrentCity();
      uri = Uri.https('api.weatherapi.com', 'v1/current.json', {
        'key': '1bc0383d81444b58b1432929200711',
        'q': '${position.latitude},${position.longitude}'
      });
    } else {
      uri = Uri.https('api.weatherapi.com', 'v1/current.json',
          {'key': '1bc0383d81444b58b1432929200711', 'q': city});
    }

    final response = await http.get(uri);
    final data = jsonDecode(response.body);
    if (response.statusCode >= 300) {
      throw WeatherError.fromJson(data);
    }

    return Weather.fromJson(data);
  }

  Future<Position> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }
}
