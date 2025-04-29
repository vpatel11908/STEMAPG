import 'package:flutter/material.dart';
import 'package:stemcalendar/data/projects.dart';
import 'package:stemcalendar/screens/make_new_task.dart';
import 'package:stemcalendar/main.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Widget? activeWidget;

  @override
  Widget build(BuildContext context) {
    // Create the Calendar object here
    List<double>hoursAvailable=[];
    for(int i = 0; i<100; i++){
      hoursAvailable.add(100);
    }
    Calendar projectCalendar = Calendar();
    List<double> finalHoursList = projectCalendar.fixCalendar(1, 100, 100, 1, 100, hoursAvailable);

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
                Column(
                  children: <Widget>[
                    for (int i = 0; i < Project.projectList.length; i++)
                      Card(
                        child: ListTile(
                          title: Text(Project.projectList[i].getName()),
                          subtitle: Text(Project.projectList[i].getProjectDueDate()),
                          trailing: Text(Project.projectList[i].getDuration()),
                          // Uncomment and update when the project page is created
                          // onTap: () {
                          //   setState(() {
                          //     activeWidget = const ViewProjectPage();
                          //   });
                          // },
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}