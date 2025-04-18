import 'package:flutter/material.dart';
import 'package:stemcalendar/data/projects.dart';
import 'package:stemcalendar/screens/make_new_task.dart';


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
                    ),
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
                  ElevatedButton( //button to go back to the main page
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: const Text('Back to Main Page'),
                  ),
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