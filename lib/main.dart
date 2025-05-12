import 'package:flutter/material.dart';
import 'package:stemcalendar/data/projectList.dart';
import 'package:stemcalendar/screens/calendar_page.dart';
import 'package:stemcalendar/screens/make_new_task.dart';
import 'data/calendar.dart';
import 'data/project_registry.dart';

//ensure the shared preferneces are initialized and loaded into the project list, then run the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final registry = ProjectRegistry();
  await registry.loadProjectsFromSharedPreferences();
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: MainApp(),
     theme: ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 226, 227, 197)),
  ));

  //s-curve data
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
  //Prints out the minutes of work to be done like each day --- the check for if it can fit within the allotted hours will be added after the MVP
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

  //the home page of the app
   @override
     Widget build(BuildContext context) { 
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
                  Icons.edit_calendar, //icon for the app
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
                      //make sure the user has created a project before they can access the calendar
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

