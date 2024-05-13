class Weather {
  final double temperature;
  final String text;
  final String icon;
  final String city;
  final String country;

  Weather(
      {required this.temperature,
      required this.text,
      required this.icon,
      required this.city,
      required this.country});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        text: json['current']['condition']['text'] as String,
        temperature: json['current']['temp_c'] as double,
        icon: json['current']['condition']['icon'] as String,
        city: json['location']['name'] as String,
        country: json['location']['country'] as String);
  }
}

class WeatherError {
  final String error;
  WeatherError({
    required this.error,
  });
  factory WeatherError.fromJson(Map<String, dynamic> json) {
    return WeatherError(
      error: json['error']['message'] as String,
    );
  }
}
