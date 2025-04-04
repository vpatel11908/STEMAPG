import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Navigation Basics', 
      home: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  final double motivation = 5;
  final double sessionLength = 10;
  final double timePeriod = 100;
  final double maxVal = 100;

  double calculateMidpoint() {
    if (motivation < 3.5) {
      return timePeriod / 4;
    } else if (motivation >= 3.5 && motivation < 7) {
      return timePeriod / 2;
    } else {
      return timePeriod * 3 / 4;
    }
  }
  
   double calculateGrowthRate() {
  if (motivation < 3.5) {
    return 0.06;
  } else if (motivation >= 3.5 && motivation < 7) {
    return 0.12;
  } else {
    return 0.20;
  }
}

  //algorithm to baisically make the s curve but it doesnt rlly do the calendar stuff yet
  
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
                        MaterialPageRoute(builder: (context) => const CreateAccountPage()),
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
            SizedBox(
              width: 200,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter username',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter password',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an Account'),
      ),
      body: Center(
        child: SizedBox(
          width: 800,
          child: Text('To create an account, we ask you to take a short quiz about your work/learning styles so we can personalize your schedule. To start the quiz, click the button below'), //switch to quiz 
        ),
      ),
    );
  }
}
