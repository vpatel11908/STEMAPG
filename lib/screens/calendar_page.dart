import 'package:flutter/material.dart';
import 'package:stemcalendar/data/projects.dart';
import 'package:stemcalendar/screens/make_new_task.dart';
import 'package:stemcalendar/screens/project_page.dart';
import '../data/calendar.dart';
import '../data/projectList.dart';

// Ensure CalendarInfo is imported if it exists in another file
// import 'package:stemcalendar/screens/calendar_info.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    //widget that allows the user to see the list of tasks and when they should be completed by 
    //in the future, this would be a calendar or allow the user to pair the app with their calendar

    // Create the Calendar object here
    List<double>hoursAvailable=[];
    for(int i = 0; i<100; i++){
      hoursAvailable.add(100);
    }
    List<Project> Pjl = ProjectList.getProjectList(); 
    if (Pjl.isEmpty) {
      return const Center(
        child: Text('Please add a project first!'),
      );
    }
    
    Project projectCalendar =  Project("Name", "DueDate", "Duration");
    List<double> finalHoursList = projectCalendar.generateProjectSchedule(1, 100, 1);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Page'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Center(
            child: Column(
              children: <Widget>[
                if (ProjectList.getProjectList().isEmpty) ...[
                  const Text('Please add a project first!'),
                  const SizedBox(height: 100),
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
                    child: const Text('Add a new Project'),
                  ),
                ] else ...[
                  Column(
                    children: <Widget>[
                      for (int i = 0; i < Pjl.length; i++)
                        Card(
                          child: ListTile(
                            title: Text(Pjl[i].getName()),
                            subtitle: Text(Pjl[i].getProjectDueDate().toString()),
                            trailing: const Icon(Icons.info),
                            onTap: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProjectPage(project: Pjl[i]),
                                  ),
                                );
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20), // Spacing between lists
                  Column(
                    children: <Widget>[
                      for (int i = 0; i < finalHoursList.length; i++)
                        Card(
                          child: ListTile(
                            title: Text('Day ${i + 1}'),
                            subtitle: Text('Work hours: ${finalHoursList[i]}'),
                            trailing: const Icon(Icons.info),
                          ),
                        ),
                  ],
                ),
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
                  },
                  child: const Text('Add a new Project'),
                ),
                  //displays the list of projects as cards that can be clicked on to view the project page for that project
                /*
                ElevatedButton( 
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CalendarInfo(),
                        ),
                      );
                    }); 
                  },
                  child: const Text('Calendar Info'),
                ),
                */
              ],
            
            ],
            ),
          ),
        ],
      ),
    );
  }
}  