
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
    question: 'Are there times when you won’t be available to work on this project? (daily e.g. sleeping, eating, work/school)?',
    answers: [
      '8 a.m. to 3 p.m. (school)',
      '7p.m. to 8p.m. (dinner)',
      '11p.m. to 7a.m. (sleeping)',
      '10p.m. to 11p.m. (winding down)',
      '3p.m. to 7p.m. (free time/homework)',
    ],
    selectedAnswer: null,
  ),
  QuizQuestion(
    question: 'Do you prefer to eat dinner or desert first? ',
    answers: [
      'Dinner',
      'Desert',
      'Do not care/At the same time',
    ],
    selectedAnswer: null,
  ),
 QuizQuestion(
    question: 'From 1-10, how motivated are you to complete this project?',
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
    question: 'How quickly do you get bored of a long-term project? (1 is at the start, 10 is at the end)',
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
    question: 'Do you prefer to frontload work, or even spread or procrastinate?(1 is frontload, 10 is procrastinate)',
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
    question: 'What time of day do you work best (rankings-based) (i.e. morning, afternoon, evening, early night, middle of night, early morning)',
    answers: [
      '5 a.m. to 8 a.m. (early morning)',
      '8 a.m. to 12 p.m. (late morning)',
      '12 p.m. to 3 p.m. (afternoon)',
      '3p.m. to 6p.m. (early evening)',
      '6p.m. to 9p.m. (late evening)',
      '9p.m. to 12p.m. (Night)',
      '12a.m. to 5a.m. (Late night/very early morning)',
    ],
    selectedAnswer: null,
  ),
  //Add more questions here when the quiz is finalzed
];
}


