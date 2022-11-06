import 'package:flutter/material.dart';

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
      duration: Duration(milliseconds: 300),
      height: widget.expanded
          ? MediaQuery.of(context).size.height * 0.4
          : MediaQuery.of(context).size.height * 0.09,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: widget.expanded
            ? MediaQuery.of(context).size.height * 0.3
            : MediaQuery.of(context).size.height * 0.09,
        decoration: BoxDecoration(
          color: Color(0xffececec),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    widget.question,
                    style: TextStyle(
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
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: widget.expanded
                    ? MediaQuery.of(context).size.height * 0.24
                    : 0,
                child: const Text(
                  'But I must explain to you how all this mistaken idea '
                  'of denouncing pleasure and praising pain was born and I will give you a complete '
                  'account of the system, and expound the actual teachings of the great explorer of the truth, '
                  'the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, '
                  'because it is pleasure, but because those who do not know how to pursue pleasure rationally '
                  'encounter consequences that are extremely painful.',
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
