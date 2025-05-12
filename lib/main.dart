import 'package:flutter/material.dart';
import 'package:stemcalendar/data/projectList.dart';
import 'package:stemcalendar/screens/calendar_page.dart';
import 'package:stemcalendar/screens/make_new_task.dart';
import 'package:stemcalendar/screens/questions_screen.dart';
import 'data/calendar.dart';
import 'data/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final registry = ProjectRegistry();
  await registry.loadProjectsFromSharedPreferences();
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: MainApp(),
     theme: ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 226, 227, 197)),
  ));

  double motivation = 1;
  double sessionLength = 1;
  double timePeriod = 100;
  double maxVal = 100;
  double totalLength = 100;
  List<double> hoursAvailable = [];
  for(int i = 0; i<100; i++){
    hoursAvailable.add(100);
  }
  Calendar calendar = Calendar();
  //Prints out the minutes of work to be done like each day --- the check for if it can fit within the allotted hours still needs to be added
  List<double> curveValues = calendar.fixCalendar(sessionLength, timePeriod, maxVal, motivation, totalLength, hoursAvailable);
  print('Minutes: $curveValues');
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  //algorithm to make the s curve
List<double> sCurveValues(double maxVal, double midpoint, double growthRate, double endPeriod) {
  List<double> values = [];
  for (double t = 0; t <= endPeriod; t++) {
    double sCurveValue = maxVal / (1 + ((maxVal - 1) / midpoint) * (1 - (1 / (1 + growthRate * t))));
    values.add(sCurveValue);
  }
  return values;
}

   @override
     Widget build(BuildContext context) { //the home page of the app
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 226, 227, 197),
      ),
      body:
      ListView(
        physics: const BouncingScrollPhysics(),
        children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Icon(
                  Icons.edit_calendar, // will be changed to the logo if we make one
                  color: Color.fromARGB(255, 70, 52, 237),
                  size: 150,
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Text(
                  'Variny Project Planner',
                  style: TextStyle(
                    fontSize: 30
                    ),
              ),
               ),
              SizedBox(height: 20), 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton( //button to navigate to the make new task page
                    onPressed: () {
                      Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const MakeNewTaskPage()),
                    );
                    },
                    child: Text('Make a new task'),
                  ),
                  SizedBox(width: 40), 
                  ElevatedButton( //button to navigate to the calendar page
                    onPressed: () {
                       if(ProjectList.projects.isEmpty) {
                        const emptyList = SnackBar(
                        content:Text('Please create a project first!'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                        elevation: 10,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(emptyList);
                       }
                      else{
                      Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const CalendarPage()),
                        );
                      }
                    },
                    child: Text('Calendar'),
                  ),
                ],
              ),
            ],
          ),
        ),
        ]
      )
    );
      }
}

//Login page - this page would be used to log in to an existing account, then navigate to the main app (got rid of this and store the data locally)
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// Widget to log in to an account
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final secondController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login to your account'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0), 
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
              SizedBox(height: 20), 
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    TextField( //username field
                      controller: textController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter username',
                      ),
                    ),
                    SizedBox(height: 20), 
                    TextField( //password field 
                      controller: secondController, 
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter password',
                      ),
                      obscureText: true, 
                    ),
                    SizedBox(height: 20), 
                    ElevatedButton(
                      onPressed: () {
                        var username = textController.text;
                        var password = secondController.text;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MainApp()),//change to some way to save the login info and move to the create task page
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

//Starts the proccess of creating an account by having the user start a work/learning style quiz
// This page is the first step in creating an account
class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

//Widget to create an account by having the user start a work/learning style quiz
  @override
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
                SizedBox(height: 20), 
                ElevatedButton( // button to start the quiz that navigates to the QuestionsScreen
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QuestionsScreen()),
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