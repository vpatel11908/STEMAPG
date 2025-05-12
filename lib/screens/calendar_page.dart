import 'package:flutter/material.dart';
import 'package:stemcalendar/data/projects.dart';
import 'package:stemcalendar/data/shared_preferences.dart';
import 'package:stemcalendar/screens/make_new_task.dart';
import 'package:stemcalendar/screens/project_page.dart';
import '../data/projectList.dart';

//page to show the list of projects and their due dates, as well as the chunks of time that the user must work on the project per day
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with WidgetsBindingObserver {
  late ProjectRegistry registry;
  Widget? activeWidget;
  String? get key => null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initProjectRegistry();
  }

   Future<void> _initProjectRegistry() async {
    registry = await ProjectRegistry.create();
    await registry.loadProjectsFromSharedPreferences();
    setState(() {});
  } 

  //saves the app when it is closed or in the backgronund
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      registry.saveProjectsToSharedPreferences(); 
    }
  }

  @override
  //widget that allows the user to see the list of tasks and when they should be completed by 
  Widget build(BuildContext context) {
    //in the future, this would be a calendar or allow the user to pair the app with their calendar

    // Create the Calendar object here
    List<double>hoursAvailable=[];
    for(int i = 0; i<100; i++){
      hoursAvailable.add(100);
    }
    List<Project> Pjl = ProjectList.getProjectList(); 
    if (Pjl.isEmpty) {
      return const Center(
        child: Text('Please add a project first!'), //make a snackbar
      );
    }
    
    Project projectCalendar =  Project("Name", "2025-05-23", "Duration");
    List<double> finalHoursList = projectCalendar.generateProjectSchedule(1, 100, 1);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Page'),
        backgroundColor: Color.fromARGB(255, 226, 227, 197)
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Center(
            child: Column(
              children: <Widget>[
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
                    ]
                  ),
                  const SizedBox(height: 20), // Spacing between cards
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}  