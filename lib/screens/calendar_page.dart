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
  
  @override
  //widget that allows the user to see the list of tasks and when they should be completed by 
  //in the future, this would be a calendar or allow the user to pair the app with their calendar
  Widget build(BuildContext context) {
    int i = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Page'),
      ),
      body:
      ListView(
        physics: const BouncingScrollPhysics(),
        children: [
      Center( 
        child: 
        Column(
          children: <Widget>[
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
                else ...[   //displays the list of projects as cards that can be clicked on to view the project page for that project
                for (int index = 0; index < Project.projectList.length; index++) ...[
                  Card(
                    child: ListTile(
                      title: Text(Project.projectList[index].getName()),
                      subtitle: Text(Project.projectList[index].getProjectDueDate()),
                      trailing: Text(Project.projectList[index].getDuration()),
                      onTap: () {
                        setState(() {
                          if (index < Project.projectList.length) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProjectPage(project: Project.projectList[index]),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Invalid project index'),
                              ),
                            );
                          }
                        });
                      },
                    ),
                  ),
                ],
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
              ],
            ),
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
