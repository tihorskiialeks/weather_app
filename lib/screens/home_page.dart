import 'package:flutter/material.dart';

import 'package:weather_app/widgets/city_search.dart';

import '../helpers/data_service.dart';
import '../helpers/weather_response.dart';
import '../strings/strings.dart';
import '../strings/image_assets_strings.dart';

import '../widgets/popular_cities_page.dart';
import '../widgets/frequently_asked_questions.dart';
import '../widgets/search_button.dart';
import '../widgets/weather_output.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _cityTextController = TextEditingController();
  final _dataService = DataService();
  WeatherResponse? _response;
  late ScrollController _scrollController;
  bool expanded = false;
  String query = '';

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
    return Scaffold(
      body: ListView(
        controller: _scrollController,
        children: [
          Container(
            padding: EdgeInsets.zero,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageAssetsStrings.backgroundImage),
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
                      UserInput(
                        cityTextController: _cityTextController,
                        userInputQuery: (value) => setState(() {
                          query = value;
                          rebuildAllChildren(context);
                        }),
                      ),
                      SearchButton(
                        searchCallback: _search,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: query.isEmpty
                      ? 0
                      : MediaQuery.of(context).size.height * 0.09,
                  width: double.infinity,
                ),
                CitySearch(
                    query: query,
                    cityCallback: (city) {
                      setState(() {
                        _cityTextController.text = city;
                        _searchByName(_cityTextController.text);
                      });
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                  width: double.infinity,
                ),
                WeatherOutput(response: _response)
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PopularCitiesPage(
                cityCallback: (city) => _searchByName(city),
              ),
              FrequentlyAskedQuestions(expanded: expanded),
            ],
          ),
        ],
      ),
    );
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
    query = '';
  }

  void _searchByName(String cityName) async {
    final response = await _dataService.getWeather(cityName);
    setState(() => _response = response);
    _cityTextController.text = cityName;
    query = '';
    _scrollToTop();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }
}



class UserInput extends StatelessWidget {
  Function(String city) userInputQuery;

   UserInput({
    Key? key,
    required TextEditingController cityTextController,
    required this.userInputQuery,
  })  : _cityTextController = cityTextController,
        super(key: key);

  final TextEditingController _cityTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        child: TextField(
            style: const TextStyle(
              fontSize: 18,
            ),
            controller: _cityTextController,
            onChanged: (value) => userInputQuery(value),
            decoration: const InputDecoration(
              hintText: Strings.searchHintText,
              hintStyle: TextStyle(fontSize: 18),
              border: InputBorder.none,
            )),
      ),
    );
  }
}
