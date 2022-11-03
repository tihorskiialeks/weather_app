import 'dart:convert';

import 'package:http/http.dart' as http;
import './weather_response.dart';

String API = '656a591dc7256ec6e436fbf406419e88';

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    final uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$API&units=metric');
    final response = await http.get(uri);
    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}
