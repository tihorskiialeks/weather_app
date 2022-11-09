import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  VoidCallback searchCallback;
  SearchButton({
    required this.searchCallback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: const Color(0xff90CAF9),
          borderRadius: BorderRadius.circular(40),
        ),
        child: IconButton(
          onPressed: searchCallback,
          icon: const Icon(Icons.search),
          color: Colors.white,
        ));
  }
}