import 'package:flutter/material.dart';
import '../widgets/question_container.dart';
import '../strings/strings.dart';
import 'package:intl/intl.dart';

class FrequentlyAskedQuestions extends StatelessWidget {
  const FrequentlyAskedQuestions({
    Key? key,
    required this.expanded,
  }) : super(key: key);

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.09,
            child: const Text(
              Strings.heading2,
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        QuestionContainer(
            expanded: expanded, question: '${Strings.question} 1'),
        const SizedBox(
          height: 10,
        ),
        QuestionContainer(
            expanded: expanded, question: '${Strings.question} 2'),
        const SizedBox(
          height: 10,
        ),
        QuestionContainer(
            expanded: expanded, question: '${Strings.question} 3'),
        const SizedBox(
          height: 10,
        ),
        QuestionContainer(
          expanded: expanded,
          question: '${Strings.question} 4',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Text(
              '${Strings.authorName} ${DateFormat(Strings.year).format(DateTime.now())}'),
        )
      ],
    );
  }
}