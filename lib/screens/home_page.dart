import 'package:flutter/material.dart';
import 'package:weather_app/helpers/data_service.dart';
import 'package:weather_app/helpers/weather_response.dart';
import 'package:intl/intl.dart';

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
                borderRadius: BorderRadius.circular(40),
              ),
              height: MediaQuery.of(context).size.height * 0.092,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: TextField(
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          controller: _cityTextController,
                          decoration: const InputDecoration(
                            hintText: 'Start typing for search',
                            hintStyle: TextStyle(fontSize: 18),
                            border: InputBorder.none,
                          )),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xff90CAF9),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: IconButton(
                        onPressed: _search,
                        icon: Icon(Icons.search),
                        color: Colors.white,
                      ))
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
                  borderRadius: BorderRadius.circular(50)),
              child: Column(
                children: [
                  if (_response != null)
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.26,
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                                child: Image.network(_response!.iconUrl),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)),
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
                                    '${_response!.weatherInfo.main}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Text('${_response!.weatherInfo.description}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff9E9E9E),
                                    )),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  DateFormat('dd MMMM yyyy')
                                      .format(DateTime.now()),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff9E9E9E),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Min',
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
                                'Max',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff9E9E9E),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text('${_response!.tempInfo.maxTemp} \u2103',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff212121),
                                  ),),
                              )
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
