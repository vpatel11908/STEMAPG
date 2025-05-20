import 'package:flutter/material.dart';
import 'package:stemcalendar/data/project.dart';
import 'package:stemcalendar/data/project_registry.dart';
import 'package:stemcalendar/screens/project_page.dart';
import '../data/projectList.dart';

//page to show the list of projects and their due dates, as well as the chunks of time that the user must work on the project per day
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

//creates the calendar page and allows the user to see the list of projects and their due dates and go to the add new project page
class _CalendarPageState extends State<CalendarPage> with WidgetsBindingObserver {
  late ProjectRegistry registry;
  Widget? activeWidget;
  String? get key => null;

  //helper method that watches the state of the app 
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initProjectRegistry();
  }

  //initializes the project registry and loads the projects from shared preferences on the opening of this screen
   Future<void> _initProjectRegistry() async {
    registry = await ProjectRegistry.create();
    await registry.loadProjectsFromSharedPreferences();
    setState(() {});
  } 

  //saves the app when the observer notices that the app is closed or open in the background 
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

    //The calendar list page
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
                      //display each project in the project list
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
                ],
              ),
            ),
          ],
       ),
     );
   }
}
                  