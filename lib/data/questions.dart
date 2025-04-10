
class QuizQuestion {
  final String question;
  final List<String> answers;
  final int? selectedAnswer;

  QuizQuestion({
    required this.question,
    required this.answers,
    this.selectedAnswer,
  });

  static List<QuizQuestion> questions = [
  QuizQuestion(
    question: 'How many hours do you want to work each day?',
    answers: [
      '1-3',
      '3-4',
      '3-5',
    ],
    selectedAnswer: null,
  ),
  QuizQuestion(
    question: 'What is your current motivation level?',
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
    question: 'Do you prefer to work for long stretches at a time or in short bursts?',
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
];
}


