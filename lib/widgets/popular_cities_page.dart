import 'package:flutter/material.dart';
import '../strings/strings.dart';
import '../strings/image_assets_strings.dart';
import '../widgets/popular_city.dart';

class PopularCitiesPage extends StatelessWidget {
  Function(String city) cityCallback;

  PopularCitiesPage({
    required this.cityCallback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
          child: Text(
            Strings.heading1,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        InkWell(
            onTap: () => cityCallback(Strings.newYork),
            child: PopularCity(
              cityName: Strings.newYork,
              imageAsset: ImageAssetsStrings.newYorkImage,
            )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        InkWell(
            onTap: () => cityCallback(Strings.london),
            child: PopularCity(
              cityName: Strings.london,
              imageAsset: ImageAssetsStrings.londonImage,
            )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        InkWell(
          onTap: () => cityCallback(Strings.dubai),
          child: PopularCity(
            cityName: Strings.dubai,
            imageAsset: ImageAssetsStrings.dubaiImage,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        InkWell(
          onTap: () => cityCallback(Strings.paris),
          child: PopularCity(
              cityName: Strings.paris,
              imageAsset: ImageAssetsStrings.parisImage),
        ),
      ],
    );
  }
}
