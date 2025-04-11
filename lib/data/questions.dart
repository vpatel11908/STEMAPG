
class QuizQuestion { // This class represents a quiz question with its possible answers and the selected answer.
  final String question; // The question text.
  final List<String> answers; // The list of possible answers.
  String? selectedAnswer; // The answer selected by the user.
 
  QuizQuestion({  // Constructor to initialize the question, answers, and selected answer.
    required this.question,
    required this.answers,
    this.selectedAnswer,
  });

  static List<QuizQuestion> questions = [ // A list of instances of the QuizQuestion class to be displayed on the quiz page.
  QuizQuestion(
    question: 'How many hours do you want to work each day?',
    answers: [
      '1 to 2',
      '3 to 4',
      '4 to 5',
    ],
    selectedAnswer: null,
  ),
  QuizQuestion(
    question: 'What is your current motivation level on a scale of 1 to 10?',
    answers: [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
    ],
    selectedAnswer: null,
  ),
 QuizQuestion(
    question: 'How much do you prefer to work for long stretches at a time as opposed to in short bursts on a scale from 1 to 10?',
    answers: [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
    ],
    selectedAnswer: null,
  ),
  //Add more questions here when the quiz is finalzed
];
}


