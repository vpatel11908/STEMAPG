import 'package:flutter/material.dart';

void main() {
  runApp(
    MainApp(),
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
    return MaterialApp(
      title: 'STEM Project Planner',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Icon(
                  Icons.edit_calendar, // will be changed to the logo once we make one
                  color: Color.fromARGB(255, 58, 110, 222),
                  size: 150,
                ),
              ),
              Text(
                'Variny Project Planner',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 20), // Add spacing between the text and the row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for the first button here
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(width: 20), // Add spacing between the buttons
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for the second button here
                    },
                    child: Text('Create Account'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
