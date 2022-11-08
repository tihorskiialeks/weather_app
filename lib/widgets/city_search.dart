import 'package:flutter/material.dart';

import '../strings/strings.dart';
import '../data/all_cities.dart';

class CitySearch extends StatefulWidget {
  String query;
  Function(String city) cityCallback;

  CitySearch({Key? key, required this.query, required this.cityCallback}) : super(key: key);

  @override
  State<CitySearch> createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> {
  late Function(String city) cityCallback;
  late List<String> cities;
  late List<String> selectedCities;

  @override
  void initState() {
    super.initState();
    cities = AllCities().allCities;
  }

  @override
  Widget build(BuildContext context) {
    searchCity(widget.query);
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: widget.query.isEmpty
            ? 0
            : MediaQuery.of(context).size.height * 0.25,
        maxWidth: MediaQuery.of(context).size.width * 0.85,
      ),
      child: selectedCities.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                final city = selectedCities[index];
                return buildCity(city);
              },
              itemCount: selectedCities.length,
            )
          : Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              height: MediaQuery.of(context).size.height * 0.07,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: const [
                    Text(
                      Strings.notFound,
                      textAlign: TextAlign.center,
                      style: (TextStyle(color: Color(0xff9E9E9E))),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildCity(String city) => InkWell(
        onTap: () => widget.cityCallback(city),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(city)],
              ),
            ),
          ],
        ),
      );

  void searchCity(String query) {
    selectedCities = cities
        .where((city) => city.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      widget.query = query;
    });
  }

  String chooseCity(String city) {
    return city;
  }
}
