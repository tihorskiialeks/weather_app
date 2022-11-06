import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helpers/data_service.dart';
import '../helpers/weather_response.dart';
import '../widgets/question_container.dart';
import '../widgets/popular_city.dart';




class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();
  WeatherResponse? _response;
  late ScrollController _scrollController;
  bool expanded = false;
  bool expanded1 = false;
  bool expanded2 = false;
  bool expanded3 = false;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() {});

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

//  List<String> cities = ['kyiv', 'odessa', 'lviv', 'moscow'];
//  late ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: _scrollController,
        children: [
          Container(
            padding: EdgeInsets.zero,
            height: MediaQuery.of(context).size.height,
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
                              // onChanged: searchCity,
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
                // Column(
                //   children: [
                //     //buildSearch(),
                //     Container(
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(40),
                //       ),
                //       height: MediaQuery.of(context).size.height * 0.092,
                //       width: MediaQuery.of(context).size.width * 0.85,
                //       child: ListView.builder(
                //           itemCount: cities.length,
                //           itemBuilder: (context, index) {
                //             final city = cities[index];
                //             return buildCIty(city);
                //           }),
                //     ),
                //   ],
                // ),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.26,
                                    height: MediaQuery.of(context).size.height *
                                        0.13,
                                    child: Image.network(_response!.iconUrl),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(40)),
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
                                    Text(
                                        '${_response!.weatherInfo.description}',
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
                            ),
                          ],
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: double.infinity,
            child: Text(
              'Check the weather in most popular cities in the world',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.zero,
            height: MediaQuery.of(context).size.height * 3,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                InkWell(
                  onTap: () => _searchByName('New York'),
                  child: PopularCity(cityName: 'New York', imageAsset: 'assets/images/new_york.png',)
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                InkWell(
                  onTap: () => _searchByName('London'),
                  child: PopularCity(cityName: 'London', imageAsset: 'assets/images/london.png',)
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                InkWell(
                  onTap: () => _searchByName('Dubai'),
                  child: PopularCity(cityName: 'Dubai', imageAsset: 'assets/images/dubai.png',),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                InkWell(
                  onTap: () => _searchByName('Paris'),
                  child: PopularCity(cityName: 'Paris', imageAsset: 'assets/images/paris.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.09,
                    child: const Text(
                      'Frequently Asked Questions',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                QuestionContainer(expanded: expanded, question: 'Question 1'),
                SizedBox(
                  height: 10,
                ),
               QuestionContainer(expanded: expanded, question: 'Question 2'),
                SizedBox(
                  height: 10,
                ),
                QuestionContainer(expanded: expanded, question: 'Question 3'),
                SizedBox(
                  height: 10,
                ),
                QuestionContainer(
                  expanded: expanded3,
                  question: 'Question 4',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Text('Tykhorskyi Oleksandr, 2022'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }

  void _searchByName(String cityName) async {
    final response = await _dataService.getWeather(cityName);
    setState(() => _response = response);
    _scrollToTop();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

// void searchCity(String query){
//   final findedCities = cities.where((city) {
//     final cityLower = city.toLowerCase();
//     final searchLower = query.toLowerCase();
//     return cityLower.contains(searchLower);
//   }).toList();
//   setState(() {
//
//     this.cities = findedCities;
//   });
// }
//
//
//
// Widget buildCIty(String cityName) => Card(
//   margin: EdgeInsets.all( 12),
//   child: Text(cityName),
//
//     );
}




