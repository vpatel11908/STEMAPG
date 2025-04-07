import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    const MaterialApp(
      title: 'Navigation Basics', 
      home: MainApp(),
    ),
  );
  double motivation = 5;
  double sessionLength = 1;
  double timePeriod = 10;
  double maxVal = 100;
  List<double> curveValues = BackendSCurve.implement(motivation, sessionLength, timePeriod, maxVal);
  print('$curveValues');
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  


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
