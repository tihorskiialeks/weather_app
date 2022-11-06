import 'package:http/http.dart' as http;

/*
* {

  "weather": [
    {
      "main": "Rain",
      "description": "moderate rain",
      "icon": "10d"
    }
  ],
  "main": {
    "temp": 298.48,
    "temp_min": 297.56,
    "temp_max": 300.05,
  },
  "sys": {
    "country": "IT",
  },
  "name": "Zocca",
}      */
class WeatherResponse {
  final String cityName;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;
  final CountryInfo countryInfo;

  String get iconUrl{
    return 'http://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse({
    required this.cityName,
    required this.tempInfo,
    required this.weatherInfo,
    required this.countryInfo,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final countryInfoJson = json['sys'];
    final countryInfo = CountryInfo.fromJson(countryInfoJson);

    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    return WeatherResponse(
      cityName: cityName,
      tempInfo: tempInfo,
      weatherInfo: weatherInfo,
      countryInfo: countryInfo,
    );
  }
}

class TemperatureInfo {
  final num temperature;
  final num minTemp;
  final num maxTemp;

  TemperatureInfo({
    required this.temperature,
    required this.minTemp,
    required this.maxTemp,
  });

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    final minTemp = json['temp_min'];
    final maxTemp = json['temp_max'];
    return TemperatureInfo(
      temperature: temperature,
      minTemp: minTemp,
      maxTemp: maxTemp,
    );
  }
}

class WeatherInfo {
  final String main;
  final String description;
  final String icon;

  WeatherInfo(
      {required this.main, required this.description, required this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final main = json['main'];
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(main: main, description: description, icon: icon);
  }
}

class CountryInfo {
  final String country;

  CountryInfo(this.country);

  factory CountryInfo.fromJson(Map<String, dynamic> json) {
    final country = json['country'];
    return CountryInfo(country);
  }
}
