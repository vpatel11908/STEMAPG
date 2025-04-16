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
      body: Center(
        child: 
        Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Card(
                  child: ListTile(
                    title: Text(Project.projectList[0].getName()),
                    subtitle: Text(Project.projectList[0].getProjectDueDate()),
                    trailing: Text(Project.projectList[0].getDuration()),
                    /** 
                     * Add this in when a view project page is created
                    onTap: () {
                      setState(() {
                        activeWidget = const ViewProjectPage();
                      });
                    },
                    */
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
                  child: const Text('Add a new task'),
                ),
              ],
            ),
          ],
        ),
        ),
    );
  }   
}