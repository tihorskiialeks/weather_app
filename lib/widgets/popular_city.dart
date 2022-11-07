import 'package:flutter/material.dart';

class PopularCity extends StatelessWidget {
  String imageAsset;
  String cityName;
  PopularCity({
    required this.imageAsset,
    required this.cityName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image:  DecorationImage(
            image: AssetImage(imageAsset),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(40),
      ),
      height: MediaQuery.of(context).size.height * 0.32,
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height * 0.053,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    cityName,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}