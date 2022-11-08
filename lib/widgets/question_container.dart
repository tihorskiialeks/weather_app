import 'package:flutter/material.dart';
import '../strings/strings.dart';

class QuestionContainer extends StatefulWidget {
  QuestionContainer({
    Key? key,
    required this.expanded,
    required this.question,
  }) : super(key: key);

  bool expanded;
  String question;

  @override
  State<QuestionContainer> createState() => _QuestionContainerState();
}

class _QuestionContainerState extends State<QuestionContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: widget.expanded
          ? MediaQuery.of(context).size.height * 0.4
          : MediaQuery.of(context).size.height * 0.09,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: widget.expanded
            ? MediaQuery.of(context).size.height * 0.3
            : MediaQuery.of(context).size.height * 0.09,
        decoration: BoxDecoration(
          color: const Color(0xffececec),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    widget.question,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.expanded = !widget.expanded;
                    });
                  },
                  icon: Icon(
                      widget.expanded ? Icons.expand_less : Icons.expand_more),
                ),
              ],
            ),
            SingleChildScrollView(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: widget.expanded
                    ? MediaQuery.of(context).size.height * 0.24
                    : 0,
                child: const Text(
                  Strings.answer,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
