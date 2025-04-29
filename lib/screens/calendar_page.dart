import 'package:flutter/material.dart';
import 'package:stemcalendar/data/projects.dart';
import 'package:stemcalendar/screens/make_new_task.dart';
import 'package:stemcalendar/main.dart';
import 'package:stemcalendar/screens/project_page.dart';


class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Widget? activeWidget;

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
            if (Project.projectList.isEmpty) ...[
                  const Text('Please add a project first!'),
                  SizedBox(height: 100),
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
            ]
            else ...[
            Column(
              children: <Widget>[
                for (int i = 0; i < Project.projectList.length; i++)
                //display the list of projects as cards that can be clicked on to view the project page
                Card(
                  child: ListTile(
                    title: Text(Project.projectList[i].getName()),
                    subtitle: Text(Project.projectList[i].getProjectDueDate()),
                    trailing: Text(Project.projectList[i].getDuration()),
                    /*
                    Add this when the project page is created
                    onTap: () {
                      setState(() {
                        activeWidget = const ViewProjectPage();
                      });
                    },
                    */
                    onTap: () {
                        setState(() {
                          if (i < Project.projectList.length) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProjectPage(project: Project.projectList[i]),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Invalid project index'),
                              ),
                            );
                          }
                    const SizedBox(height: 20);// Spacing between lists
                    },
                    
                  ); 
                  },
                  ),
                ),
                Column(
                  children: <Widget>[
                    for (int i = 0; i < Project.projectList.length; i++)
                      for (int j = 0; j < int.parse(Project.projectList[i].getDuration()); j++)
                        Card(
                          child: ListTile(
                            title: Text('Day ${j + 1} for Project ${i + 1}'),
                            subtitle: Text('Details for calendar item ${j + 1}'),
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
            ),
            ]
          ],
        ),
        ),
        ],
      ),
    );
  }
}

//shared preferences to store the data
//add text telling what the user should imput in the make new task page
