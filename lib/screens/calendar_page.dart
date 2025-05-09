
import 'package:flutter/material.dart';
import 'package:stemcalendar/data/projects.dart';
import 'package:stemcalendar/screens/make_new_task.dart';
import 'package:stemcalendar/screens/project_page.dart';


class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  
  
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Widget? activeWidget;
  String? get key => null;

  @override
  Widget build(BuildContext context) {
    //widget that allows the user to see the list of tasks and when they should be completed by 
    //in the future, this would be a calendar or allow the user to pair the app with their calendar

    // Create the Calendar object here
    List<double>hoursAvailable=[];
    for(int i = 0; i<100; i++){
      hoursAvailable.add(100);
    } 
    //Calendar projectCalendar = Calendar();
    //List<double> finalHoursList = projectCalendar.fixCalendar(1, 100, 100, 1, 100, hoursAvailable);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Page'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
      Center( 
        child: 
        Column(
          children: <Widget>[
            if (projectsByName.isEmpty) ...[
                  const Text('Please add a project first!'),
                  SizedBox(height: 75),
                  ElevatedButton( //button to add a new project
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MakeNewTaskPage(),
                          ),
                        );
                      });
                    }, child: Text('Add New Project'),
                  ),
                ],
            if  (projectsByName.isNotEmpty) ...[
              Column(
                children: <Widget>[
                  for (var entry in projectsByName.entries)
                    Card(
                      child: ListTile(
                        title: Text(entry.value.getName()), // Use the value's method to get the name
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProjectPage(project: entry.value), 
                            ),
                          );
                        },
                      ),
                    ),
                  ElevatedButton(
                    onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MakeNewTaskPage(),
                            ),
                          );
                        });
                      }, 
                      child: const Text('Add another project'),
                  ),
                ],
              ),
            ],
          ],
        ),
          ),
        ],
      ),
    ); 
  }   
}                       