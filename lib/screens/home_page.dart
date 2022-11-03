import 'package:flutter/material.dart';
import 'package:weather_app/helpers/data_service.dart';
import 'package:weather_app/helpers/weather_response.dart';

import '../widgets/user_input.dart';
import '../widgets/weather_output.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();
  WeatherResponse? _response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height *
                  0.15, // todo change to 9%
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                children: [
                  TextField(
                    controller: _cityTextController,
                  ),
                  ElevatedButton(onPressed: _search, child: Text('Search'))
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
              width: double.infinity,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.43,
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
              child: Column(
                children: [
                  if (_response != null)
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.26,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Image.network(_response!.iconUrl),
                              decoration: BoxDecoration(color:
                              Colors.white),
                            ),
                            Column(
                              children: [
                                Text('${_response!.tempInfo.temperature} C'),
                                Text('${_response!.weatherInfo.main}'),
                                Text('${_response!.weatherInfo.description}'),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                '${_response!.cityName}, ${_response!.countryInfo.country}'),
                            Text('Date today'), // todo
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text('Min'),
                                Text('${_response!.tempInfo.minTemp} C')
                              ],
                            ),
                            Column(children: [
                              const Text('Max'),
                              Text('${_response!.tempInfo.maxTemp} C')
                            ]),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }
}
