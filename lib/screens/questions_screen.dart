import 'package:flutter/material.dart';
import 'package:stemcalendar/data/questions.dart';

//displays the quiz and allows the user to select answers to the questions from questions.dart
class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  Widget? activeWidget;
 
  @override
  void initState() {
    super.initState();
    activeWidget = const QuestionsScreen();
    switchScreen();
  }

  void switchScreen() {
    setState(() {
     activeWidget = const QuestionsScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      
      body: 
      ListView(
        physics: const BouncingScrollPhysics(),
        children: [
        Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            // Loops through and displays questions with answer buttons
            for (var i = 0; i < QuizQuestion.questions.length; i++) ...[
                Text( //displays the question
                  QuizQuestion.questions[i].question,
                  style: const TextStyle(fontSize: 12),
                ),
                for (var j = 0; j < QuizQuestion.questions[i].answers.length; j++) //makes a seperate button for each answer in the list of answers
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        QuizQuestion.questions[i].selectedAnswer = QuizQuestion.questions[i].answers[j];
                      });
                    },
                    style: ElevatedButton.styleFrom( //changes the color of the button to blue when it is selected
                      backgroundColor: QuizQuestion.questions[i].selectedAnswer == QuizQuestion.questions[i].answers[j]
                          ? Colors.blue.withAlpha(128)
                          : const Color.fromARGB(255, 36, 4, 242).withAlpha(128),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      QuizQuestion.questions[i].answers[j].toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                    ),
                const SizedBox(height: 10), 
              ],
        Center (
        child: Column(
        children:  <Widget>[
        Text('When are you available to work on this project?'),
        Column(
          children: [
            Center(
            child: Column(
              children: [
                Row(
                children: [
                Row(
                  children: [ ...[
                    for (var i = 6; i <= 11; i++) ...[
                      CheckboxWidget(),
                      Text('$i:00 AM '), //makes checkboxes for each hour in the morning, starting at 6:00 AM
                    ],
                  ],
                  ],
                ),
                Row(
                  children: [
                    CheckboxWidget(),
                    const Text('12:00 PM'), //handles special case that is the 12:00 PM checkbox
                  ],
                ),
                ],
            ),
                Row(
                  children: [ 
                    for (var i = 1; i <= 10; i++) ...[
                      CheckboxWidget(),
                      Text('$i:00 PM '), //makes checkboxes for each hour in the afternoon after 12 PM and until 10 PM
                    ],
                  ],
                ),
              ],
            ),
          ),
          ],
        ),
        ],
        ),
        ),
          ],
      ),
      ),
        ],
    ),
    );
  }
}


// allows the checkboxes to change states when clicked to appear checked or unchecked, as well as stores the data gained from this question
class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget({super.key});

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
        ),
      ],
    );
  }
}


