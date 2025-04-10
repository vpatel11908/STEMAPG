import 'package:flutter/material.dart';
import 'dart:math';
import 'package:stemcalendar/screens/questions_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Navigation Basics', 
      home: MainApp(),
    ),
  );
  double motivation = 10;
  double sessionLength = 1;
  double timePeriod = 100;
  double maxVal = 100;
  double totalLength = 100;
  Calendar calendar = Calendar();
  List<double> curveValues = calendar.generateCalendar(sessionLength, timePeriod, maxVal, motivation, totalLength);
  print('Minutes: $curveValues');
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  //algorithm to basically make the s curve but it doesnt really do the calendar stuff yet
  
List<double> sCurveValues(double maxVal, double midpoint, double growthRate, double endPeriod) {
  List<double> values = [];
  for (double t = 0; t <= endPeriod; t++) {
    double sCurveValue = maxVal / (1 + ((maxVal - 1) / midpoint) * (1 - (1 / (1 + growthRate * t))));
    values.add(sCurveValue);
  }
  return values;
}

   @override
     Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),  
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Icon(
                  Icons.edit_calendar, // will be changed to the logo once we make one
                  color: Color.fromARGB(255, 70, 52, 237),
                  size: 150,
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Text(
                  'Variny Project Planner',
                  style: TextStyle(fontSize: 30),
              ),
               ),
              SizedBox(height: 20), // Add spacing between the text and the row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(width: 40), // Add spacing between the buttons
                  ElevatedButton(
                    onPressed: () {
                       Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => CreateAccountPage()),
                    );
                    },
                    child: Text('Create Account'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login to your account'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Add padding around the entire content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Please enter your username and password',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20), // Space between text and input fields
              SizedBox(
                width: 300, // Increase width for better spacing
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter username',
                      ),
                    ),
                    SizedBox(height: 20), // Space between username and password fields
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter password',
                      ),
                      obscureText: true, // Hide password input
                    ),
                    SizedBox(height: 20), // Space between password field and button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MainApp()),//change to some way to save the login info and move to the create task page
                        //  Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateTaskPage()),);
                        );
                      },
                      child: Text('Enter'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateAccountPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an Account'),
      ),
      body: Center(
        child: SizedBox(
          width: 800,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'To create an account, we ask you to take a short quiz about your work/learning styles so we can personalize your schedule. To start the quiz, click the button below.',
                ),
                SizedBox(height: 20), // Space between text and button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QuizPage()),
                    );
                  },
                  child: Text('Start Quiz'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class BackendSCurve {
  // Method to calculate the midpoint
  static double calculateMidpoint(double motivation, double timePeriod) {
    if (motivation < 3.5) {
      return timePeriod / 4;
    } else if (motivation >= 3.5 && motivation < 7) {
      return timePeriod / 2;
    } else {
      return timePeriod * 3 / 4;
    }
  }

  // Method to calculate the growth rate
  static double calculateGrowthRate(double sessionLength) {
    if (sessionLength < 3.5) {
      return 0.06;
    } else if (sessionLength >= 3.5 && sessionLength < 7) {
      return 0.12;
    } else {
      return 0.20;
    }
  }

  // Calcuates S-Curve values
  static List<double> sCurveValues(double maxVal, double midpoint, double growthRate, double endPeriod) {
    List<double> values = [];
    for (double t = 0; t <= endPeriod; t++) {
      double sCurveValue = maxVal / (1 + exp(-growthRate*(t-midpoint)));
      values.add(sCurveValue);
    }
    return values;
  }

  // Implements S-Curve calculatoin
  static List<double> implement(double sessionLength, double motivation, double maxVal, double timePeriod) {
    // Calculates growth rate
    double growthRate = calculateGrowthRate(sessionLength);

    // Calculates midpoint
    double midpoint = calculateMidpoint(motivation, timePeriod);

    // Generates S-curve values
    return sCurveValues(maxVal, midpoint, growthRate, timePeriod);
  }
}

class Calendar {
  List<double> generateCalendar(sessionLength, timePeriod, maxVal, motivation, totalLength){
    List<double> slopes = [];
    // Calculates the slope of the S-Curve at each time point by using the derivative
    for (int t = 1; t < timePeriod; t++) {
      double exponent = exp(-BackendSCurve.calculateGrowthRate(sessionLength)*(t-BackendSCurve.calculateMidpoint(motivation, timePeriod)));
      double slope = (maxVal * BackendSCurve.calculateGrowthRate(sessionLength) * exponent) / pow(1 + exponent, 2);
      slopes.add(slope);
    }
    // Adds all the slopes to a new list
    double sum = 0;
    for (int i = 0; i<slopes.length; i++){
      sum += slopes[i];
    }
    // Normalizes the slopes to all represent the amount of minutes of work needed to be done at that point on the time interval (this will represent a day)
    double sessionsAVGSlope = sum/totalLength;
    for(int i = 0; i<slopes.length; i++){
      slopes[i] = slopes[i]/sessionsAVGSlope;
      slopes[i] *= 60;
      slopes[i] = (slopes[i]).roundToDouble();
    }
    return slopes;
  }
}

class QuizPage extends StatefulWidget {
   const QuizPage({super.key});
    @override
    State<QuizPage> createState() => _QuizPageState(); 
  }

class _QuizPageState extends State<QuizPage> {
  Widget? activeWidget;

  @override 
  void initState() {
    super.initState();
    activeWidget = Center(
      child: Text('Quiz Page Content'),
    );
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
        title: Text('Quiz'),
       ),
      body:
       ListView(
        physics: const BouncingScrollPhysics(),
        children: [
       Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Add padding around the entire content
          child: Column(
            mainAxisSize: MainAxisSize.min, // Use min to fit the content
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start for better spacing
            children: [
         Padding(
           padding: const EdgeInsets.only(bottom: 20.0),
           child: Text(
             'Please answer the following questions:',
             style: TextStyle(fontSize: 20),
           ),
         ),
         SizedBox(
           width: MediaQuery.of(context).size.width * 0.50, // Set height to 80% of screen height
           height: MediaQuery.of(context).size.height * 0.50, // Set height to 80% of screen height
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center, // Align items to the start for better spacing
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Insert quiz question here when the quiz is made'),
          ),
          SizedBox(height: 10), // Space between question and button
          
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Answer 3'), // Change to the actual answer (each answer corresponds to a different category for the creation of the s-curve) 
           ),
          ),
          
          SizedBox(height: 30), // Space between button and next question
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text('Another question to insert'),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your answer',
            ),
          ),
             ],
           ),
         ),
            ],
          ),
        ),
      ),
        ],
      ),
    );
  }
}

