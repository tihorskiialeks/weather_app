import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helpers/weather_response.dart';
import '../strings/strings.dart';
class WeatherOutput extends StatelessWidget {
  const WeatherOutput({
    Key? key,
    required WeatherResponse? response,
  }) : _response = response, super(key: key);

  final WeatherResponse? _response;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.43,
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(50)),
      child: Column(
        children: [
          if (_response != null)
            Column(
              children: [
                CurrentWeatherAndTemp(response: _response),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: SityAndDate(response: _response),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                MinMaxTemp(response: _response),
              ],
            ),
        ],
      ),
    );
  }
}

class MinMaxTemp extends StatelessWidget {
  const MinMaxTemp({
    Key? key,
    required WeatherResponse? response,
  }) : _response = response, super(key: key);

  final WeatherResponse? _response;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Text(
              Strings.minTemp,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff9E9E9E),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                '${_response!.tempInfo.minTemp} \u2103',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff212121),
                ),
              ),
            )
          ],
        ),
        Column(children: [
          const Text(
            Strings.maxTemp,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff9E9E9E),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              '${_response!.tempInfo.maxTemp} \u2103',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xff212121),
              ),
            ),
          )
        ]),
      ],
    );
  }
}

class SityAndDate extends StatelessWidget {
  const SityAndDate({
    Key? key,
    required WeatherResponse? response,
  }) : _response = response, super(key: key);

  final WeatherResponse? _response;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            '${_response!.cityName}, ${_response!.countryInfo.country}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(
            DateFormat(Strings.dateFormat)
                .format(DateTime.now()),
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xff9E9E9E),
            ),
          ),
        ),
      ],
    );
  }
}

class CurrentWeatherAndTemp extends StatelessWidget {
  const CurrentWeatherAndTemp({
    Key? key,
    required WeatherResponse? response,
  }) : _response = response, super(key: key);

  final WeatherResponse? _response;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width *
                0.26,
            height: MediaQuery.of(context).size.height *
                0.13,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(40)),
            child: Image.network(_response!.iconUrl),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8),
              child: Text(
                '${_response!.tempInfo.temperature} \u2103',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                _response!.weatherInfo.main,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(_response!.weatherInfo.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff9E9E9E),
                )),
          ],
        ),
      ],
    );
  }
}