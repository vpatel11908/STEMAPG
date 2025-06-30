import 'package:flutter/material.dart';
import 'package:stemcalendar/data/project.dart';
import 'package:stemcalendar/data/project_registry.dart';
import 'package:stemcalendar/screens/make_new_task.dart';
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
  List<Project> Pjl = ProjectList.getProjectList(); 
  Widget? activeWidget;
  String? get key => null;

  //method that watches the state of the app 
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

  } 
  
  //allows the user to remove the project from the list of projects
  void _removeProject(Project project) {
  Pjl.remove(project); 
  setState(() {
    registry.removeProject(project);
  });
}


  //saves the app when the observer notices that the app is closed or open in the background 
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      registry.saveProjectsToSharedPreferences(); 
    }
  }

  Future<void> _refreshProjects() async {
    setState(() {
      Pjl = ProjectList.getProjectList(); // Refresh the project list
    });
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

    // if the list is empty, display a message to the user telling them to adda project before trying to view the calendar
    //handles the case where the user deletes all projects in the calendar page while in the calendar page
    if (Pjl.isEmpty) {
      return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Page'),
        backgroundColor: Color.fromARGB(255, 226, 227, 197)
      ),
      body: 
      RefreshIndicator(
        onRefresh: _refreshProjects,
        child:
      ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Center(
            child: Column(
              children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('No projects available'),
                      SizedBox(height: 20), 
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
                        child: const Text('Add New Project'),
                      ),
                    ]
                  ),
                ],
              ),
            ),
          ],
       ),
      ),
      );
    }
           

    //The calendar list page
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Page'),
        backgroundColor: Color.fromARGB(255, 226, 227, 197)
      ),
      body: 
      RefreshIndicator(
        onRefresh: _refreshProjects,
        child:
      ListView(
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
                            trailing: 
                            CheckboxWidget(
                              project: Pjl[i], 
                              onProjectRemoved: () { 
                                _removeProject(Pjl[i]); // Remove the project from the list
                                _refreshProjects(); // Refresh the project list
                               },
                            ),
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MakeNewTaskPage(),
                        ),
                      );
                    },
                    child: Text('Add a new project'),
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

class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget({super.key, required this.project, required this.onProjectRemoved});
  final Project project; // The project associated with this checkbox
  final VoidCallback onProjectRemoved; // Callback to notify the parent to refresh projects

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();

}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.project.isCompleted,
      onChanged: (bool? value) {
        if (!mounted) return; 
        setState(() {
          widget.project.isCompleted = value ?? true;
        });

        if (widget.project.getIsCompleted()) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.onProjectRemoved();
          });
        }
      },
    );
  }
}
